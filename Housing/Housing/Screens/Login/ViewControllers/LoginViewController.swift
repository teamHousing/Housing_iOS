//
//  LoginViewController.swift
//  Housing
//
//  Created by 곽민제 on 2021/01/01.
//

import UIKit

import RxMoya
import Moya
import RxCocoa
import RxSwift


class LoginViewController: BaseViewController {
	
	//MARK:- Component(Outlet)
	@IBOutlet weak var idTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var LoginButtonView: UIButton!
	@IBOutlet weak var idBottomView: UIView!
	@IBOutlet weak var passwordBottomView: UIView!
	@IBOutlet weak var warningLabel: UILabel!
	
	// MARK: - Service
	
	private let userProvider = MoyaProvider<UserService>(plugins: [NetworkLoggerPlugin(verbose: true)])

	
	//MARK:- Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		initLayout()
		
		idTextField.delegate = self
		passwordTextField.delegate = self
	}
	
	//MARK:- Helper
	func initLayout() {
		navigationController?.navigationBar.isHidden = true
		
		idTextField.borderWidth = 1
		idTextField.borderColor = .white
		idTextField.tintColor = UIColor(red: 255 / 255, green: 133 / 255, blue: 119 / 255, alpha: 1)
		
		passwordTextField.borderWidth = 1
		passwordTextField.borderColor = .white
		passwordTextField.tintColor = UIColor(red: 255 / 255, green: 133 / 255, blue: 119 / 255, alpha: 1)
		
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
		
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
		
		LoginButtonView.backgroundColor = UIColor(red: 219 / 255, green: 219 / 255, blue: 219 / 255, alpha: 1)
		LoginButtonView.layer.cornerRadius = 0.5 * LoginButtonView.bounds.size.height
		LoginButtonView.isEnabled = false
	}
	
	@objc func keyboardWillShow(_ sender: Notification) {
		
		self.view.frame.origin.y = 0
	}
	
	@objc func keyboardWillHide(_ sender: Notification) {
		
		self.view.frame.origin.y = 0
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
		
		self.view.endEditing(true)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		navigationController?.navigationBar.isHidden = true
	}
	
	//MARK:- Component(Action)
	
	@IBAction func signinButtonDidTap(_ sender: Any) {

		let viewcontroller = TabBarViewController()
		viewcontroller.modalPresentationStyle = .fullScreen
		self.present(viewcontroller, animated: true)
//		userProvider.rx.request(.signin(email: idTextField.text ?? "",
//																		password: passwordTextField.text ?? ""))
//			.asObservable()
//			.subscribe { (next) in
//				print(next.statusCode)
//				
//			} onError: { (error) in
//				print(error.localizedDescription)
//			}.disposed(by: disposeBag)

//		let viewcontroller = TabBarViewController()

//		userProvider.rx.request(.signin(email: idTextField.text ?? "",
//																		password: passwordTextField.text ?? ""))
//			.asObservable()
//			.subscribe { (next) in
//				print(next.statusCode)
//			} onError: { (error) in
//				print(error.localizedDescription)
//			}.disposed(by: disposeBag)
		
	}
	
	
	@IBAction func signupButton(_ sender: Any) {
		let signinStoryboard = UIStoryboard(name: "Signup", bundle: nil)
		let viewController = signinStoryboard.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
		
		navigationController?.pushViewController(viewController, animated: true)
	}
}

//MARK:- Object Extension
extension LoginViewController: UITextFieldDelegate {
	func textFieldDidEndEditing(_ textField: UITextField) {
		if idTextField.text != "" && passwordTextField.text != "" {
			LoginButtonView.backgroundColor = .primaryBlack
			LoginButtonView.layer.cornerRadius = 0.5 * LoginButtonView.bounds.size.height
			LoginButtonView.isEnabled = true
		}
		else if idTextField.text == "" || passwordTextField.text == "" {
			LoginButtonView.backgroundColor = UIColor(red: 219 / 255, green: 219 / 255, blue: 219 / 255, alpha: 1)
			LoginButtonView.layer.cornerRadius = 0.5 * LoginButtonView.bounds.size.height
			LoginButtonView.isEnabled = false
		}
	}
}
