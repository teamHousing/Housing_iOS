//
//  LoginViewController.swift
//  Housing
//
//  Created by 곽민제 on 2021/01/01.
//

import UIKit

class LoginViewController: UIViewController {
	
    //MARK:- Component
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var LoginButtonView: UIButton!
    
    //MARK:- Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        initLayout()
	}
    
    //MARK:- Helper
    func initLayout() {
        idTextField.borderWidth = 1
        idTextField.borderColor = .white
        idTextField.tintColor = UIColor(red: 255 / 255, green: 133 / 255, blue: 119 / 255, alpha: 1)
        
        passwordTextField.borderWidth = 1
        passwordTextField.borderColor = .white
        passwordTextField.tintColor = UIColor(red: 255 / 255, green: 133 / 255, blue: 119 / 255, alpha: 1)
        
        LoginButtonView.backgroundColor = UIColor(red: 219 / 255, green: 219 / 255, blue: 219 / 255, alpha: 1)
        LoginButtonView.layer.cornerRadius = 0.5 * LoginButtonView.bounds.size.height
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
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
}
