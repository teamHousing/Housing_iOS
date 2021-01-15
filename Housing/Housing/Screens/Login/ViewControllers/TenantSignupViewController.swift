//
//  TenantSignupViewController.swift
//  Housing
//
//  Created by 곽기곤's Mac on 2021/01/15.
//

import UIKit

class TenantSignupViewController: UIViewController {
    
    //MARK:- Component(Outlet)
    @IBOutlet weak var verifyNumberTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    
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
        
        let viewController = InfoViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
