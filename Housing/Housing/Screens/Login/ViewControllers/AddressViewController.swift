//
//  AddressViewController.swift
//  Housing
//
//  Created by 곽기곤's Mac on 2021/01/07.
//

import UIKit

class AddressViewController: UIViewController {
	
	//MARK:- Component(Outlet)
	@IBOutlet weak var toNextView: UIButton!
	@IBOutlet weak var addressTextField: UITextField!
	@IBOutlet weak var buildingTextField: UITextField!
	
	//MARK:- Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		initLayout()
		
		addressTextField.delegate = self
		buildingTextField.delegate = self
	}
	
	//MARK:- Helper
	func initLayout() {
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
		
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
		
		addressTextField.tintColor = UIColor(red: 255 / 255, green: 133 / 255, blue: 119 / 255, alpha: 1)
		buildingTextField.tintColor = UIColor(red: 255 / 255, green: 133 / 255, blue: 119 / 255, alpha: 1)
		
		toNextView.backgroundColor = UIColor(red: 219 / 255, green: 219 / 255, blue: 219 / 255, alpha: 1)
		toNextView.layer.cornerRadius = 0.5 * toNextView.bounds.size.height
		toNextView.isEnabled = false
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
	
	//MARK:- Component(Action)
	@IBAction func toSelectButton(_ sender: Any) {
		navigationController?.popViewController(animated: true)
	}
	@IBAction func toNextButton(_ sender: Any) {
		let viewController = storyboard?.instantiateViewController(withIdentifier: "SignupCompleteViewController") as! SignupCompleteViewController
		
		navigationController?.pushViewController(viewController, animated: true)
	}
}

extension AddressViewController: UITextFieldDelegate {
	func textFieldDidEndEditing(_ textField: UITextField) {
		if addressTextField.text != "" && buildingTextField.text != "" {
			toNextView.backgroundColor = .primaryBlack
			toNextView.layer.cornerRadius = 0.5 * toNextView.bounds.size.height
			toNextView.isEnabled = true
		}
		else if addressTextField.text == "" || buildingTextField.text == "" {
			toNextView.backgroundColor = UIColor(red: 219 / 255, green: 219 / 255, blue: 219 / 255, alpha: 1)
			toNextView.layer.cornerRadius = 0.5 * toNextView.bounds.size.height
			toNextView.isEnabled = false
		}
	}
}
