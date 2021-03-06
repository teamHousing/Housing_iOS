//
//  AppointmentViewController.swift
//  Housing
//
//  Created by 김태훈 on 2021/01/06.
//
import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then
import Moya

class AppointmentViewController: BaseViewController {
	// MARK: - Component
	var issue_id = RequestDataModel.shared.issueId
	var requestData = RequestDataModel.shared
	var registerID: Int?
	var checkToModify = 0
	private let promiseProvider = MoyaProvider<PromiseService>()

	private let appointmentScroll = UIScrollView()
	private let contentView = UIView()
	private var promiseArr: [[String]] = []
	
	private let backgroundLabel = UILabel().then {
		$0.text = "문제를 어떻게 해결할까요?"
		$0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 26)
		$0.textColor = .black
		$0.textAlignment = .left
	}
	private let lineImage = UIView().then {
		$0.backgroundColor = UIColor.primaryBlack
		$0.tintColor = UIColor.primaryBlack
	}
	private let comunicationType = UILabel().then{
		$0.text = "소통방식을 선택해주세요!"
		$0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
		$0.textColor = .black
		$0.textAlignment = .left
	}
	private let visitView = UIView().then{
		$0.backgroundColor = .white
		$0.setRounded(radius: 16)
		$0.setBorder(borderColor: .primaryOrange, borderWidth: 2)
		$0.isUserInteractionEnabled = true
		$0.isMultipleTouchEnabled = true
		let icon = UIImageView().then{
			$0.image = UIImage(named: "img4")
		}
		let description = UILabel().then {
			$0.text = "만나서 해결하고 싶어요"
			$0.textColor = .black
			$0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 13)
		}
		$0.adds([icon,description])
		icon.snp.makeConstraints{
			$0.trailing.equalToSuperview().offset(-8)
			$0.top.equalToSuperview().offset(4)
			$0.leading.equalToSuperview().offset(74)
			$0.bottom.equalToSuperview().offset(-60)
		}
		description.snp.makeConstraints{
			$0.trailing.equalToSuperview().offset(-23)
			$0.top.equalToSuperview().offset(88)
			$0.leading.equalToSuperview().offset(16)
			$0.bottom.equalToSuperview().offset(-24)
		}
	}
	
	private let phoneCallView = UIView().then{
		$0.backgroundColor = .white
		$0.setRounded(radius: 16)
		$0.setBorder(borderColor: .systemGray6, borderWidth: 1)
		$0.isUserInteractionEnabled = true
		$0.isMultipleTouchEnabled = true
		let icon = UIImageView().then{
			$0.image = UIImage(named: "img5")
		}
		let description = UILabel().then {
			
			$0.text = "전화로 해결하고 싶어요!"
			$0.textColor = .black
			
			$0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 13)
		}
		$0.adds([icon,description])
		icon.snp.makeConstraints{
			$0.trailing.equalToSuperview().offset(-8)
			$0.top.equalToSuperview().offset(4)
			$0.leading.equalToSuperview().offset(74)
			$0.bottom.equalToSuperview().offset(-60)
		}
		description.snp.makeConstraints{
			$0.trailing.equalToSuperview().offset(-23)
			$0.top.equalToSuperview().offset(88)
			$0.leading.equalToSuperview().offset(16)
			$0.bottom.equalToSuperview().offset(-24)
		}
		
	}
	
	private let pickDateLabel = UILabel().then{
		$0.text = "일자를 선택해주세요"
		$0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
		$0.textColor = .black
	}
	
	private let datePickerLabel = UILabel().then {
		$0.textColor = .textGrayBlank
		$0.text = "2021.01.16"
		$0.isUserInteractionEnabled = true
		$0.isMultipleTouchEnabled = true
		$0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 21)
	}
	private let underBar = UIView().then{
		$0.backgroundColor = .textGrayBlank
	}
	private let timeSelectLabel = UILabel().then{
		$0.text = "시간을 선택해 주세요!"
		$0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
		$0.textColor = .black
	}
	private let startHour = UITextField().then {
		$0.textColor = .textGrayBlank
		$0.text = "07시"
		$0.isUserInteractionEnabled = true
		$0.isMultipleTouchEnabled = true
		$0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 21)
	}
	private let startHourUnderBar = UIView().then{
		$0.backgroundColor = .textGrayBlank
	}
	
	private let endHour = UILabel().then {
		$0.textColor = .textGrayBlank
		$0.text = "17시"
		$0.isUserInteractionEnabled = true
		$0.isMultipleTouchEnabled = true
		$0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 21)
	}
	private let endHourUnderBar = UIView().then{
		$0.backgroundColor = .textGrayBlank
	}
	private let addButton = UIButton().then {
		$0.backgroundColor = .white
		
		$0.setTitle("추가하기", for: .normal)
		$0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 13)
		$0.setTitleColor(.gray01, for: .normal)
		$0.setRounded(radius: 25)
		$0.setBorder(borderColor: .gray01, borderWidth: 1)
		$0.addTarget(self, action: #selector(addTimeStamp(sender:)), for: .touchUpInside)
	}
	private let underGrayView = UIView().then{
		$0.backgroundColor = .primaryGray
		
	}
	let timeStampTableView = UITableView(frame: .zero).then{
		$0.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
		$0.backgroundColor = .primaryGray
		$0.isScrollEnabled = false
		$0.rowHeight = UITableView.automaticDimension
		$0.separatorStyle = .none
	}
	private let registerButton = UIButton().then {
		$0.backgroundColor = .gray01
		$0.setTitle("등록하기", for: .normal)
		$0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 13)
		$0.setTitleColor(.white, for: .normal)
		$0.setRounded(radius: 25)
	}
	private let page = UIPageControl().then{
		$0.numberOfPages = 4
		$0.currentPage = 3
		$0.currentPageIndicatorTintColor = .primaryOrange
		$0.tintColor = .gray01
		$0.pageIndicatorTintColor = .gray01
	}
	
	// MARK: - Helper
	private func widthConstraintAmount(value : CGFloat) -> CGFloat {
		let superViewWidth = self.view.frame.width
		
		return (value / 375) * superViewWidth
	}
	private func heightConstraintAmount(value : CGFloat) -> CGFloat {
		let superViewHeight = self.view.frame.height
		
		return (value / 1110) * superViewHeight
	}
	
	private func layout() {
		self.navigationController?.navigationBar.backgroundColor = .white
		self.view.backgroundColor = .white
		self.view.addSubview(appointmentScroll)
		appointmentScroll.snp.makeConstraints{
			$0.edges.equalToSuperview()
		}
		self.appointmentScroll.addSubview(contentView)
		contentView.snp.makeConstraints{
			$0.width.equalToSuperview().priority(1000)
			$0.centerX.top.bottom.equalToSuperview()
		}
		self.contentView.adds([
														backgroundLabel,
														lineImage,
														comunicationType,
														visitView,
														phoneCallView,
														pickDateLabel,
														datePickerLabel,
														underBar,
														timeSelectLabel,
														startHour,
														startHourUnderBar,
														endHour,
														endHourUnderBar,
														addButton,
														underGrayView])
		backgroundLabel.snp.makeConstraints{
			$0.top.equalToSuperview().offset(6)
			$0.leading.equalTo(view).offset(widthConstraintAmount(value: 20))
		}
		lineImage.snp.makeConstraints{
			$0.top.equalToSuperview().offset(28)
			$0.trailing.equalTo(view.safeAreaLayoutGuide).offset(0)
			$0.leading.equalTo(backgroundLabel.snp.trailing).offset(8)
			$0.height.equalTo(1)
		}
		registerButton.then {
			if self.checkToModify == 1 {
				$0.addTarget(self, action: #selector(modifyPromise), for: .touchUpInside)
				self.checkToModify = 0
			}
			else {
				$0.addTarget(self, action: #selector(addPromise), for: .touchUpInside)
			}
		}
		comunicationType.snp.makeConstraints{
			$0.leading.equalTo(view).offset(widthConstraintAmount(value: 20))
			$0.top.equalTo(backgroundLabel.snp.bottom).offset(60)
			$0.width.equalTo(widthConstraintAmount(value: 151))
		}
		requestData.solution = "집방문"
		visitView.snp.makeConstraints{
			$0.top.equalTo(comunicationType.snp.bottom).offset(24)
			$0.leading.equalTo(view).offset(widthConstraintAmount(value: 20))
			$0.width.equalTo(widthConstraintAmount(value: 162))
			$0.height.equalTo(visitView.snp.width).multipliedBy(1 / 1.125)
		}
		
		phoneCallView.snp.makeConstraints{
			$0.top.equalTo(comunicationType.snp.bottom).offset(24)
			$0.leading.equalTo(visitView.snp.trailing).offset(widthConstraintAmount(value: 12))
			$0.width.equalTo(widthConstraintAmount(value: 162))
			$0.height.equalTo(visitView.snp.width).multipliedBy(1 / 1.125)
			$0.centerY.equalTo(visitView)
		}
		pickDateLabel.snp.makeConstraints{
			$0.leading.equalTo(view).offset(20)
			$0.top.equalTo(visitView.snp.bottom).offset(64)
			$0.width.equalTo(widthConstraintAmount(value: 145))
		}
		
		datePickerLabel.snp.makeConstraints{
			$0.top.equalTo(pickDateLabel.snp.bottom).offset(28)
			$0.centerX.equalTo(view)
			$0.width.equalTo(widthConstraintAmount(value: 335))
			$0.height.equalTo(datePickerLabel.snp.width).multipliedBy(1 / 13.4)
		}
		underBar.snp.makeConstraints{
			$0.top.equalTo(datePickerLabel.snp.bottom).offset(6)
			$0.width.equalTo(datePickerLabel)
			$0.centerX.equalTo(view)
			$0.height.equalTo(2)
		}
		timeSelectLabel.snp.makeConstraints{
			$0.top.equalTo(underBar.snp.bottom).offset(64)
			$0.leading.equalTo(view).offset(widthConstraintAmount(value: 20))
			$0.height.equalTo(timeSelectLabel.snp.width).multipliedBy(1 / 6.95)
		}
		startHour.snp.makeConstraints{
			$0.top.equalTo(timeSelectLabel.snp.bottom).offset(28)
			$0.leading.equalTo(view).offset(20)
			$0.width.equalTo(widthConstraintAmount(value: 155))
			$0.height.equalTo(startHour.snp.width).multipliedBy(1 / 6.2)
		}
		startHourUnderBar.snp.makeConstraints{
			$0.top.equalTo(startHour.snp.bottom).offset(6)
			$0.width.equalTo(startHour)
			$0.centerX.equalTo(startHour)
			$0.height.equalTo(2)
			
		}
		endHour.snp.makeConstraints{
			$0.top.equalTo(timeSelectLabel.snp.bottom).offset(28)
			$0.trailing.equalTo(view).offset(-20)
			
			$0.width.equalTo(startHour)
			$0.height.equalTo(startHour)
		}
		endHourUnderBar.snp.makeConstraints{
			$0.top.equalTo(endHour.snp.bottom).offset(6)
			$0.width.equalTo(endHour)
			$0.centerX.equalTo(endHour)
			$0.height.equalTo(2)
		}
		addButton.snp.makeConstraints{
			$0.top.equalTo(endHour.snp.bottom).offset(72)
			$0.centerX.equalTo(view)
			$0.width.equalTo(widthConstraintAmount(value: 255))
			$0.height.equalTo(addButton.snp.width).multipliedBy(1 / 5.3215)
		}
		underGrayView.snp.makeConstraints{
			$0.top.equalTo(addButton.snp.bottom).offset(70)
			$0.leading.equalTo(view)
			$0.trailing.equalTo(view)
			$0.height.equalTo(CGFloat(70 * requestData.availableTimeList.count) + 300)
			$0.bottom.equalToSuperview().offset(44)
		}
		underGrayView.adds([timeStampTableView, registerButton, page])
		timeStampTableView.snp.makeConstraints{
			$0.top.equalTo(underGrayView.snp.top).offset(44)
			$0.leading.equalTo(view)
			$0.trailing.equalTo(view)
			$0.height.equalTo(CGFloat(70 * requestData.availableTimeList.count))
		}
		
		registerButton.snp.makeConstraints{
			$0.top.equalTo(timeStampTableView.snp.bottom).offset(60)
			$0.centerX.equalTo(view)
			$0.width.equalTo(widthConstraintAmount(value: 255))
			$0.height.equalTo(addButton.snp.width).multipliedBy(1 / 5.3215)
		}
		page.snp.makeConstraints{
			$0.top.equalTo(registerButton.snp.bottom).offset(24)
			$0.height.equalTo(20)
			$0.centerX.equalToSuperview()
		}
		let visitTapped = UITapGestureRecognizer(target: self, action: #selector(visitGesture(recognizer:)))
		let phoneCallTapped = UITapGestureRecognizer(target: self, action: #selector(phoneCallGesture(recognizer:)))
		visitView.addGestureRecognizer(visitTapped)
		phoneCallView.addGestureRecognizer(phoneCallTapped)
		
		let callDatePicker = UITapGestureRecognizer(target: self, action: #selector(callDatePickerView))
		let callStartTimePicker = UITapGestureRecognizer(target: self, action: #selector(callStartTimePickerView))
		let callEndTimePicker = UITapGestureRecognizer(target: self, action: #selector(callEndTimePickerView))
		self.datePickerLabel.addGestureRecognizer(callDatePicker)
		self.startHour.addGestureRecognizer(callStartTimePicker)
		self.endHour.addGestureRecognizer(callEndTimePicker)
	}
	
	@objc
	func visitGesture(recognizer: UITapGestureRecognizer) {
		self.visitView.setBorder(borderColor: .primaryOrange, borderWidth: 2)
		self.phoneCallView.setBorder(borderColor: .gray01, borderWidth: 1)
		requestData.solution = "집방문"
	}
	@objc
	func phoneCallGesture(recognizer: UITapGestureRecognizer) {
		self.phoneCallView.setBorder(borderColor: .primaryOrange, borderWidth: 2)
		self.visitView.setBorder(borderColor: .gray01, borderWidth: 1)
		requestData.solution = "전화 통화"
	}
	@objc
	func callDatePickerView(recognizer : UITapGestureRecognizer) {
		let pickerView = DatePickerViewController()
		pickerView.pickerMode = 0
		pickerView.grayImage.image = self.view.window?.asImage()
		pickerView.modalPresentationStyle = .fullScreen
		self.present(pickerView, animated: false, completion: nil)
	}
	@objc
	func callStartTimePickerView(recognizer : UITapGestureRecognizer) {
		let pickerView = DatePickerViewController()
		pickerView.grayImage.image = self.view.window?.asImage()
		pickerView.modalPresentationStyle = .fullScreen
		
		pickerView.pickerMode = 1
		self.present(pickerView, animated: false, completion: nil)
	}
	@objc
	func callEndTimePickerView(recognizer : UITapGestureRecognizer) {
		let pickerView = DatePickerViewController()
		pickerView.pickerMode = 2
		pickerView.grayImage.image = self.view.window?.asImage()
		pickerView.modalPresentationStyle = .fullScreen
		self.present(pickerView, animated: false, completion: nil)
	}
	@objc
	func addTimeStamp(sender : UIButton) {
		resetPickerLayout()
		resetTableViewHeight()
		let isTableViewEmpty = requestData.availableTimeList.isEmpty
		registerButton.isEnabled = isTableViewEmpty ? false : true
		registerButton.backgroundColor = isTableViewEmpty ? .gray : .primaryOrange
		tableViewBind()
		timeStampTableView.reloadData()
	}
	@objc
	func addPromise(sender : UIButton) {
		
		guard let id = registerID else {
			return
		}
		promiseProvider.rx.request(.homePromiseGuestRegister(id: id,
																												 promise_option: promiseArr))
			.asObservable()
			.subscribe { (next) in
				dump(next.data)
				if next.statusCode == 200 {
					self.navigationController?.popToRootViewController(animated: true)
				}
			} onError: { (error) in
				print(error.localizedDescription)
			}.disposed(by: disposeBag)
	}
	@objc func modifyPromise(sender : UIButton) {
		promiseProvider.rx.request(.homePromiseGuestModify(id: issue_id,
																											 promise_option: promiseArr))
			.asObservable()
			.subscribe { (next) in
				dump(next.data)
				if next.statusCode == 200 {
						self.navigationController?.popToRootViewController(animated: true)
				}
			} onError: { (error) in
				print(error.localizedDescription)
			}.disposed(by: disposeBag)
	}
	func timeToNoticeOption() -> noticeOption {
		var temp = VisitDate()
		self.requestData.date.observeOn(MainScheduler.instance).filter{!$0.isEmpty}.subscribe{ str in
			let day = String(str.element!.split(separator: " ")[0])
			let date = String(str.element!.split(separator: " ")[1])
			temp.date = date
			temp.day = day
		}.disposed(by: disposeBag)
		self.requestData.startTime.observeOn(MainScheduler.instance).subscribe{str in temp.startTime = str}.disposed(by: disposeBag)
		self.requestData.endTime.observeOn(MainScheduler.instance).subscribe{str in temp.endTime = str}.disposed(by: disposeBag)
		temp.startTime = temp.startTime.replacingOccurrences(of: "시", with: "")
		temp.day = temp.day.replacingOccurrences(of: "-", with: ".")
		temp.endTime = temp.endTime.replacingOccurrences(of: "시", with: "")


		if temp.startTime.hasPrefix("오전") {
			temp.startTime = temp.startTime.replacingOccurrences(of: "오전 ", with: "")
		}
		else if temp.startTime.hasPrefix("오후") {
			temp.startTime = temp.startTime.replacingOccurrences(of: "오후 ", with: "")
			temp.startTime = String(Int(temp.startTime)! + 12)
		}
		if temp.endTime.hasPrefix("오전") {
			temp.endTime = temp.endTime.replacingOccurrences(of: "오전 ", with: "")
		}
		else if temp.endTime.hasPrefix("오후") {
			temp.endTime = temp.endTime.replacingOccurrences(of: "오후 ", with: "")
			temp.endTime = String(Int(temp.endTime)! + 12)
		}
		temp.startTime = temp.startTime + ":00"
		temp.endTime = temp.endTime + ":00"
		let a = "\(temp.startTime)-\(temp.endTime)"
		
		let promiseTime = noticeOption(date: temp.day, day: a, time: self.requestData.solution)
		
		return promiseTime
	}
	func resetTableViewHeight() {
		self.timeStampTableView.snp.updateConstraints{
			$0.height.equalTo(CGFloat(70 * self.requestData.availableTimeList.count))
		}
		self.underGrayView.snp.updateConstraints{
			$0.height.equalTo(CGFloat(70 * requestData.availableTimeList.count) + 300)
		}
		
	}
	func resetPickerLayout() {
		datePickerLabel.textColor = .textGrayBlank
		underBar.backgroundColor = .textGrayBlank
		datePickerLabel.text = "YYYY.MM.DD"
		
		startHour.textColor = .textGrayBlank
		startHourUnderBar.backgroundColor = .textGrayBlank
		startHour.text = "07시"
		endHour.textColor = .textGrayBlank
		endHourUnderBar.backgroundColor = .textGrayBlank
		endHour.text = "17시"
		var temp = VisitDate()
		requestData.date.observeOn(MainScheduler.instance).filter{!$0.isEmpty}.subscribe{ str in
			let day = String(str.element!.split(separator: "-")[0])
			let date = String(str.element!.split(separator: "-")[1])
			temp.date = date
//			let newday = day.replacingOccurrences(of: "-", with: ". ")
			guard let str = str.element else { return }
			temp.day = str
//			print("진짜는 여기지롱 멍청아",newday)
		}.disposed(by: disposeBag)
		requestData.startTime.observeOn(MainScheduler.instance)
			.subscribe{ str in
			temp.startTime = str
		}.disposed(by: disposeBag)
		requestData.endTime.observeOn(MainScheduler.instance)
			.subscribe{ str in
				temp.endTime = str
		}.disposed(by: disposeBag)
		let t = timeToNoticeOption()
		promiseArr.append([t.date!, t.day!, t.time!])
		requestData.availableTimeList.append(temp)
		
		requestData.date.onNext("")
		requestData.startTime.onNext("")
		requestData.endTime.onNext("")
	}
	
	func tableViewBind() {
		
		timeStampTableView.estimatedRowHeight = CGFloat(70 * requestData.availableTimeList.count)
		
	}
	func bind() {
		let _ = self.requestData.date.observeOn(MainScheduler.instance).filter{!$0.isEmpty}.subscribe(onNext : { str in
			print(str)
			self.datePickerLabel.textColor = .black
			self.underBar.backgroundColor = .black
			self.datePickerLabel.text = str
			
		}).disposed(by: disposeBag)
		let _ = self.requestData.startTime.observeOn(MainScheduler.instance).filter{!$0.isEmpty}.subscribe(onNext : { str in
			print(str)
			self.startHour.textColor = .black
			self.startHourUnderBar.backgroundColor = .black
			self.startHour.text = str
			
		}).disposed(by: disposeBag)
		let _ = self.requestData.endTime.observeOn(MainScheduler.instance).filter{!$0.isEmpty}.subscribe(onNext : { str in
			print(str)
			
			self.endHour.textColor = .black
			self.endHourUnderBar.backgroundColor = .black
			self.endHour.text = str
		}).disposed(by: disposeBag)
		bindAddButton()
	}
	func bindAddButton() {
		let isDateEmpty = requestData.date.map{$0.isEmpty}.asObservable()
		let isStartTimeEmpty = requestData.startTime.map{$0.isEmpty}.asObservable()
		let isEndTimeEmpty = requestData.endTime.map{$0.isEmpty}.asObservable()
		let _ = Observable.combineLatest(
			isDateEmpty,
			isStartTimeEmpty,
			isEndTimeEmpty,
			resultSelector: {$0 || $1 || $2})
			.subscribe{ result in
				self.addButton.isEnabled = !result.element!
				self.addButton.backgroundColor = !result.element! ? .primaryOrange : .white
				if !result.element! {
					self.addButton.setTitleColor(.white, for: .normal)
					self.addButton.layer.borderColor = UIColor.primaryOrange.cgColor
				} else {
					self.addButton.setTitleColor(.gray01, for: .normal)
					self.addButton.layer.borderColor = UIColor.gray01.cgColor
				}
			}.disposed(by: disposeBag)
	}
	@objc func handleTap(recognizer: UITapGestureRecognizer){
		self.view.endEditing(true)
	}
}
extension AppointmentViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 70
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: TimeStampTableViewCell = tableView.dequeueCell(forIndexPath: indexPath)
		cell.awakeFromNib()
		cell.backgroundColor = .primaryGray
		cell.deleteButton.backgroundColor = .primaryGray
		cell.dateLabel.text = String(self.requestData.availableTimeList[indexPath.row].day.split(separator: " ")[0])
		requestData.availableTimeList[indexPath.row].endTime = requestData.availableTimeList[indexPath.row].endTime.replacingOccurrences(of: "시", with: "")
		requestData.availableTimeList[indexPath.row].startTime = requestData.availableTimeList[indexPath.row].startTime.replacingOccurrences(of: "시", with: "")

		if requestData.availableTimeList[indexPath.row].startTime.hasPrefix("오전") {
			requestData.availableTimeList[indexPath.row].startTime = requestData.availableTimeList[indexPath.row].startTime.replacingOccurrences(of: "오전 ", with: "")
		}
		else if requestData.availableTimeList[indexPath.row].startTime.hasPrefix("오후") {
			requestData.availableTimeList[indexPath.row].startTime = requestData.availableTimeList[indexPath.row].startTime.replacingOccurrences(of: "오후 ", with: "")
			requestData.availableTimeList[indexPath.row].startTime = String(Int(requestData.availableTimeList[indexPath.row].startTime)! + 12)
		}
		if requestData.availableTimeList[indexPath.row].endTime.hasPrefix("오전") {
			requestData.availableTimeList[indexPath.row].endTime = requestData.availableTimeList[indexPath.row].endTime.replacingOccurrences(of: "오전 ", with: "")
		}
		else if requestData.availableTimeList[indexPath.row].endTime.hasPrefix("오후") {
			requestData.availableTimeList[indexPath.row].endTime = requestData.availableTimeList[indexPath.row].endTime.replacingOccurrences(of: "오후 ", with: "")
			print(requestData.availableTimeList[indexPath.row].endTime)
			requestData.availableTimeList[indexPath.row].endTime = String(Int(requestData.availableTimeList[indexPath.row].endTime)! + 12)
		}
		cell.timeLabel.text = "\(self.requestData.availableTimeList[indexPath.row].startTime) - \(self.requestData.availableTimeList[indexPath.row].endTime)"

		cell.methodLabel.text = self.requestData.solution
		cell.selectionStyle = .none
		cell.deleteButton.tag = indexPath.row
		cell.deleteButton.addTarget(self, action: #selector(deleteCell), for: .touchUpInside)
		return cell
	}
	@objc func deleteCell(sender:UIButton) {
		requestData.availableTimeList.remove(at: sender.tag)
		timeStampTableView.reloadData()
		if requestData.availableTimeList.isEmpty {
			self.registerButton.isEnabled = false
			self.registerButton.backgroundColor = .gray
		}
		self.resetTableViewHeight()
	}
	// MARK: - Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		bind()
		self.timeStampTableView.register(TimeStampTableViewCell.self,
																		 forCellReuseIdentifier: TimeStampTableViewCell.registterId)
		self.timeStampTableView.delegate = self
		self.timeStampTableView.dataSource = self
		navigationController?.navigationBar.topItem?.title = ""
		layout()
		tableViewBind()
		let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
		self.contentView.addGestureRecognizer(tap)
		
		// Do any additional setup after loading the view.
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tabBarController?.tabBar.isHidden = true
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		tabBarController?.tabBar.isHidden = false
	}

}
// MARK: - TableviewDelegate

extension AppointmentViewController: UITableViewDataSource{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.requestData.availableTimeList.count
	}
}
