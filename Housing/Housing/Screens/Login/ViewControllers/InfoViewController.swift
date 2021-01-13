//
//  InfoViewController.swift
//  Housing
//
//  Created by 오준현 on 2021/01/09.
//

import UIKit

import RxCocoa
import RxSwift
import RxKeyboard

class InfoViewController: BaseViewController {
	//MARK:- Property
	
	
	private let scrollView = UIScrollView()
	private let containerView = UIView()
	private let guideLabel = UILabel().then {
		$0.text = "Join"
		$0.font = BaskervilleFont.bold.of(size: 40)
	}
	private let nameGuideLabel = UILabel().then {
		$0.text = "이름"
		$0.font = .systemFont(ofSize: 16)
	}
	private let ageGuideLabel = UILabel().then {
		$0.text = "나이"
		$0.font = .systemFont(ofSize: 16)
	}
	private let idGuideLabel = UILabel().then {
		$0.text = "아이디"
		$0.font = .systemFont(ofSize: 16)
	}
	private let passwordGuideLabel = UILabel().then {
		$0.text = "비밀번호"
		$0.font = .systemFont(ofSize: 16)
	}
	private let certificationGuideLabel = UILabel().then {
		$0.text = "비밀번호 재확인"
		$0.font = .systemFont(ofSize: 16)
	}
	private let nameTextField = UITextField().then {
		$0.placeholder = "홍길동"
		$0.font = .systemFont(ofSize: 14, weight: .regular)
		$0.tintColor = .primaryOrange
	}
	private let ageTextField = UITextField().then {
		$0.placeholder = "40"
		$0.keyboardType = .numberPad
		$0.tintColor = .primaryOrange
		$0.font = .systemFont(ofSize: 14, weight: .regular)
	}
	private let idTextField = UITextField().then {
		$0.placeholder = "아이디를 입력해 주세요."
		$0.tintColor = .primaryOrange
		$0.font = .systemFont(ofSize: 14, weight: .regular)
	}
	private let passwordTextField = UITextField().then {
		$0.placeholder = "비밀번호를 입력해 주세요."
		$0.tintColor = .primaryOrange
		$0.font = .systemFont(ofSize: 14, weight: .regular)
	}
	private let certificationTextField = UITextField().then {
		$0.placeholder = "다시 한 번 입력해 주세요."
		$0.tintColor = .primaryOrange
		$0.font = .systemFont(ofSize: 14, weight: .regular)
	}
	private let nameUnderBarView = UIView().then {
		$0.backgroundColor = .primaryBlack
	}
	private let ageUnderBarView = UIView().then {
		$0.backgroundColor = .primaryBlack
	}
	private let idUnderBarView = UIView().then {
		$0.backgroundColor = .primaryBlack
	}
	private let passwordUnderBarView = UIView().then {
		$0.backgroundColor = .primaryBlack
	}
	private let certificationUnderBarView = UIView().then {
		$0.backgroundColor = .primaryBlack
	}
	private let nextButton = UIButton().then {
		$0.isEnabled = false
		$0.backgroundColor = UIColor(red: 219/255, green: 219/255, blue: 219/255, alpha: 1)
		$0.layer.cornerRadius = 24
		$0.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
		$0.setTitle("다음", for: .normal)
		$0.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		layout()
		textFieldBind()
	}
	
	private func layout() {
		view.add(scrollView) {
			$0.snp.makeConstraints {
				$0.edges.equalTo(self.view.safeAreaLayoutGuide)
			}
		}
		scrollView.add(containerView) {
			$0.snp.makeConstraints {
				$0.edges.equalTo(self.scrollView)
				$0.width.equalTo(self.scrollView)
				$0.height.greaterThanOrEqualTo(self.scrollView)
			}
		}
		containerView.adds([
			guideLabel,
			nameGuideLabel,
			ageGuideLabel,
			idGuideLabel,
			passwordGuideLabel,
			certificationGuideLabel,
			nameTextField,
			ageTextField,
			idTextField,
			passwordTextField,
			certificationTextField,
			nameUnderBarView,
			ageUnderBarView,
			idUnderBarView,
			passwordUnderBarView,
			certificationUnderBarView,
			nextButton
		])
		guideLabel.snp.makeConstraints {
			$0.top.equalTo(containerView).offset(-10)
			$0.leading.equalTo(containerView).offset(26)
		}
		nameGuideLabel.snp.makeConstraints {
			$0.top.equalTo(guideLabel.snp.bottom).offset(65)
			$0.leading.equalTo(containerView).offset(32)
		}
		ageGuideLabel.snp.makeConstraints {
			$0.top.equalTo(nameGuideLabel.snp.bottom).offset(68)
			$0.leading.equalTo(containerView).offset(32)
		}
		idGuideLabel.snp.makeConstraints {
			$0.top.equalTo(ageGuideLabel.snp.bottom).offset(68)
			$0.leading.equalTo(containerView).offset(32)
		}
		passwordGuideLabel.snp.makeConstraints {
			$0.top.equalTo(idGuideLabel.snp.bottom).offset(68)
			$0.leading.equalTo(containerView).offset(32)
		}
		certificationGuideLabel.snp.makeConstraints  {
			$0.top.equalTo(passwordGuideLabel.snp.bottom).offset(68)
			$0.leading.equalTo(containerView).offset(32)
			$0.bottom.equalTo(containerView).offset(-300)
		}
		nameTextField.snp.makeConstraints {
			$0.bottom.equalTo(nameUnderBarView.snp.top).offset(-6)
			$0.leading.trailing.equalTo(nameUnderBarView)
			$0.height.equalTo(18)
		}
		ageTextField.snp.makeConstraints {
			$0.bottom.equalTo(ageUnderBarView.snp.top).offset(-6)
			$0.leading.trailing.equalTo(ageUnderBarView)
			$0.height.equalTo(18)
		}
		idTextField.snp.makeConstraints {
			$0.bottom.equalTo(idUnderBarView.snp.top).offset(-6)
			$0.leading.trailing.equalTo(idUnderBarView)
			$0.height.equalTo(18)
		}
		passwordTextField.snp.makeConstraints {
			$0.bottom.equalTo(passwordUnderBarView.snp.top).offset(-6)
			$0.leading.trailing.equalTo(passwordUnderBarView)
			$0.height.equalTo(18)
		}
		certificationTextField.snp.makeConstraints {
			$0.bottom.equalTo(certificationUnderBarView.snp.top).offset(-6)
			$0.leading.trailing.equalTo(certificationUnderBarView)
			$0.height.equalTo(18)
		}
		nameUnderBarView.snp.makeConstraints {
			$0.leading.equalTo(containerView).offset(32)
			$0.trailing.equalTo(containerView).offset(-32)
			$0.top.equalTo(nameGuideLabel.snp.bottom).offset(38)
			$0.height.equalTo(1)
		}
		ageUnderBarView.snp.makeConstraints {
			$0.leading.equalTo(containerView).offset(32)
			$0.trailing.equalTo(containerView).offset(-32)
			$0.top.equalTo(ageGuideLabel.snp.bottom).offset(38)
			$0.height.equalTo(1)
		}
		idUnderBarView.snp.makeConstraints {
			$0.leading.equalTo(containerView).offset(32)
			$0.trailing.equalTo(containerView).offset(-32)
			$0.top.equalTo(idGuideLabel.snp.bottom).offset(38)
			$0.height.equalTo(1)
		}
		passwordUnderBarView.snp.makeConstraints {
			$0.leading.equalTo(containerView).offset(32)
			$0.trailing.equalTo(containerView).offset(-32)
			$0.top.equalTo(passwordGuideLabel.snp.bottom).offset(38)
			$0.height.equalTo(1)
		}
		certificationUnderBarView.snp.makeConstraints {
			$0.leading.equalTo(containerView).offset(32)
			$0.trailing.equalTo(containerView).offset(-32)
			$0.top.equalTo(certificationGuideLabel.snp.bottom).offset(38)
			$0.height.equalTo(1)
		}
		nextButton.snp.makeConstraints {
			$0.centerX.equalTo(containerView)
			$0.width.equalTo(255)
			$0.height.equalTo(48)
			$0.top.equalTo(certificationGuideLabel.snp.bottom).offset(136)
		}
	}
	
	private func textFieldBind() {
		
		nameTextField.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: { next in
			self.ageTextField.becomeFirstResponder()
			//
		}).disposed(by: disposeBag)
		ageTextField.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: { next in
			self.idTextField.becomeFirstResponder()
			//
		}).disposed(by: disposeBag)
		idTextField.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: { next in
			self.passwordTextField.becomeFirstResponder()
			//
		}).disposed(by: disposeBag)
		passwordTextField.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: { next in
			self.certificationTextField.becomeFirstResponder()
			//
		}).disposed(by: disposeBag)
		certificationTextField.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: { next in
			self.scrollView.setContentOffset(CGPoint(x: 0,
																							 y: 100),
																			 animated: true)
			//
			
		}).disposed(by: disposeBag)
		ageTextField.rx.controlEvent(.editingDidBegin).subscribe(onNext: { next in
			self.scrollView.setContentOffset(CGPoint(x: 0,
																							 y: self.ageTextField.frame.origin.y-200),
																			 animated: true)
		}).disposed(by: disposeBag)
		idTextField.rx.controlEvent(.editingDidBegin).subscribe(onNext: { next in
			self.scrollView.setContentOffset(CGPoint(x: 0,
																							 y: self.idTextField.frame.origin.y-200),
																			 animated: true)
		}).disposed(by: disposeBag)
		passwordTextField.rx.controlEvent(.editingDidBegin).subscribe(onNext: { next in
			self.scrollView.setContentOffset(CGPoint(x: 0,
																							 y: self.passwordTextField.frame.origin.y-200),
																			 animated: true)
		}).disposed(by: disposeBag)
		certificationTextField.rx.controlEvent(.editingDidBegin).subscribe(onNext: { next in
			self.scrollView.setContentOffset(CGPoint(x: 0,
																							 y: self.certificationTextField.frame.origin.y-200),
																			 animated: true)
		}).disposed(by: disposeBag)
		nameTextField.rx.controlEvent(.editingChanged).subscribe(onNext: {
			self.detectIsEmpty()
		}).disposed(by: disposeBag)
		ageTextField.rx.controlEvent(.editingChanged).subscribe(onNext: {
			self.detectIsEmpty()
		}).disposed(by: disposeBag)
		idTextField.rx.controlEvent(.editingChanged).subscribe(onNext: {
			self.detectIsEmpty()
		}).disposed(by: disposeBag)
		passwordTextField.rx.controlEvent(.editingChanged).subscribe(onNext: {
			self.detectIsEmpty()
		}).disposed(by: disposeBag)
		certificationTextField.rx.controlEvent(.editingChanged).subscribe(onNext: {
			self.detectIsEmpty()
		}).disposed(by: disposeBag)
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
		containerView.addGestureRecognizer(tapGesture)
		scrollView.addGestureRecognizer(tapGesture)
	}
	
	@objc
	private func handleTap(sender: UIGestureRecognizer) {
		view.endEditing(true)
		scrollView.setContentOffset(CGPoint(x: 0,
																				y: 0),
																animated: true)
	}
	
	override func touchesBegan(_ touches: Set<UITouch>,
														 with event: UIEvent?){
		view.endEditing(true)
	}
	
	private func detectIsEmpty() {
		guard let name = nameTextField.text?.isEmpty,
					let age = ageTextField.text?.isEmpty,
					let id = idTextField.text?.isEmpty,
					let password = passwordTextField.text?.isEmpty,
					let certification = certificationTextField.text?.isEmpty else {
			return
		}
		if !name && !age && !id && !password && !certification {
			nextButton.isEnabled = true
			nextButton.backgroundColor = .primaryBlack
		} else {
			nextButton.isEnabled = false
			nextButton.backgroundColor = UIColor(red: 219/255, green: 219/255, blue: 219/255, alpha: 1)
		}
	}
	
	@objc
	private func nextButtonDidTap() {
		guard let name = nameTextField.text,
					let age = ageTextField.text,
					let email = idTextField.text,
					let password = passwordTextField.text
					else {
			return
		}
		
		let storyboard = UIStoryboard(name: StoryboardStorage.signup,
																	bundle: nil)
		let viewcontroller = storyboard.instantiateViewController(withIdentifier: "AddressViewController") as! AddressViewController
		viewcontroller.loginData = Host(userName: name,
																		age: Int(age) ?? 0,
																		email: email,
																		password: password,
																		address: nil, building: nil)
		navigationController?.pushViewController(viewcontroller, animated: false)
	}
}

extension InfoViewController: UIScrollViewDelegate {
	
}
