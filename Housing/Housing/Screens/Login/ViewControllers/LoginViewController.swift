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
import SwiftKeychainWrapper
import SwiftyJSON

final class LoginViewController: BaseViewController {
	
	//MARK:- Component(Outlet)
	@IBOutlet weak var idTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var LoginButton: UIButton!
	@IBOutlet weak var idBottomView: UIView!
	@IBOutlet weak var passwordBottomView: UIView!
	@IBOutlet weak var warningLabel: UILabel!
	
	// MARK: - Service
	private let userProvider = MoyaProvider<UserService>(plugins: [NetworkLoggerPlugin(verbose: true)])
	
	//MARK:- Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		initLayout()
		
		idTextField.addTarget(self,
													action: #selector(idTextFieldChanged),
													for: .editingChanged)
		passwordTextField.addTarget(self,
																action: #selector(idTextFieldChanged),
																for: .editingChanged)
	}
	
	//MARK:- Helper
	@objc
	private func idTextFieldChanged(_ textField: UITextField) {
		if idTextField.text?.count == 0 || passwordTextField.text?.count == 0 {
			LoginButton.backgroundColor = UIColor(red: 219 / 255,
																						green: 219 / 255,
																						blue: 219 / 255,
																						alpha: 1)
			LoginButton.layer.cornerRadius = 0.5 * LoginButton.bounds.size.height
			LoginButton.isEnabled = false
		} else {
			LoginButton.backgroundColor = .primaryBlack
			LoginButton.layer.cornerRadius = 0.5 * LoginButton.bounds.size.height
			LoginButton.isEnabled = true
		}
	}
	private func makeAlert() {

	}
	private func initLayout() {
		navigationController?.navigationBar.isHidden = true
		
		idTextField.borderWidth = 1
		idTextField.borderColor = .white
		idTextField.tintColor = UIColor.primaryOrange
		
		passwordTextField.borderWidth = 1
		passwordTextField.borderColor = .white
		passwordTextField.tintColor = UIColor.primaryOrange
		passwordTextField.isSecureTextEntry = true
		LoginButton.backgroundColor = UIColor(red: 219 / 255,
																					green: 219 / 255,
																					blue: 219 / 255,
																					alpha: 1)
		LoginButton.layer.cornerRadius = 0.5 * LoginButton.bounds.size.height
		LoginButton.isEnabled = false
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
		userProvider.rx.request(.signin(email: idTextField.text ?? "",
																		password: passwordTextField.text ?? ""))
			.asObservable()
			.subscribe { (next) in
				if next.statusCode == 200 {
					guard let token = (next.response?.allHeaderFields["Set-Cookie"] ?? "") as? String else {
						return
					}
					var cookies: [String]? = []
					
					cookies = token.components(separatedBy: ";")
					cookies = cookies?[0].components(separatedBy: "=")
					
					guard let cookie = cookies?[1] else {
						return
					}
					do{
						let decoder = JSONDecoder()
						let data = try decoder.decode(ResponseType<User>.self,
																					from: next.data)
						guard let result = data.data?.type else {
							return
						}
						KeychainWrapper.standard.set(result,
																				 forKey: KeychainStorage.isHost)
						
						KeychainWrapper.standard.set(cookie,
																				 forKey: KeychainStorage.accessToken)
						
						let viewcontroller = TabBarViewController()
//						let p = PromiseViewController()
//						let viewcontroller = UINavigationController(rootViewController: p)
						viewcontroller.modalPresentationStyle = .fullScreen
						self.present(viewcontroller, animated: true)
						
					} catch {
						print(error)
					}
				}
				else if next.statusCode == 400 {
					let alert = UIAlertController(title : "로그인 실패", message: "아이디나 비밀번호가 일치하지 않습니다.", preferredStyle: .alert)
					let action = UIAlertAction(title: "확인", style: .cancel) {(action) in
						self.idTextField.text = nil
						self.passwordTextField.text = nil
						self.LoginButton.backgroundColor = UIColor(red: 219 / 255,
																									green: 219 / 255,
																									blue: 219 / 255,
																									alpha: 1)
						self.LoginButton.isEnabled = false
					}
					alert.addAction(action)
					self.present(alert, animated: false, completion: nil)
				}
			} onError: { (error) in
				print(error.localizedDescription)
			}.disposed(by: disposeBag)
	}
	
	@IBAction func signupButton(_ sender: Any) {
		let signinStoryboard = UIStoryboard(name: "Signup", bundle: nil)
		let viewController = signinStoryboard.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
		
		navigationController?.pushViewController(viewController, animated: true)
	}
}

//MARK:- Object Extension
private struct User: Codable {
	let id, type: Int
}
