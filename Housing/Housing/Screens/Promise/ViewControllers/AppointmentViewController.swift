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

class AppointmentViewController: UIViewController {
	var requestData = RequestDataModel.shared
	
	private let appointmentScroll = UIScrollView()
	private let contentView = UIView()
	private let backgroundLabel = UILabel().then{
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
		$0.setBorder(borderColor: .salmon, borderWidth: 2)
		$0.isUserInteractionEnabled = true
		$0.isMultipleTouchEnabled = true
		let icon = UIImageView()
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
		let icon = UIImageView()
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
		$0.text = "YYYY.MM.DD"
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
	private let startHour = UILabel().then {
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
	let timeStampTableView = UITableView(frame: .zero)
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
		$0.currentPageIndicatorTintColor = .salmon
		$0.tintColor = .gray01
		$0.pageIndicatorTintColor = .gray01
	}
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
		//		self.view.addSubview(appointmentScroll)
		//		appointmentScroll.snp.makeConstraints{
		//			$0.edges.equalToSuperview()
		//		}
		//		self.appointmentScroll.addSubview(contentView)
		//		contentView.snp.makeConstraints{
		//			$0.width.equalToSuperview().priority(1000)
		//			$0.centerX.top.bottom.equalToSuperview()
		//		}
		//		self.contentView
		self.view.adds([
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
										addButton])
		backgroundLabel.snp.makeConstraints{
			$0.top.equalToSuperview().offset(0)
			$0.leading.equalTo(view).offset(widthConstraintAmount(value: 20))
			$0.trailing.equalTo(view).offset(widthConstraintAmount(value: -85))
		}
		lineImage.snp.makeConstraints{
			$0.top.equalToSuperview().offset(22)
			$0.trailing.equalTo(view.safeAreaLayoutGuide).offset(0)
			$0.leading.equalTo(backgroundLabel.snp.trailing).offset(8)
			$0.height.equalTo(1)
			$0.width.equalTo(widthConstraintAmount(value: widthConstraintAmount(value: 77)))
		}
		comunicationType.snp.makeConstraints{
			$0.leading.equalTo(view).offset(widthConstraintAmount(value: 20))
			$0.top.equalTo(backgroundLabel.snp.bottom).offset(60)
			$0.width.equalTo(widthConstraintAmount(value: 151))
		}
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
			$0.width.equalTo(widthConstraintAmount(value: 125))
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
	
	@objc func visitGesture(recognizer: UITapGestureRecognizer) {
		self.visitView.setBorder(borderColor: .salmon, borderWidth: 2)
		self.phoneCallView.setBorder(borderColor: .gray01, borderWidth: 1)
		requestData.solution = "visit"
	}
	@objc func phoneCallGesture(recognizer: UITapGestureRecognizer) {
		self.phoneCallView.setBorder(borderColor: .salmon, borderWidth: 2)
		self.visitView.setBorder(borderColor: .gray01, borderWidth: 1)
		requestData.solution = "phone"
	}
	@objc func callDatePickerView(recognizer : UITapGestureRecognizer) {
		let pickerView = DatePickerViewController()
		pickerView.pickerMode = 0
		pickerView.grayImage.image = self.view.asImage()
		self.present(pickerView, animated: false, completion: nil)
	}
	@objc func callStartTimePickerView(recognizer : UITapGestureRecognizer) {
		let pickerView = DatePickerViewController()
		pickerView.grayImage.image = self.view.asImage()
		pickerView.pickerMode = 1
		self.present(pickerView, animated: false, completion: nil)
	}
	@objc func callEndTimePickerView(recognizer : UITapGestureRecognizer) {
		let pickerView = DatePickerViewController()
		pickerView.pickerMode = 2
		pickerView.grayImage.image = self.view.asImage()
		self.present(pickerView, animated: false, completion: nil)
	}
	@objc func addTimeStamp(sender : UIButton) {
		self.resetPickerLayout()
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
		self.requestData.date.observeOn(MainScheduler.instance)
			.subscribe(onNext: { str in
				let day = String(str.split(separator: " ")[0])
				let date = String(str.split(separator: " ")[1])
				self.requestData.availableTimeList.append(VisitDate(day: day, date: date, startTime: "", endTime: ""))
			}).dispose()

		requestData.date.onNext("")
		requestData.startTime.onNext("")
		requestData.endTime.onNext("")
	}
		
	override func viewDidLoad() {
		super.viewDidLoad()
		bind()
		let requestDatamonitor = DispatchWorkItem{
			while(true){
				dump(self.requestData)
				sleep(10)
			}
		}
		DispatchQueue.global().async(execute: requestDatamonitor)

		layout()
		let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
		self.contentView.addGestureRecognizer(tap)
		// Do any additional setup after loading the view.
	}
	
	func bind() {
		let _ = self.requestData.date.observeOn(MainScheduler.instance).filter{!$0.isEmpty}.subscribe(onNext : { str in
			print(str)
			self.datePickerLabel.textColor = .black
			self.underBar.backgroundColor = .black
			self.datePickerLabel.text = str
		})
		let _ = self.requestData.startTime.observeOn(MainScheduler.instance).filter{!$0.isEmpty}.subscribe(onNext : { str in
			print(str)
			self.startHour.textColor = .black
			self.startHourUnderBar.backgroundColor = .black
			self.startHour.text = str
		})
		let _ = self.requestData.endTime.observeOn(MainScheduler.instance).filter{!$0.isEmpty}.subscribe(onNext : { str in
			print(str)
			self.endHour.textColor = .black
			self.endHourUnderBar.backgroundColor = .black
			self.endHour.text = str
		})
		let isDateEmpty: Observable<Bool> = requestData.date.map{$0.isEmpty}.asObservable()
		let isStartTimeEmpty: Observable<Bool> = requestData.startTime.map{$0.isEmpty}.asObservable()
		let isEndTimeEmpty: Observable<Bool> = requestData.endTime.map{$0.isEmpty}.asObservable()
		Observable.combineLatest(
			isDateEmpty,
			isStartTimeEmpty,
			isEndTimeEmpty,
			resultSelector: {!$0 && !$1 && !$2})
			.subscribe{ result in
			print(result)
			self.addButton.isEnabled = result.element!
			self.addButton.backgroundColor = result.element! ? .black : .white
		}.disposed(by: DisposeBag())
	}
	@objc func handleTap(recognizer: UITapGestureRecognizer){
		self.view.endEditing(true)
	}
}
