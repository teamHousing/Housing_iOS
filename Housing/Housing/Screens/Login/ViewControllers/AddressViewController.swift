//
//  AddressViewController.swift
//  Housing
//
//  Created by 곽기곤's Mac on 2021/01/07.
//

import UIKit

import Moya
import RxMoya
import SwiftKeychainWrapper

final class AddressViewController: BaseViewController {
	
	//MARK:- Component(Outlet)
	@IBOutlet weak var toNextButton: UIButton!
	@IBOutlet weak var addressTextField: UITextField!
	@IBOutlet weak var buildingTextField: UITextField!
	
	//MARK: - Property
	var loginData = Host(userName: nil, age: nil, email: nil,
											 password: nil, address: nil, building: nil)
	private let userProvider = MoyaProvider<UserService>(plugins: [NetworkLoggerPlugin(verbose: true)])
	//MARK:- Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		initLayout()
		addressTextField.addTarget(self,
															 action: #selector(addressTextFieldChanged(_:)),
															 for: .editingChanged)
		buildingTextField.addTarget(self,
																action: #selector(addressTextFieldChanged(_:)),
																for: .editingChanged)
	}
	
	//MARK:- Helper
	@objc
	private func addressTextFieldChanged(_ textField: UITextField) {
		if addressTextField.text?.count == 0 || buildingTextField.text?.count == 0 {
			toNextButton.backgroundColor = UIColor(red: 219 / 255,
																						 green: 219 / 255,
																						 blue: 219 / 255,
																						 alpha: 1)
			toNextButton.layer.cornerRadius = 0.5 * toNextButton.bounds.size.height
			toNextButton.isEnabled = false
			
			
		} else {
			toNextButton.backgroundColor = .primaryBlack
			toNextButton.layer.cornerRadius = 0.5 * toNextButton.bounds.size.height
			toNextButton.isEnabled = true
		}
	}
	
	private func initLayout() {
		addressTextField.tintColor = UIColor.primaryOrange
		buildingTextField.tintColor = UIColor.primaryOrange
		
		toNextButton.backgroundColor = UIColor(red: 219 / 255,
																					 green: 219 / 255,
																					 blue: 219 / 255,
																					 alpha: 1)
		toNextButton.layer.cornerRadius = 0.5 * toNextButton.bounds.size.height
		toNextButton.isEnabled = false
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
		
		self.view.endEditing(true)
	}
	
	//MARK:- Component(Action)
	@IBAction func toSelectButton(_ sender: Any) {
		navigationController?.popViewController(animated: true)
	}
	
	@IBAction func toNextButton(_ sender: Any) {
		guard let address = addressTextField.text,
					let building = buildingTextField.text
		else {
			return
		}
		userProvider.rx.request(.hostSignup(userName: loginData.userName ?? "",
																				age: loginData.age ?? 0,
																				email: loginData.email ?? "",
																				password: loginData.password ?? "",
																				address: address,
																				building: building))
			.asObservable()
			.subscribe( onNext: { response in
				if response.statusCode == 200 {
					
					guard let token = (response.response?.allHeaderFields["Set-Cookie"] ?? "") as? String else {
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
																					from: response.data)
						guard let result = data.data?.type else {
							return
						}
						KeychainWrapper.standard.set(result,
																				 forKey: KeychainStorage.isHost)
						KeychainWrapper.standard.set(cookie,
																				 forKey: KeychainStorage.accessToken)
						
						let viewcontroller = self.storyboard?.instantiateViewController(
							withIdentifier: "SignupCompleteViewController") as! SignupCompleteViewController
						self.navigationController?.pushViewController(viewcontroller, animated: true)
					} catch {
						print(error)
					}
				}
				print(response)
			}, onError: { error in
				print(error)
			}).disposed(by: disposeBag)
		
	}
}

//MARK:- Object Extension
private struct User: Codable {
	let id, type: Int
}
