//
//  PromiseViewController.swift
//  Housing
//
//  Created by 김태훈 on 2021/01/01.
//

import UIKit

import Then
import SnapKit
class PromiseViewController: UIViewController {
	var requestData = RequestDataModel.shared
	private let totalScroll = UIScrollView()
	private let contentView = UIView()
	private let backButton = UIButton().then{
		$0.backgroundColor = .white
		$0.addTarget(self, action: #selector(backButtonDidTab), for: .touchUpInside)
	}
	private let backgroundLabel = UILabel().then{
		$0.text = "무슨 일이 생겼나요?"
		$0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 26)
		$0.textColor = .black
		$0.textAlignment = .left
	}
	private let lineImage = UIView().then {
		$0.backgroundColor = UIColor.primaryBlack
		$0.tintColor = UIColor.primaryBlack
	}
	private let solutionLabel = UILabel().then{
		$0.text = "해결을 위해서는"
		$0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
		$0.textColor = .black
		$0.textAlignment = .left
	}
	
	private let promiseRequiredView = UIView().then{
		$0.backgroundColor = .white
		$0.setRounded(radius: 16)
		$0.setBorder(borderColor: .salmon, borderWidth: 2)
		$0.isUserInteractionEnabled = true
		$0.isMultipleTouchEnabled = true
		let icon = UIImageView()
		let description = UILabel().then {
			$0.text = """
				집주인과
				약속이 필요한 문의에요!
				"""
			$0.textColor = .black
			$0.numberOfLines = 2
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
	private let fixRepairButton = UIButton().then{
		$0.setTitle("고장 / 수리", for: .normal)
		$0.titleLabel?.textAlignment = .center
		$0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
		$0.setRounded(radius: 15)
		$0.setTitleColor(.white, for: .normal)
		$0.backgroundColor = .salmon
		$0.setBorder(borderColor: .gray01, borderWidth: 1)
		$0.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
		
	}
	private let contractButton = UIButton().then{
		$0.setTitle("계약 관련", for: .normal)
		$0.titleLabel?.textAlignment = .center
		$0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
		$0.setRounded(radius: 15)
		$0.setTitleColor(.black, for: .normal)
		$0.backgroundColor = .white
		$0.setBorder(borderColor: .gray01, borderWidth: 1)
		$0.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
		
	}
	private let rentalFeeButton = UIButton().then{
		$0.setTitle("요금 납부", for: .normal)
		$0.titleLabel?.textAlignment = .center
		$0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
		$0.setRounded(radius: 15)
		$0.setTitleColor(.black, for: .normal)
		$0.backgroundColor = .white
		$0.setBorder(borderColor: .gray01, borderWidth: 1)
		$0.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
		
	}
	private let noiseButton = UIButton().then{
		$0.setTitle("소음 관련", for: .normal)
		$0.titleLabel?.textAlignment = .center
		$0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
		$0.setRounded(radius: 15)
		$0.setTitleColor(.black, for: .normal)
		$0.backgroundColor = .white
		$0.setBorder(borderColor: .gray01, borderWidth: 1)
		$0.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
		
	}
	private let questionButton = UIButton().then{
		$0.setTitle("문의 사항", for: .normal)
		$0.titleLabel?.textAlignment = .center
		$0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
		$0.setRounded(radius: 15)
		$0.setTitleColor(.black, for: .normal)
		$0.backgroundColor = .white
		$0.setBorder(borderColor: .gray01, borderWidth: 1)
		$0.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
		
	}
	private let etcButton = UIButton().then{
		$0.setTitle("그 외", for: .normal)
		$0.titleLabel?.textAlignment = .center
		$0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
		$0.setRounded(radius: 15)
		$0.setTitleColor(.black, for: .normal)
		$0.backgroundColor = .white
		$0.setBorder(borderColor: .gray01, borderWidth: 1)
		$0.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
	}
	
	private let questionTitle = UITextField().then{
		$0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 21)
		$0.borderStyle = .none
		$0.placeholder("제목을 작성해주세요")
		$0.textColor = .black
	}
	private let underBar = UIView().then {
		$0.backgroundColor = .gray01
	}
	private let questionDescription = UITextView().then{
		$0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
		$0.setRounded(radius: 16)
		$0.setBorder(borderColor: .gray01, borderWidth: 1)
		$0.text = "내용을 작성해주세요"
		$0.backgroundColor = .white
		$0.textColor = .gray01
		$0.textContainerInset = UIEdgeInsets(top: 24, left: 16, bottom: 24, right: 16)
	}
	private let nextStep = UIButton().then{
		$0.backgroundColor = .gray01
		$0.setTitle("다음 단계", for: .normal)
		$0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
		$0.isEnabled = false
		$0.setRounded(radius: 25)
		$0.addTarget(self, action: #selector(nextButtonDidTapped), for: .touchUpInside)
	}
	private let page = UIPageControl().then{
		$0.numberOfPages = 4
		$0.currentPage = 0
		$0.currentPageIndicatorTintColor = .salmon
		$0.tintColor = .gray01
		$0.pageIndicatorTintColor = .gray01
	}
	@objc func nextButtonDidTapped() {
		print("싱글톤데이터")
		print(requestData)
		let cameraView = CameraWorkViewController()
		self.navigationController?.pushViewController(cameraView, animated: true)
	}
	
	@objc func buttonClicked(sender : UIButton) {
		buttonBackgroundRefresher()
		sender.backgroundColor = .salmon
		sender.setTitleColor(.white, for: .normal)
		sender.setBorder(borderColor: .salmon, borderWidth: 1)
		//		self.requestData.cartegory = sender.titleLabel.text
	}
	func buttonBackgroundRefresher() {
		fixRepairButton.setTitleColor(.black, for: .normal)
		fixRepairButton.setBorder(borderColor: .gray01, borderWidth: 1)
		fixRepairButton.backgroundColor = .white
		contractButton.setTitleColor(.black, for: .normal)
		contractButton.backgroundColor = .white
		contractButton.setBorder(borderColor: .gray01, borderWidth: 1)
		rentalFeeButton.setTitleColor(.black, for: .normal)
		rentalFeeButton.backgroundColor = .white
		rentalFeeButton.setBorder(borderColor: .gray01, borderWidth: 1)

		noiseButton.setTitleColor(.black, for: .normal)
		noiseButton.backgroundColor = .white
		noiseButton.setBorder(borderColor: .gray01, borderWidth: 1)

		questionButton.setTitleColor(.black, for: .normal)
		questionButton.backgroundColor = .white
		questionButton.setBorder(borderColor: .gray01, borderWidth: 1)

		etcButton.setTitleColor(.black, for: .normal)
		etcButton.backgroundColor = .white
		etcButton.setBorder(borderColor: .gray01, borderWidth: 1)

	}
	
	private let promiseNotRequiredView = UIView().then{
		$0.backgroundColor = .white
		$0.setRounded(radius: 16)
		$0.setBorder(borderColor: .systemGray6, borderWidth: 1)
		$0.isUserInteractionEnabled = true
		$0.isMultipleTouchEnabled = true
		let icon = UIImageView()
		let description = UILabel().then {
			$0.text = """
				약속이 필요없는
				문의에요!
				"""
			$0.numberOfLines = 2
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
	
	private let requestTypeLabel = UILabel().then{
		$0.text = "어떤 종류의 문제인가요?"
		$0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
		$0.textColor = .black

	}
	private let message = UILabel().then{
		$0.text = "집주인께 문의를 남겨주세요"
		$0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
		$0.textColor = .black

	}
	
	
	
	
	private func widthConstraintAmount(value : CGFloat) -> CGFloat {
		let superViewWidth = self.view.frame.width
		
		return (value / 375) * superViewWidth
	}
	private func heightConstraintAmount(value : CGFloat) -> CGFloat {
		let superViewHeight = self.view.frame.height
		
		return (value / 1110) * superViewHeight
	}
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		self.view.endEditing(true)
	}
	func dataPreset(){
		requestData.isPromiseNeeded = true
		requestData.cartegory = .repair
	}
	private func layout() {
		dataPreset()
		self.navigationController?.navigationBar.backgroundColor = .white
		self.view.backgroundColor = .white
		self.view.addSubview(totalScroll)
		totalScroll.snp.makeConstraints{
			$0.edges.equalToSuperview()
		}
		self.totalScroll.addSubview(contentView)
		contentView.snp.makeConstraints{
			$0.width.equalToSuperview().priority(1000)
			$0.centerX.top.bottom.equalToSuperview()
		}
		self.contentView.adds([
														backgroundLabel,
														lineImage,
														solutionLabel,
														promiseRequiredView,
														promiseNotRequiredView,
														requestTypeLabel,
														fixRepairButton,
														contractButton,
														rentalFeeButton,
														noiseButton,
														questionButton,
														etcButton,
														message,
														questionTitle,
														underBar,
														questionDescription,
														nextStep,page])
		backgroundLabel.snp.makeConstraints{
			$0.top.equalToSuperview().offset(0)
			$0.leading.equalTo(view).offset(widthConstraintAmount(value: 20))
			$0.trailing.equalTo(view).offset(widthConstraintAmount(value: -152))
		}
		lineImage.snp.makeConstraints{
			$0.top.equalToSuperview().offset(22)
			$0.trailing.equalTo(view.safeAreaLayoutGuide).offset(0)
			$0.leading.equalTo(backgroundLabel.snp.trailing).offset(8)
			$0.height.equalTo(1)
			$0.width.equalTo(widthConstraintAmount(value: widthConstraintAmount(value: 144)))
		}
		solutionLabel.snp.makeConstraints{
			$0.leading.equalTo(view).offset(widthConstraintAmount(value: 20))
			$0.top.equalTo(backgroundLabel.snp.bottom).offset(60)
			$0.width.equalTo(widthConstraintAmount(value: 95))
		}
		promiseRequiredView.snp.makeConstraints{
			$0.top.equalTo(solutionLabel.snp.bottom).offset(24)
			$0.leading.equalTo(view).offset(widthConstraintAmount(value: 20))
			$0.width.equalTo(widthConstraintAmount(value: 162))
			$0.height.equalTo(promiseRequiredView.snp.width).multipliedBy(1 / 1.125)
		}
		
		promiseNotRequiredView.snp.makeConstraints{
			$0.top.equalTo(solutionLabel.snp.bottom).offset(24)
			$0.leading.equalTo(promiseRequiredView.snp.trailing).offset(widthConstraintAmount(value: 12))
			$0.width.equalTo(widthConstraintAmount(value: 162))
			$0.height.equalTo(promiseRequiredView.snp.width).multipliedBy(1 / 1.125)
			$0.centerY.equalTo(promiseRequiredView)
		}
		requestTypeLabel.snp.makeConstraints{
			$0.leading.equalTo(view).offset(20)
			$0.top.equalTo(promiseRequiredView.snp.bottom).offset(64)
			$0.width.equalTo(widthConstraintAmount(value: 145))
		}
		fixRepairButton.snp.makeConstraints{
			$0.leading.equalTo(view).offset(28)
			$0.top.equalTo(requestTypeLabel.snp.bottom).offset(24)
			$0.width.equalTo(widthConstraintAmount(value: 101))
			$0.height.equalTo(fixRepairButton.snp.width).multipliedBy(1 / 2.463)
		}
		contractButton.snp.makeConstraints{
			$0.centerY.equalTo(fixRepairButton.snp.centerY)
			$0.centerX.equalTo(view)
			$0.width.equalTo(fixRepairButton.snp.width)
			$0.height.equalTo(fixRepairButton.snp.height)
		}
		rentalFeeButton.snp.makeConstraints{
			$0.trailing.equalTo(view).offset(-28)
			$0.centerY.equalTo(fixRepairButton.snp.centerY)
			$0.width.equalTo(fixRepairButton.snp.width)
			$0.height.equalTo(fixRepairButton.snp.height)
		}
		noiseButton.snp.makeConstraints{
			$0.leading.equalTo(view).offset(28)
			$0.top.equalTo(fixRepairButton.snp.bottom).offset(12)
			$0.centerX.equalTo(fixRepairButton.snp.centerX)
			$0.width.equalTo(fixRepairButton.snp.width)
			$0.height.equalTo(fixRepairButton.snp.height)
		}
		questionButton.snp.makeConstraints{
			$0.centerY.equalTo(noiseButton.snp.centerY)
			$0.centerX.equalTo(view)
			$0.width.equalTo(fixRepairButton.snp.width)
			$0.height.equalTo(fixRepairButton.snp.height)
		}
		etcButton.snp.makeConstraints{
			$0.trailing.equalTo(view).offset(-28)
			$0.centerY.equalTo(noiseButton.snp.centerY)
			$0.width.equalTo(fixRepairButton.snp.width)
			$0.height.equalTo(fixRepairButton.snp.height)
		}
		message.snp.makeConstraints{
			$0.top.equalTo(etcButton.snp.bottom).offset(64)
			$0.leading.equalTo(view).offset(20)
			$0.width.equalTo(widthConstraintAmount(value: 168))
			
		}
		questionTitle.snp.makeConstraints{
			$0.top.equalTo(message.snp.bottom).offset(28)
			$0.centerX.equalTo(view)
			$0.width.equalTo(widthConstraintAmount(value: 335))
			$0.height.equalTo(questionTitle.snp.width).multipliedBy(1 / 13.4)
		}
		questionTitle.delegate = self
		underBar.snp.makeConstraints{
			$0.top.equalTo(questionTitle.snp.bottom).offset(7)
			$0.width.equalTo(widthConstraintAmount(value: 336))
			$0.height.equalTo(1)
			$0.centerX.equalTo(view)
		}
		questionDescription.snp.makeConstraints{
			$0.top.equalTo(underBar.snp.bottom).offset(36)
			$0.centerX.equalTo(view)
			$0.width.equalTo(widthConstraintAmount(value: 335))
			$0.height.equalTo(questionTitle.snp.width).multipliedBy(1 / 2.1)
		}
		questionDescription.delegate = self
		nextStep.snp.makeConstraints{
			$0.top.equalTo(questionDescription.snp.bottom).offset(72)
			$0.centerX.equalTo(view)
			$0.width.equalTo(widthConstraintAmount(value: 255))
			$0.height.equalTo(questionTitle.snp.width).multipliedBy(1 / 5.3125)
		}
		page.snp.makeConstraints{
			$0.top.equalTo(nextStep.snp.bottom).offset(24)
			$0.bottom.equalToSuperview()
			$0.height.equalTo(20)
			$0.centerX.equalToSuperview()
		}

		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
		
		
		
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
		
		
		let promiseTap = UITapGestureRecognizer(target: self, action: #selector(promiseTapped))
		let notPromiseTap = UITapGestureRecognizer(target: self, action: #selector(notPromiseTapped))
		self.promiseRequiredView.addGestureRecognizer(promiseTap)
		self.promiseNotRequiredView.addGestureRecognizer(notPromiseTap)
	}
	@objc func promiseTapped(recognizer: UITapGestureRecognizer) {
		self.promiseRequiredView.setBorder(borderColor: .salmon, borderWidth: 2)
		self.promiseNotRequiredView.setBorder(borderColor: .gray01, borderWidth: 1)
		self.page.numberOfPages = 4
		requestData.isPromiseNeeded = true
	}
	@objc func notPromiseTapped(recognizer: UITapGestureRecognizer) {
		self.promiseNotRequiredView.setBorder(borderColor: .salmon, borderWidth: 2)
		self.promiseRequiredView.setBorder(borderColor: .gray01, borderWidth: 1)
		self.page.numberOfPages = 3
		requestData.isPromiseNeeded = false
	}
	@objc
	func keyboardWillShow(_ sender: Notification) {
		self.view.frame.origin.y = -150 // Move view 150 points upward
	}
	@objc
	func keyboardWillHide(_ sender: Notification) {
		self.view.frame.origin.y = 0 // Move view to original position
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
//		view.backgroundColor = .cyan
		dataPreset()
		layout()
		let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
		self.contentView.addGestureRecognizer(tap)
	}
	@objc func handleTap(recognizer: UITapGestureRecognizer){
		
		self.view.endEditing(true)
	}
	@objc
	func backButtonDidTab() {
		self.dismiss(animated: true, completion: nil)
	}
}

extension PromiseViewController : UITextViewDelegate {
	func textViewDidBeginEditing(_ textView: UITextView) {
		if textView.textColor == UIColor.gray01 {
			textView.text = nil
			textView.textColor = UIColor.black
		}
	}
	func textViewDidEndEditing(_ textView: UITextView) {
		if textView.text.isEmpty {
			textView.text = "내용을 작성해주세요"
			textView.textColor = UIColor.gray01
			requestData.discription = ""

		}
		else {
			requestData.discription = textView.text
		}
		
		if requestData.title.isEmpty || requestData.discription.isEmpty {
			nextStep.isEnabled = false
			nextStep.backgroundColor = .gray01
		}
		else {
			nextStep.isEnabled = true
			nextStep.backgroundColor = .black
		}
	}
	
}
extension PromiseViewController : UITextFieldDelegate{
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	func textFieldDidEndEditing(_ textField: UITextField) {
		requestData.title = textField.text ?? ""
		if requestData.title.isEmpty || requestData.discription.isEmpty {
			nextStep.isEnabled = false
			nextStep.backgroundColor = .gray01
		}
		else {
			nextStep.isEnabled = true
			nextStep.backgroundColor = .black
		}
	}
}
