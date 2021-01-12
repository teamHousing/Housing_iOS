//
//  AddressViewController.swift
//  Housing
//
//  Created by 곽기곤's Mac on 2021/01/07.
//

import UIKit

final class AddressViewController: UIViewController {
	
	//MARK:- Component(Outlet)
	@IBOutlet weak var toNextButton: UIButton!
	@IBOutlet weak var addressTextField: UITextField!
	@IBOutlet weak var buildingTextField: UITextField!
	
	//MARK: - Property
	
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
		let viewController = storyboard?.instantiateViewController(
			withIdentifier: "SignupCompleteViewController") as! SignupCompleteViewController
		
		navigationController?.pushViewController(viewController, animated: true)
	}
}
