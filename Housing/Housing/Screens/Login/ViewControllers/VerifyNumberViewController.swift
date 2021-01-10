//
//  VerifyNumberViewController.swift
//  Housing
//
//  Created by 김태훈 on 2021/01/09.
//

import UIKit
import RxSwift
import RxCocoa

class VerifyNumberViewController: UIViewController {
	let disposeBag = DisposeBag()
	
	private let backButton = UIButton().then{
		$0.setImage(UIImage(named: ""), for: .normal)
	}
	private let shareButton = UIButton().then{
		$0.setImage(UIImage(named: ""), for: .normal)
		$0.addTarget(self, action: #selector(shareNumber(sender:)), for: .touchUpInside)
	}
	private let upperView = UIView().then {
		$0.backgroundColor = .white
		$0.setRounded(radius: 15)
		$0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
		$0.layer.applyCardShadow()
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
	
	private let buildingNumber = UITextField().then {
		$0.borderStyle = .none
		$0.placeholder = "101, A, BEST"
		$0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 21)
	}
	private let buildingNumberUnderbar = UIView().then {
		$0.backgroundColor = .gray01
	}
	private let houseNumber = UITextField().then {
		$0.borderStyle = .none
		$0.placeholder = "101"
		$0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 21)
	}
	private let houseNumberUnderbar = UIView().then {
		$0.backgroundColor = .gray01
	}
	private let dong  = UILabel().then {
		$0.text = "동"
		$0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 21)
		$0.textColor = .black
		$0.textAlignment = .left
	}
	private let ho  = UILabel().then {
		$0.text = "호"
		$0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 21)
		$0.textColor = .black
		$0.textAlignment = .left
	}
	private var makeNumber = UIButton().then{
		$0.backgroundColor = .white
		$0.setTitle("생성하기", for: .normal)
		$0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
		$0.setTitleColor(.gray01, for: .normal)
		$0.isEnabled = true
		$0.setRounded(radius: 25)
		$0.setBorder(borderColor: .gray01, borderWidth: 1)
		$0.addTarget(self, action: #selector(makeTheNumber), for: .touchUpInside)
	}
	
	private let verifyNumber = UILabel().then{
		$0.text = "1234"
		$0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 32)
		$0.textColor = .black
		$0.textAlignment = .center
		$0.setRounded(radius: 15)
		$0.backgroundColor = .primaryGray
	}
	private let sideLine = UIView().then{
		$0.backgroundColor = .black
	}
	private let noticeLabel = UILabel().then{
		$0.text = "유의사항"
		$0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
		$0.textColor = .black
		$0.textAlignment = .left
	}
	private let noticeDescription = UILabel().then {
		$0.numberOfLines = 0
		$0.lineBreakMode = .byWordWrapping
		$0.text = """
			이 인증번호는 세입자의 회원가입을 위한 번호입니다. 실제 거주하는 세입자가 아니라면 이 인증번호를 부여하지 마십시오.

			이 인증번호는 한 가구에게만 유효한 번호입니다. 다른 가구에게 인증번호를 부여하고 싶은 경우에는 새롭게 정보를 입력한 뒤 생성하기 버튼을 누르십시오.
			"""
		$0.font = UIFont(name: "AppleSDGothicNeo-Light", size: 14)
		$0.textColor = .black
	}
	private let deleteButton1 = UIButton().then {
		$0.setImage(UIImage(named: "btnDelete"), for: .normal)
		$0.isHidden = true
		$0.tag = 1
		$0.addTarget(self, action: #selector(resetTextField(sender:)), for: .touchUpInside)
	}
	private let deleteButton2 = UIButton().then {
		$0.setImage(UIImage(named: "btnDelete"), for: .normal)
		$0.isHidden = true
		$0.tag = 2
		$0.addTarget(self, action: #selector(resetTextField(sender:)), for: .touchUpInside)
	}
	
	private func layout() {
		self.navigationController?.navigationBar.backgroundColor = .white
		self.view.backgroundColor = .primaryGray
		self.navigationController?.navigationBar
		
		self.view.adds([upperView,
										noticeLabel,
										noticeDescription,sideLine])
		self.view.layer.applyCardShadow()
		upperView.snp.makeConstraints{
			$0.top.equalTo(self.view.safeAreaLayoutGuide)
			$0.leading.equalToSuperview()
			$0.trailing.equalToSuperview()
			$0.width.centerX.equalToSuperview()
			//$0.bottom.equalToSuperview().offset(-263)
		}
		upperView.adds([backgroundLabel,
										lineImage,
										buildingNumber,
										buildingNumberUnderbar,
										houseNumber,
										houseNumberUnderbar,
										dong,
										ho,
										makeNumber,
										verifyNumber,
										deleteButton1,
										deleteButton2,
										shareButton])
		backgroundLabel.snp.makeConstraints{
			$0.top.equalToSuperview().offset(0)
			$0.leading.equalTo(view).offset(20)
		}
		lineImage.snp.makeConstraints{
			$0.top.equalToSuperview().offset(22)
			$0.trailing.equalTo(view.safeAreaLayoutGuide).offset(0)
			$0.leading.equalTo(backgroundLabel.snp.trailing).offset(8)
			$0.height.equalTo(1)
		}
		buildingNumber.snp.makeConstraints{
			$0.top.equalTo(lineImage.snp.bottom).offset(68)
			$0.centerX.equalTo(upperView).offset(-15)
			$0.width.equalTo(120)
		}
		buildingNumberUnderbar.snp.makeConstraints{
			$0.centerX.equalTo(buildingNumber)
			$0.width.equalTo(buildingNumber)
			$0.top.equalTo(lineImage.snp.bottom).offset(100)
			$0.height.equalTo(1)
		}
		dong.snp.makeConstraints{
			$0.centerY.equalTo(buildingNumber)
			$0.leading.equalTo(buildingNumber.snp.trailing).offset(8)
		}
		houseNumber.snp.makeConstraints{
			$0.top.equalTo(buildingNumberUnderbar.snp.bottom).offset(23)
			$0.centerX.equalTo(upperView).offset(-15)
			$0.width.equalTo(buildingNumber)
		}
		houseNumberUnderbar.snp.makeConstraints{
			$0.centerX.equalTo(buildingNumber)
			$0.width.equalTo(buildingNumber)
			$0.top.equalTo(buildingNumberUnderbar.snp.bottom).offset(55)
			$0.height.equalTo(1)
		}
		ho.snp.makeConstraints{
			$0.centerY.equalTo(houseNumber)
			$0.leading.equalTo(houseNumber.snp.trailing).offset(8)
		}
		
		deleteButton1.snp.makeConstraints{
			$0.trailing.equalTo(buildingNumber.snp.trailing).offset(0)
			$0.top.equalTo(buildingNumber.snp.top)
			$0.bottom.equalTo(buildingNumber.snp.bottom)
			$0.width.height.equalTo(24)
		}
		deleteButton2.snp.makeConstraints{
			$0.trailing.equalTo(houseNumber.snp.trailing).offset(0)
			$0.top.equalTo(houseNumber.snp.top)
			$0.bottom.equalTo(houseNumber.snp.bottom)
			$0.width.height.equalTo(24)
		}
		makeNumber.snp.makeConstraints{
			$0.top.equalTo(houseNumberUnderbar.snp.bottom).offset(52)
			$0.centerX.equalTo(view)
			$0.width.equalTo(255)
			$0.height.equalTo(48)
		}
		verifyNumber.snp.makeConstraints{
			$0.leading.equalTo(upperView.snp.leading).offset(30)
			$0.trailing.equalTo(upperView.snp.trailing).offset(-30)
			$0.top.equalTo(makeNumber.snp.bottom).offset(-12)
			$0.bottom.equalTo(upperView.snp.bottom).offset(-40)
			$0.centerX.equalTo(upperView)
			$0.height.equalTo(0)
		}
		sideLine.snp.makeConstraints{
			$0.height.equalTo(1)
			$0.leading.equalTo(0)
			$0.width.equalTo(8)
			$0.top.equalTo(upperView.snp.bottom).offset(44)
		}
		noticeLabel.snp.makeConstraints{
			$0.top.equalTo(upperView.snp.bottom).offset(36)
			$0.leading.equalTo(sideLine.snp.trailing).offset(8)
			$0.centerY.equalTo(sideLine.snp.centerY)
		}
		noticeDescription.snp.makeConstraints{
			$0.top.equalTo(noticeLabel.snp.bottom).offset(16)
			$0.leading.equalTo(view).offset(20)
			$0.trailing.equalTo(view).offset(-20)
		}
		shareButton.snp.makeConstraints{
			$0.width.height.equalTo(44)
			$0.top.equalTo(makeNumber.snp.bottom)
			$0.centerX.equalTo(view)
		}
	}
	override func viewDidLoad() {
		bind()
		super.viewDidLoad()
		layout()
		
		let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
		self.view.addGestureRecognizer(tap)
		self.upperView.addGestureRecognizer(tap)
	}
	private func showNumber() {
		self.view.layoutIfNeeded()
		let numberLabelHeight = 94
		let numberLabelTopOffset = 52
		
		verifyNumber.snp.updateConstraints{
			$0.top.equalTo(makeNumber.snp.bottom).offset(numberLabelTopOffset)
			$0.height.equalTo(numberLabelHeight)
		}
		let showNumber = UIViewPropertyAnimator(duration: 0.25, curve: .easeIn, animations:{
			self.view.layoutIfNeeded()
		})
		
		showNumber.startAnimation()
	}
	@objc func makeTheNumber(sender : UIButton) {
		self.showNumber()
	}
	@objc func handleTap(recognizer: UITapGestureRecognizer){
		self.view.endEditing(true)
	}
	@objc func resetTextField(sender : UIButton) {
		if sender.tag == 1 {
			buildingNumber.text = ""
			buildingNumberUnderbar.backgroundColor = .gray01
		}
		else if sender.tag == 2 {
			houseNumber.text = ""
			houseNumberUnderbar.backgroundColor = .gray01
		}
		sender.isHidden = true
	}
	private func bind() {
		let buildingObservable : Observable<Bool> = buildingNumber.rx.text.map{$0 == ""}.asObservable()
		let houseObserverable : Observable<Bool> = houseNumber.rx.text.map{$0 == ""}.asObservable()
		
		buildingObservable.subscribe { b in
			self.buildingNumberUnderbar.backgroundColor = b.element! ?  .gray01 : .black
			self.buildingNumberUnderbar.snp.updateConstraints{
				$0.height.equalTo(b.element! ? 1 : 2)
			}
			self.deleteButton1.isHidden = b.element!
		}.disposed(by: disposeBag)
		houseObserverable.subscribe{ b in
			self.houseNumberUnderbar.backgroundColor = b.element! ? .gray01 : .black
			self.houseNumberUnderbar.snp.updateConstraints{
				$0.height.equalTo(b.element! ? 1 : 2)
			}
			self.deleteButton2.isHidden = b.element!
			
		}.disposed(by: disposeBag)
		Observable.combineLatest(buildingObservable, houseObserverable ,resultSelector: {!$0 && !$1 })
			.subscribe{self.setButtonLayout(b: $0)}.disposed(by: disposeBag)
	}
	func setButtonLayout(b : Bool) {
		self.makeNumber.setBorder(borderColor: b ? .black : .gray01 , borderWidth: 1)
		self.makeNumber.setTitleColor( b ? .black : .gray01 , for: .normal)
		self.makeNumber.isEnabled = b
	}
	@objc func shareNumber(sender : UIButton) {
		var shareObject = [Any]()
		shareObject.append(self.verifyNumber.text)
		let activityViewController = UIActivityViewController(activityItems : shareObject, applicationActivities: nil)
		activityViewController.popoverPresentationController?.sourceView = self.view
		activityViewController.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook,UIActivity.ActivityType.postToTwitter,UIActivity.ActivityType.mail]
		self.present(activityViewController, animated: true, completion: nil)
	}
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destination.
	// Pass the selected object to the new view controller.
	}
	*/
}
