//
//  CalendarViewController.swift
//  Housing
//
//  Created by 오준현 on 2021/01/01.
//

import UIKit

import FSCalendar

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
		collectionView.backgroundColor = .white
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
	
	// MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		layout()
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		navigationController?.setNavigationBarHidden(true, animated: true)
	}
	
	// MARK: - Helper
	
	private func layout() {
		view.add(collectionView) {
			$0.snp.makeConstraints {
				$0.edges.equalTo(self.view.safeAreaLayoutGuide)
			}
			$0.delegate = self
			$0.dataSource = self
		}
	}
	
}

// MARK: - Scroll

extension CalendarViewController: UIScrollViewDelegate {
//	func scrollViewDidScroll(_ scrollView: UIScrollView) {
//		if scrollView.contentOffset.y > 100 {
//			collectionView.backgroundColor = .primaryGray
//		} else {
//			collectionView.backgroundColor = .white
//		}
//	}
}

// MARK: - CollectionView

extension CalendarViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView,
											didSelectItemAt indexPath: IndexPath) {
		let viewController = DetailViewController()
		navigationController?.pushViewController(viewController, animated: true)
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
		return 5
	}
	
	func collectionView(_ collectionView: UICollectionView,
											cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if indexPath.row%2 == 0 {
			let cell: CalendarCollectionViewCell = collectionView.dequeueCell(forIndexPath: indexPath)
			return cell
		} else {
			let cell: NoticeCollectionViewCell = collectionView.dequeueCell(forIndexPath: indexPath)
			return cell
		}
	}
	
}

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView,
											layout collectionViewLayout: UICollectionViewLayout,
											sizeForItemAt indexPath: IndexPath) -> CGSize {
		if indexPath.row%2 == 0 {
			return CGSize(width: view.frame.width, height: 112)
		} else {
			return CGSize(width: view.frame.width, height: 94)
		}
	}
}

// MARK: - CalendarDelegate

extension CalendarViewController: FSCalendarDelegate { }

extension CalendarViewController: FSCalendarDataSource { }

extension CalendarViewController: FSCalendarDelegateAppearance { }
