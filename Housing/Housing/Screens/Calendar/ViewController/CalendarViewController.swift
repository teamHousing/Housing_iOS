//
//  CalendarViewController.swift
//  Housing
//
//  Created by 오준현 on 2021/01/01.
//

import UIKit

import FSCalendar
import Moya
import RxMoya
import RxSwift
import RxCocoa

final class CalendarViewController: BaseViewController {
	
	// MARK: - Component
	
	private let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.minimumLineSpacing = 0
		layout.minimumInteritemSpacing = 0
		let screenSize = UIScreen.main.bounds
		layout.headerReferenceSize = CGSize(width: screenSize.width,
																				height: 566)
		let collectionView = UICollectionView(frame: .zero,
																					collectionViewLayout: layout)
		collectionView.scrollIndicatorInsets = .zero
		collectionView.backgroundColor = .primaryGray
		collectionView.register(
			EmptyCalendarCollectionViewCell.self,
			forCellWithReuseIdentifier: EmptyCalendarCollectionViewCell.reuseIdentifier)
		collectionView.register(CalendarCollectionViewCell.self,
														forCellWithReuseIdentifier: CalendarCollectionViewCell.reuseIdentifier)
		collectionView.register(NoticeCollectionViewCell.self,
														forCellWithReuseIdentifier: NoticeCollectionViewCell.reuseIdentifier)
		collectionView.register(CalendarCollectionReusableView.self,
														forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
														withReuseIdentifier: CalendarCollectionReusableView.reuseIdentifier)
		
		return collectionView
	}()
	
	private let guideLabel = UILabel().then {
		$0.text = "Calendar"
		$0.textColor = .primaryBlack
		$0.font = BaskervilleFont.bold.of(size: 40)
	}
	private let guideUnderBarView = UIView().then {
		$0.backgroundColor = .primaryBlack
	}
	private let myCircleView = UIView().then {
		$0.backgroundColor = .primaryOrange
		$0.layer.cornerRadius = 2.5
	}
	private let myGuideLabel = UILabel().then {
		$0.text = "나"
		$0.font = .systemFont(ofSize: 12, weight: .regular)
		$0.layer.cornerRadius = 2.5
	}
	private let noticeCircleView = UIView().then {
		$0.backgroundColor = .periwinkleBlue
		$0.layer.cornerRadius = 2.5
	}
	private let noticeGuideLabel = UILabel().then {
		$0.text = "공지사항"
		$0.textColor = .primaryBlack
		$0.font = .systemFont(ofSize: 12, weight: .regular)
		$0.layer.cornerRadius = 2.5
	}
	private let calendarView = FSCalendar(frame: .zero).then {
		$0.appearance.headerDateFormat = "YYYY년 M월"
		$0.locale = Locale(identifier: "ko_KR")
		$0.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesSingleUpperCase]
		$0.appearance.selectionColor = .textGrayBlank
		$0.appearance.headerTitleColor = .primaryBlack
		$0.appearance.headerMinimumDissolvedAlpha = 0.0
		$0.appearance.weekdayFont = .systemFont(ofSize: 14, weight: .light)
		$0.appearance.todayColor = .black
		$0.appearance.todaySelectionColor = .textGrayBlank
		$0.placeholderType = .none
		$0.appearance.headerTitleFont = .systemFont(ofSize: 14, weight: .regular)
	}
	private let dayScheduleBackgroundView = UIView().then {
		$0.backgroundColor = .primaryGray
	}
	private let dayScheduleLabel = UILabel().then {
		$0.textColor = .primaryBlack
		$0.text = "12월 24일의 일정"
		$0.font = .systemFont(ofSize: 13, weight: .bold)
	}
	
	// MARK: - Variable
	
	var dic: [String : [FSCalendarModel]] = [:]
	var day: String?
	let dateFormatter = DateFormatter()
	let dateFormatterForNotice = DateFormatter()
	let providerformatter = DateFormatter()

	// MARK: - Provider
	
	let calendarProvider = MoyaProvider<CalendarService>(plugins: [NetworkLoggerPlugin(verbose: true)])
	
	// MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		today()
		layout()
		communication(date: Date())
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		navigationController?.setNavigationBarHidden(true, animated: true)
	}
	
	// MARK: - Helper
	
	private func today() {
		let today = Date() //현재 시각 구하기
		dateFormatter.dateFormat = "yyyy.M.d"
		dateFormatterForNotice.dateFormat = "MM월 dd일"
		providerformatter.dateFormat = "yyyy.M"
		day = dateFormatter.string(from: today)
		let todayValue = dateFormatterForNotice.string(from: today)
		dayScheduleLabel.text = "\(todayValue)의 일정"
	}
	
	private func layout() {
		view.add(collectionView) {
			$0.snp.makeConstraints {
				$0.edges.equalTo(self.view.safeAreaLayoutGuide)
			}
			$0.delegate = self
			$0.dataSource = self
		}
	}
	
	private func communication(date: Date) {
		let todayDate = providerformatter.string(from: date)
		let dateArray = todayDate.split(separator: ".")
		guard let year = Int(dateArray[0]),
					let month = Int(dateArray[1]) else {
			return
		}
		calendarProvider.rx.request(.calendar(select_year: year, select_month: month))
			.asObservable()
			.subscribe(onNext: { response in
				do{
					let decoder = JSONDecoder()
					let data = try decoder.decode(ResponseType<CalendarData>.self,
																				from: response.data)
					guard let result = data.data else { return }
					self.calendarDataBind(result)
				} catch {
					print(error)
				}
			}, onError: { error in
				print(error.localizedDescription)
			}, onCompleted: {
				self.calendarView.reloadData()
				self.collectionView.reloadData()
			}).disposed(by: disposeBag)
	}
	
	private func calendarDataBind(_ data:CalendarData) {
		for notice in data.notice {
			let when = "\(notice.year).\(notice.month).\(notice.day)"
			let model = FSCalendarModel(isNotice: notice.isNotice,
																	id: notice.id,
																	category: notice.category,
																	solutionMethod: notice.solutionMethod,
																	time: notice.time,
																	title: notice.title,
																	contents: notice.contents)
			dic["\(when)"] = [model]
		}
		for promise in data.issue {
			let when = "\(promise.year).\(promise.month).\(promise.day)"
			let model = FSCalendarModel(isNotice: promise.isNotice,
																	id: promise.id,
																	category: promise.category,
																	solutionMethod: promise.solutionMethod,
																	time: promise.time,
																	title: promise.title,
																	contents: promise.contents)
			if dic[when]?.count == 0 {
				dic["\(when)"] = [model]
			} else {
				dic[when]?.append(model)
			}
		}
		
	}
}

// MARK: - Scroll

extension CalendarViewController: UIScrollViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		if scrollView.contentOffset.y > 10 {
			collectionView.backgroundColor = .primaryGray
		} else {
			collectionView.backgroundColor = .white
		}
	}
}

// MARK: - CollectionView

extension CalendarViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView,
											didSelectItemAt indexPath: IndexPath) {
		guard let day = day else { return }
		guard let promise: [FSCalendarModel] = dic[day] else { return }
		if promise[indexPath.row].isNotice == 0 {
			let viewController = DetailViewController()
			viewController.requestId = promise[indexPath.row].id
			navigationController?.pushViewController(viewController, animated: true)
		} else {
			let storyboard = UIStoryboard(name: StoryboardStorage.notice, bundle: nil)
			guard let viewController = storyboard
							.instantiateViewController(
								withIdentifier: "DetailNoticeViewController") as? DetailNoticeViewController
			else { return }
			viewController.id = promise[indexPath.row].id
			navigationController?.pushViewController(viewController, animated: true)
		}
	}
	
	func collectionView(_ collectionView: UICollectionView,
											viewForSupplementaryElementOfKind kind: String,
											at indexPath: IndexPath) -> UICollectionReusableView {
		
		switch kind {
		case UICollectionView.elementKindSectionHeader:
			let headerView: CalendarCollectionReusableView = collectionView.dequeueHeaderView(forIndexPath: indexPath)
			headerView.backgroundColor = .white
			headerView.adds([
				guideLabel,
				guideUnderBarView,
				myCircleView,
				myGuideLabel,
				noticeCircleView,
				noticeGuideLabel,
				calendarView,
				dayScheduleBackgroundView,
				dayScheduleLabel
			])
			calendarView.delegate = self
			calendarView.dataSource = self
			calendarView.appearance.weekdayTextColor = .brownishGrey
			
			guideLabel.snp.makeConstraints {
				$0.leading.equalTo(headerView.snp.leading).offset(20)
				$0.top.equalTo(headerView.snp.top).offset(44)
			}
			guideUnderBarView.snp.makeConstraints {
				$0.leading.equalTo(guideLabel.snp.trailing).offset(8)
				$0.height.equalTo(1)
				$0.trailing.equalToSuperview()
				$0.top.equalTo(headerView.snp.top).offset(80)
			}
			noticeGuideLabel.snp.makeConstraints {
				$0.trailing.equalToSuperview().offset(-20)
				$0.top.equalTo(guideLabel.snp.bottom).offset(31)
			}
			noticeCircleView.snp.makeConstraints {
				$0.centerY.equalTo(noticeGuideLabel)
				$0.trailing.equalTo(noticeGuideLabel.snp.leading).offset(-5)
				$0.width.height.equalTo(5)
			}
			myGuideLabel.snp.makeConstraints {
				$0.trailing.equalTo(noticeCircleView.snp.leading).offset(-9)
				$0.centerY.equalTo(noticeGuideLabel)
			}
			myCircleView.snp.makeConstraints {
				$0.centerY.equalTo(noticeGuideLabel)
				$0.trailing.equalTo(myGuideLabel.snp.leading).offset(-5)
				$0.width.height.equalTo(5)
			}
			calendarView.snp.makeConstraints {
				$0.top.equalTo(myGuideLabel.snp.bottom).offset(21)
				$0.leading.equalToSuperview().offset(20)
				$0.trailing.equalToSuperview().offset(-20)
				$0.height.equalTo(331)
			}
			dayScheduleBackgroundView.snp.makeConstraints {
				$0.top.equalTo(calendarView.snp.bottom).offset(26)
				$0.leading.trailing.equalTo(headerView)
				$0.bottom.equalTo(headerView)
			}
			dayScheduleLabel.snp.makeConstraints {
				$0.leading.equalTo(headerView).offset(20)
				$0.top.equalTo(dayScheduleBackgroundView.snp.top).offset(20)
			}
			
			return headerView
		default:
			return UICollectionReusableView()
		}
	}
}

extension CalendarViewController: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView,
											numberOfItemsInSection section: Int) -> Int {
		guard let day = day else {
			return 0
		}
		if dic[day]?.count == nil {
			return 1
		} else {
			if dic[day]?.count == 1 {
				collectionView.backgroundColor = .primaryGray
			}
			return dic[day]?.count ?? 0
		}
	}
	
	func collectionView(_ collectionView: UICollectionView,
											cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let day = day else {
			return UICollectionViewCell()
		}
		if dic[day]?.count == nil {
			let cell: EmptyCalendarCollectionViewCell = collectionView.dequeueCell(forIndexPath: indexPath)
			return cell
		} else {
			guard let promise: [FSCalendarModel] = dic[day] else { return UICollectionViewCell() }
			if promise[indexPath.row].isNotice == 0 {
				let cell: CalendarCollectionViewCell = collectionView.dequeueCell(forIndexPath: indexPath)
				cell.calendar = promise[indexPath.row]
				cell.fetchCalendar()
				cell.fetchCategory()
				cell.fetchTime()
				return cell
			} else {
				let cell: NoticeCollectionViewCell = collectionView.dequeueCell(forIndexPath: indexPath)
				cell.calendar = promise[indexPath.row]
				cell.fetchCalendar()
				cell.fetchTime()
				return cell
			}
		}
	}
}

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView,
											layout collectionViewLayout: UICollectionViewLayout,
											sizeForItemAt indexPath: IndexPath) -> CGSize {
		guard let day = day else {
			return CGSize(width: 0, height: 0)
		}
		if dic[day]?.count == nil {
			return CGSize(width: view.frame.width, height: view.frame.height - 558)
		} else {
			guard let promise: [FSCalendarModel] = dic[day] else { return CGSize(width: 0, height: 0) }
			if promise[indexPath.row].isNotice == 0 {
				return CGSize(width: view.frame.width, height: 112)
			} else {
				return CGSize(width: view.frame.width, height: 94)
			}
		}
	}
}

// MARK: - CalendarDelegate

extension CalendarViewController: FSCalendarDelegate {
	func calendar(_ calendar: FSCalendar,
								didSelect date: Date,
								at monthPosition: FSCalendarMonthPosition) {
		day = dateFormatter.string(from: date)
		let today = dateFormatterForNotice.string(from: date)
		dayScheduleLabel.text = "\(today)의 일정"
		collectionView.reloadData()
	}
	
	func calendar(_ calendar: FSCalendar,
								numberOfEventsFor date: Date) -> Int {
		let calendar = dateFormatter.string(from: date)
		return dic[calendar]?.count ?? 0
	}
	
	func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
		let currentDate = calendar.currentPage
		communication(date: currentDate)
	}
}

extension CalendarViewController: FSCalendarDataSource { }

extension CalendarViewController: FSCalendarDelegateAppearance {
	
	func calendar(_ calendar: FSCalendar,
								appearance: FSCalendarAppearance,
								eventDefaultColorsFor date: Date) -> [UIColor]? {
		let key = dateFormatter.string(from: date)
		let promise: [FSCalendarModel] = dic[key] ?? []
		var color: [UIColor] = []
		for atomic in promise {
			if atomic.isNotice == 0 {
				color.append(.primaryOrange)
			} else {
				color.append(.periwinkleBlue)
			}
		}
		if promise.count == 1 {
			return [color[0]]
		} else if promise.count == 2 {
			return [color[0], color[1]]
		} else {
			return nil
		}
	}
	
	func calendar(_ calendar: FSCalendar,
								appearance: FSCalendarAppearance,
								eventSelectionColorsFor date: Date) -> [UIColor]? {
		let key = dateFormatter.string(from: date)
		let promise: [FSCalendarModel] = dic[key] ?? []
		var color: [UIColor] = []
		for atomic in promise {
			if atomic.isNotice == 0 {
				color.append(.primaryOrange)
			} else {
				color.append(.periwinkleBlue)
			}
		}
		if promise.count == 1 {
			return [color[0]]
		} else if promise.count == 2 {
			return [color[0], color[1]]
		} else {
			return nil
		}
	}
}
