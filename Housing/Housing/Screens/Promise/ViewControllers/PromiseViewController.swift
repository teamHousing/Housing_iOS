//
//  PromiseViewController.swift
//  Housing
//
//  Created by 김태훈 on 2021/01/01.
//

import UIKit

import RxSwift
import RxCocoa
import Then
import SnapKit
class PromiseViewController: UIViewController {
	// MARK: - Component
	var requestData = RequestDataModel.shared
	var disposeBag = DisposeBag()
	private let totalScroll = UIScrollView()
	private let contentView = UIView()
	private let backButton = UIButton().then{
		$0.backgroundColor = .white
		$0.addTarget(self, action: #selector(backButtonDidTab), for: .touchUpInside)
	}
	private let backgroundLabel = UILabel().then{
		$0.text = "인증번호 생성하기"
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
		$0.setBorder(borderColor: .primaryOrange, borderWidth: 2)
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
		icon.image = UIImage(named: "img1")
		description.snp.makeConstraints{
			$0.trailing.equalToSuperview().offset(-23)
			$0.top.equalToSuperview().offset(88)
			$0.leading.equalToSuperview().offset(16)
			$0.bottom.equalToSuperview().offset(-24)
		}
		
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
		icon.image = UIImage(named: "img2")
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
	
	private let fixRepairButton = UIButton().then{
		$0.setTitle("고장 / 수리", for: .normal)
		$0.titleLabel?.textAlignment = .center
		$0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 13)
		$0.setRounded(radius: 15)
		$0.setTitleColor(.white, for: .normal)
		$0.backgroundColor = .primaryOrange
		
		$0.tag = 1
		$0.addTarget(self, action: #selector(problemTypeSelection), for: .touchUpInside)
		
	}
	private let contractButton = UIButton().then{
		$0.setTitle("계약 관련", for: .normal)
		$0.titleLabel?.textAlignment = .center
		$0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 13)
		$0.setRounded(radius: 15)
		$0.setTitleColor(.black, for: .normal)
		$0.backgroundColor = .white
		$0.setBorder(borderColor: .gray01, borderWidth: 1)
		$0.tag = 2
		$0.addTarget(self, action: #selector(problemTypeSelection), for: .touchUpInside)
		
	}
	private let rentalFeeButton = UIButton().then{
		$0.setTitle("요금 납부", for: .normal)
		$0.titleLabel?.textAlignment = .center
		$0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 13)
		$0.setRounded(radius: 15)
		$0.setTitleColor(.black, for: .normal)
		$0.backgroundColor = .white
		$0.setBorder(borderColor: .gray01, borderWidth: 1)
		$0.tag = 3
		$0.addTarget(self, action: #selector(problemTypeSelection), for: .touchUpInside)
		
	}
	private let noiseButton = UIButton().then{
		$0.setTitle("소음 관련", for: .normal)
		$0.titleLabel?.textAlignment = .center
		$0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 13)
		$0.setRounded(radius: 15)
		$0.setTitleColor(.black, for: .normal)
		$0.backgroundColor = .white
		$0.setBorder(borderColor: .gray01, borderWidth: 1)
		$0.tag = 4
    $0.addTarget(self, action: #selector(problemTypeSelection), for: .touchUpInside)
		
	}
	private let questionButton = UIButton().then{
		$0.setTitle("거주 수칙 관련", for: .normal)
		$0.titleLabel?.textAlignment = .center
		$0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 13)
		$0.setRounded(radius: 15)
		$0.setTitleColor(.black, for: .normal)
		$0.backgroundColor = .white
		$0.setBorder(borderColor: .gray01, borderWidth: 1)
		$0.tag = 5
		$0.addTarget(self, action: #selector(problemTypeSelection), for: .touchUpInside)
		
	}
	private let etcButton = UIButton().then{
		$0.setTitle("그 외", for: .normal)
		$0.titleLabel?.textAlignment = .center
		$0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 13)
		$0.setRounded(radius: 15)
		$0.setTitleColor(.black, for: .normal)
		$0.backgroundColor = .white
		$0.setBorder(borderColor: .gray01, borderWidth: 1)
		$0.tag = 6
		$0.addTarget(self, action: #selector(problemTypeSelection), for: .touchUpInside)
	}
	
	private var questionTitle = UITextField().then{
		$0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 21)
		$0.borderStyle = .none
		$0.placeholder("제목을 작성해주세요")
		$0.textColor = .black
	}
	private let underBar = UIView().then {
		$0.backgroundColor = .gray01
	}
	private var questionDescription = UITextView().then{
		$0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
		$0.setRounded(radius: 16)
		$0.setBorder(borderColor: .gray01, borderWidth: 1)
		$0.text = "내용을 작성해주세요"
		$0.backgroundColor = .white
		$0.textColor = .gray01
		$0.textContainerInset = UIEdgeInsets(top: 24, left: 16, bottom: 24, right: 16)
	}
	private var nextStep = UIButton().then{
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
		$0.currentPageIndicatorTintColor = .primaryOrange
		$0.tintColor = .gray01
		$0.pageIndicatorTintColor = .gray01
	}
	
	
	// MARK: - Helper

	@objc func nextButtonDidTapped() {
		let cameraView = CameraWorkViewController()
		navigationController?.pushViewController(cameraView, animated: true)
	}
	
	@objc func problemTypeSelection(sender : UIButton) {
		buttonBackgroundRefresher()
		sender.backgroundColor = .primaryOrange
		sender.setTitleColor(.white, for: .normal)
		sender.setBorder(borderColor: .primaryOrange, borderWidth: 1)
		switch sender.tag {
		case 1:
			requestData.cartegory = 0
		case 2:
			requestData.cartegory = 1
		case 3:
			requestData.cartegory = 2
		case 4:
			requestData.cartegory = 3
		case 5:
			requestData.cartegory = 4
		case 6:
			requestData.cartegory = 5
		default:
			requestData.cartegory = 6
		}
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
		requestData.cartegory = 0
	}
	private func initLayout() {
		self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
		self.navigationController?.navigationBar.shadowImage = UIImage()
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
			$0.top.equalToSuperview().offset(6)
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
			$0.height.equalTo(48)
		}
		page.snp.makeConstraints{
			$0.top.equalTo(nextStep.snp.bottom).offset(24)
			$0.bottom.equalToSuperview()
			$0.centerX.equalToSuperview()
		}
		
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
		
		let promiseTap = UITapGestureRecognizer(target: self, action: #selector(promiseTapped))
		let notPromiseTap = UITapGestureRecognizer(target: self, action: #selector(notPromiseTapped))
		self.promiseRequiredView.addGestureRecognizer(promiseTap)
		self.promiseNotRequiredView.addGestureRecognizer(notPromiseTap)
	}
	
	
	
	private func bind() {
		let inputOb : Observable<Bool> = questionTitle.rx.text.map{$0 == ""}.asObservable()
		let desInputOb : Observable<Bool> = questionDescription.rx.text.orEmpty.map{$0 == "내용을 작성해주세요"}.asObservable()
		inputOb.subscribe{ b in
			self.underBar.backgroundColor = b.element! ? .gray01 : .black
		}.disposed(by: disposeBag)
		desInputOb.subscribe{ b in
			if !b.element! {
				self.questionDescription.layer.applyShadow(color: .black, alpha: 0.1, x: 0, y: 0, blur: 8)
				self.questionDescription.setBorder(borderColor: .black, borderWidth: 0)
				self.questionDescription.clipsToBounds = false
			}
			else {
				self.questionDescription.layer.applyShadow(color: .black, alpha: 0, x: 0, y: 0, blur: 8)
				self.questionDescription.setBorder(borderColor: .gray01, borderWidth: 1)
				self.questionDescription.clipsToBounds = true
			}
		}.disposed(by: disposeBag)
		
		Observable.combineLatest(inputOb, desInputOb, resultSelector: { !$0 && !$1})
			.subscribe{ b in
				self.nextStep.isEnabled = b.element!
				self.nextButtonLayout(b.element!)
			}
			.disposed(by: disposeBag)
	}
	func nextButtonLayout(_ b : Bool) {
		if b {
			self.nextStep.backgroundColor = .black
			
		}
		else {
			self.nextStep.backgroundColor = .gray01
			
		}
	}
	@objc func promiseTapped(recognizer: UITapGestureRecognizer) {
		self.promiseRequiredView.setBorder(borderColor: .primaryOrange, borderWidth: 2)
		self.promiseNotRequiredView.setBorder(borderColor: .gray01, borderWidth: 1)
		self.page.numberOfPages = 4
		requestData.isPromiseNeeded = true
	}
	@objc func notPromiseTapped(recognizer: UITapGestureRecognizer) {
		self.promiseNotRequiredView.setBorder(borderColor: .primaryOrange, borderWidth: 2)
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
	
	@objc func handleTap(recognizer: UITapGestureRecognizer){
		
		self.view.endEditing(true)
	}
	@objc
	func backButtonDidTab() {
		self.dismiss(animated: true, completion: nil)
	}
	// MARK: - Life Cycle

	override func viewDidLoad() {
		super.viewDidLoad()
		bind()
		//		view.backgroundColor = .cyan
		dataPreset()
		layout()
		initLayout()
		let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
		self.contentView.addGestureRecognizer(tap)
	}
}

// MARK: - TextViewDelegate
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
	}
}

// MARK: - TextFeildDelegate
extension PromiseViewController : UITextFieldDelegate{
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	func textFieldDidEndEditing(_ textField: UITextField) {
		requestData.title = textField.text ?? ""
		
	}
}
