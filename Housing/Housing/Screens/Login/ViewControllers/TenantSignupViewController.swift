//
//  TenantSignupViewController.swift
//  Housing
//
//  Created by 곽기곤's Mac on 2021/01/15.
//

import UIKit

import RxMoya
import Moya

class TenantSignupViewController: BaseViewController {
	
	// MARK:- Component(Outlet)
	@IBOutlet weak var verifyNumberTextField: UITextField!
	@IBOutlet weak var nextButton: UIButton!
	
	// MARK: -
	var isHost: Int?
	
	
	// MARK: -
	private let userProvider = MoyaProvider<UserService>(plugins: [NetworkLoggerPlugin(verbose: true)])
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		initLayout()
		
		verifyNumberTextField.addTarget(self,
																		action: #selector(verifyTextFieldChanged(_:)),
																		for: .editingChanged)
		verifyNumberTextField.addTarget(self,
																		action: #selector(verifyTextFieldChanged(_:)),
																		for: .editingChanged)
	}
	
	//MARK:- Helper
	@objc
	private func verifyTextFieldChanged(_ textField: UITextField) {
		if verifyNumberTextField.text?.count == 0 {
			nextButton.backgroundColor = UIColor(red: 219 / 255,
																					 green: 219 / 255,
																					 blue: 219 / 255,
																					 alpha: 1)
			nextButton.layer.cornerRadius = 0.5 * nextButton.bounds.size.height
			nextButton.isEnabled = false
		} else {
			nextButton.backgroundColor = .primaryOrange
			nextButton.layer.cornerRadius = 0.5 * nextButton.bounds.size.height
			nextButton.isEnabled = true
		}
	}
	
	func initLayout() {
		navigationController?.navigationBar.isHidden = false
		navigationController?.navigationBar.topItem?.title = ""
		verifyNumberTextField.tintColor = .primaryOrange
		
		nextButton.backgroundColor = UIColor(red: 219 / 255,
																				 green: 219 / 255,
																				 blue: 219 / 255,
																				 alpha: 1)
		nextButton.layer.cornerRadius = 0.5 * nextButton.bounds.size.height
		nextButton.isEnabled = false
	}
	
	@IBAction func navigationBackButton(_ sender: Any) {
		navigationController?.popViewController(animated: true)
	}
	
	@IBAction func toNextButton(_ sender: Any) {
		guard let number = verifyNumberTextField.text else {
			return
		}
		userProvider.rx.request(.validation(number: Int(number) ?? 0))
			.asObservable()
			.subscribe { (response) in
				if response.statusCode == 200 {
					let viewController = InfoViewController()
					viewController.isHost = self.isHost
					viewController.number = Int(number) ?? 0
					self.navigationController?.pushViewController(viewController, animated: true)
				} else {
					self.showToast("에러가 발생했습니다.",
												 isBottom: true,
												 yAnchor: 0,
												 textColor: .white,
												 textFont: .systemFont(ofSize: 16),
												 backgroundColor: UIColor.primaryBlack.withAlphaComponent(0.7),
												 backgroundRadius: 10,
												 duration: 5)
				}
			} onError: { (error) in
				print(error.localizedDescription)
			}.disposed(by: disposeBag)
	}
	
	override func touchesBegan(_ touches: Set<UITouch>,
														 with event: UIEvent?){
		view.endEditing(true)
	}
}
