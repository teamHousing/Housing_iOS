//
//  MessageViewController.swift
//  Housing
//
//  Created by 김태훈 on 2021/01/05.
//

import UIKit

import Then
import SnapKit
import RxSwift
import Moya
import RxCocoa
import SwiftyJSON

class AdditionalRequestViewController: BaseViewController {
	// MARK: - Component
	private let promiseProvider = MoyaProvider<PromiseService>()
	var requestData = RequestDataModel.shared
	let requestId = promiseId.shared.id
	var imageIndex: Int?
	
	private let mainLabel = UILabel().then {
		$0.numberOfLines = 2
		$0.text = """
							집주인께
							전하고 싶은 말이 있나요?
							"""
		$0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 26)
		$0.textColor = .black
		$0.textAlignment = .left
	}
	private let lineImage = UIView().then {
		$0.backgroundColor = UIColor.primaryBlack
		$0.tintColor = UIColor.primaryBlack
	}
	private let presetButton1 = UIButton().then {
		$0.setTitle("늘 감사합니다 :)", for: .normal)
		$0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 13)
		$0.setRounded(radius: 12)
		$0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
		$0.contentHorizontalAlignment = .left
		$0.setBorder(borderColor: .primaryOrange, borderWidth: 2)
		$0.setTitleColor(.black, for: .normal)
		$0.addTarget(self, action: #selector(presetMessageSelected), for: .touchUpInside)
	}
	private let presetButton2 = UIButton().then {
		$0.setTitle("최대한 신속하게 확인 부탁드려요.", for: .normal)
		$0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 13)
		$0.setRounded(radius: 12)
		$0.setBorder(borderColor: .gray01, borderWidth: 1)
		$0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
		$0.contentHorizontalAlignment = .left
		$0.setTitleColor(.black, for: .normal)
		$0.addTarget(self, action: #selector(presetMessageSelected), for: .touchUpInside)
	}
	private let presetButton3 = UIButton().then {
		$0.setTitle("방문 전 사전 연락 부탁드려요.", for: .normal)
		$0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 13)
		$0.setRounded(radius: 12)
		$0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
		$0.contentHorizontalAlignment = .left
		$0.setBorder(borderColor: .gray01, borderWidth: 1)
		$0.setTitleColor(.black, for: .normal)
		$0.addTarget(self, action: #selector(presetMessageSelected), for: .touchUpInside)
	}
	private let presetButton4 = UIButton().then {
		$0.setTitle("부재 시 먼저 연락드리겠습니다.", for: .normal)
		$0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 13)
		$0.setRounded(radius: 12)
		$0.setBorder(borderColor: .gray01, borderWidth: 1)
		$0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
		$0.contentHorizontalAlignment = .left
		$0.setTitleColor(.black, for: .normal)
		$0.addTarget(self, action: #selector(presetMessageSelected), for: .touchUpInside)
	}
	private let presetButton5 = UITextField().then {
		$0.text = "직접 입력하기"
		$0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 13)
		$0.textColor = .black
		$0.setRounded(radius: 12)
		$0.setBorder(borderColor: .gray01, borderWidth: 1)
		let padding =  UIView(frame: CGRect(x: 0, y: 0, width: 16, height: $0.frame.height))
		$0.leftView = padding
		$0.leftViewMode = .always
	}
	private let nextStep = UIButton().then {
		$0.setTitle("다음 단계", for: .normal)
		$0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 13)
		$0.backgroundColor = .primaryOrange
		$0.setRounded(radius: 25)
	}
	private let page = UIPageControl().then{
		$0.numberOfPages = 4
		$0.currentPage = 2
		$0.currentPageIndicatorTintColor = .primaryOrange
		$0.tintColor = .gray01
		$0.pageIndicatorTintColor = .gray01
	}
	
	// MARK: - Helper
	@objc func nextButtonDidTapped() {

		promiseProvider.rx.request(.homePromise(id: imageIndex ?? 0,
																						is_promise: requestData.isPromiseNeeded,
																						category: requestData.cartegory,
																						issue_title: requestData.title,
																						issue_contents: requestData.discription,
																						requested_term: requestData.editionalRequest))
			.asObservable()
			.subscribe { (next) in
				let json = JSON(next.data)
				if next.statusCode == 200 {
					do {
						let decoder = JSONDecoder()
						let data = try decoder.decode(ResponseType<IssueId>.self, from: next.data)
						let viewController = AppointmentViewController()
						viewController.registerID = self.imageIndex
						self.navigationController?.pushViewController(viewController, animated: true)
					}
					catch {
						print(error)
					}
				}
			} onError: { (error) in
				print(error.localizedDescription)
			}.disposed(by: disposeBag)
		requestData.availableTimeList = []
		requestData.title = ""
		requestData.isPromiseNeeded = false
		requestData.cartegory = 0
		requestData.discription = ""
	}
	@objc func popToRootController() {
		promiseProvider.rx.request(.homePromise(id: imageIndex ?? 0,
																						is_promise: requestData.isPromiseNeeded,
																						category: requestData.cartegory,
																						issue_title: requestData.title,
																						issue_contents: requestData.discription,
																						requested_term: requestData.editionalRequest))
			.asObservable()
			.subscribe { (next) in
				let json = JSON(next.data)
				dump(json, name: #function)

				if next.statusCode == 200 {
					do {
						let decoder = JSONDecoder()
						let data = try decoder.decode(ResponseType<IssueId>.self, from: next.data)
						self.navigationController?.popToRootViewController(animated: true)
						self.requestData.issueId = data.data!.issue_id
					}
					catch {
						print(error)
					}
				}
			} onError: { (error) in
				print(error.localizedDescription)
			}.disposed(by: disposeBag)
		requestData.availableTimeList = []
		requestData.title = ""
		requestData.isPromiseNeeded = false
		requestData.cartegory = 0
		requestData.discription = ""
	}
	
	@objc
	private func image(){
		print(#function)
		if requestData.images.isEmpty {
			requestData.images = []
		}
		promiseProvider.rx.request(.homePromiseImageUpload(issue_img: requestData.images))
			.observeOn(MainScheduler.init())
			.asObservable()
			.subscribe { (next) in
				do {
					let decoder = JSONDecoder()
					let data = try decoder.decode(ResponseType<IssueId>.self, from: next.data)
					self.imageIndex = data.data?.issue_id
					if !self.requestData.isPromiseNeeded {
						self.popToRootController()
					} else {
						self.nextButtonDidTapped()
					}

				} catch {
					print(error)
				}
			} onError: { (error) in
				print(123)
				print(error.localizedDescription)
			}.disposed(by: disposeBag)
	}
	@objc func presetMessageSelected(sender : UIButton) {
		clearSelection()
		sender.setBorder(borderColor: .primaryOrange, borderWidth: 2)
		//sender.layer.applyShadow()
		requestData.editionalRequest = sender.titleLabel?.text ?? ""
		presetButton5.resignFirstResponder()
	}
	
	func dataPreset() {
		requestData.editionalRequest = "늘 감사합니다 :)"
	}
	func clearSelection() {
		self.presetButton1.setBorder(borderColor: .gray01, borderWidth: 1)
		self.presetButton2.setBorder(borderColor: .gray01, borderWidth: 1)
		self.presetButton3.setBorder(borderColor: .gray01, borderWidth: 1)
		self.presetButton4.setBorder(borderColor: .gray01, borderWidth: 1)
		self.presetButton5.setBorder(borderColor: .gray01, borderWidth: 1)
		
	}
	
	private func widthConstraintAmount(value : CGFloat) -> CGFloat {
		let superViewWidth = self.view.frame.width
		
		return (value / 375) * superViewWidth
	}
	private func heightConstraintAmount(value : CGFloat) -> CGFloat {
		let superViewHeight = self.view.frame.height
		
		return (value / 698) * superViewHeight
	}
	private func layout() {
		self.navigationController?.navigationBar.backgroundColor = .white
		self.view.backgroundColor = .white
		self.view.adds([
			mainLabel,
			lineImage,
			presetButton1,
			presetButton2,
			presetButton3,
			presetButton4,
			presetButton5,
			nextStep,
			page
		])
		mainLabel.snp.makeConstraints{
			$0.top.equalTo(view.safeAreaLayoutGuide).offset(6)
			$0.leading.equalTo(view).offset(widthConstraintAmount(value: 20))
		}
		lineImage.snp.makeConstraints{
			$0.top.equalTo(view.safeAreaLayoutGuide).offset(64)
			$0.trailing.equalTo(view.safeAreaLayoutGuide)
			$0.leading.equalTo(mainLabel.snp.trailing).offset(8)
			$0.height.equalTo(1)
		}
		presetButton1.snp.makeConstraints{
			$0.centerX.equalTo(view)
			$0.width.equalTo(widthConstraintAmount(value: 335))
			$0.height.equalTo(presetButton1.snp.width).multipliedBy(1/5.9821)
			$0.top.equalTo(lineImage.snp.bottom).offset(49)
		}
		presetButton2.snp.makeConstraints{
			$0.centerX.equalTo(view)
			$0.width.equalTo(widthConstraintAmount(value: 335))
			$0.height.equalTo(presetButton1.snp.width).multipliedBy(1/5.9821)
			$0.top.equalTo(presetButton1.snp.bottom).offset(12)
		}
		presetButton3.snp.makeConstraints{
			$0.centerX.equalTo(view)
			$0.width.equalTo(widthConstraintAmount(value: 335))
			$0.height.equalTo(presetButton1.snp.width).multipliedBy(1/5.9821)
			$0.top.equalTo(presetButton2.snp.bottom).offset(12)
		}
		presetButton4.snp.makeConstraints{
			$0.centerX.equalTo(view)
			$0.width.equalTo(widthConstraintAmount(value: 335))
			$0.height.equalTo(presetButton1.snp.width).multipliedBy(1/5.9821)
			$0.top.equalTo(presetButton3.snp.bottom).offset(12)
		}
		presetButton5.snp.makeConstraints{
			$0.centerX.equalTo(view)
			$0.width.equalTo(widthConstraintAmount(value: 335))
			$0.height.equalTo(presetButton1.snp.width).multipliedBy(1/5.9821)
			$0.top.equalTo(presetButton4.snp.bottom).offset(12)
		}
		if !requestData.isPromiseNeeded {
			nextStep.setTitle("등록하기", for: .normal)
			nextStep.addTarget(self, action: #selector(image), for: .touchUpInside)
			page.numberOfPages = 3
		}
		else {
			nextStep.addTarget(self, action: #selector(image), for: .touchUpInside)
		}
		nextStep.snp.makeConstraints{
			$0.centerX.equalTo(view)
			$0.width.equalTo(widthConstraintAmount(value: 255))
			$0.height.equalTo(nextStep.snp.width).multipliedBy(1 / 5.3125)
			$0.top.equalTo(presetButton5.snp.bottom).offset(60)
			
		}
		page.snp.makeConstraints{
			$0.top.equalTo(nextStep.snp.bottom).offset(24)
			$0.bottom.equalToSuperview()
			$0.height.equalTo(20)
			$0.centerX.equalToSuperview()
		}
		presetButton5.delegate = self
		
	}
	@objc func handleTap(recognizer: UITapGestureRecognizer){
		
		self.view.endEditing(true)
	}
	@objc
	func keyboardWillShow(_ sender: Notification) {
		self.view.frame.origin.y = -150 // Move view 150 points upward
	}
	@objc
	func keyboardWillHide(_ sender: Notification) {
		self.view.frame.origin.y = 0 // Move view to original position
	}
	// MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		dataPreset()
		layout()
		// Do any additional setup after loading the view.
		navigationController?.navigationBar.topItem?.title = ""
		let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
		self.view.addGestureRecognizer(tap)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
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


// MARK: - TextFieldDelegate
extension AdditionalRequestViewController : UITextFieldDelegate {
	func textFieldDidBeginEditing(_ textField: UITextField) {
		clearSelection()
		if textField.text == "직접 입력하기" {
			textField.text = nil
		}
		textField.setBorder(borderColor: .primaryOrange, borderWidth: 2)
	}
	func textFieldDidEndEditing(_ textField: UITextField) {
		if textField.text == ""{
			textField.text = "직접 입력하기"
		}
		
		requestData.editionalRequest = textField.text ?? ""
	}
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
	
}

private struct IssueId : Codable{
	let issue_id : Int
}
