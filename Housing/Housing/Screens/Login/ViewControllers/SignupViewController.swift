//
//  SigninViewController.swift
//  Housing
//
//  Created by 곽기곤's Mac on 2021/01/06.
//

import UIKit

class SignupViewController: UIViewController {
	//MARK:- Property
	
	//MARK:- Component(Outlet)
	@IBOutlet weak var lessorView: UIButton!
	@IBOutlet weak var tenantView: UIButton!
	@IBOutlet weak var navigationBackButtonView: UIBarButtonItem!
	@IBOutlet weak var nextButtonView: UIButton!
	
	//MARK:- Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		initLayout()
		
		navigationController?.interactivePopGestureRecognizer?.delegate = nil
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		navigationController?.navigationBar.isHidden = false
	}
	
	//MARK:- Helper
	func initLayout() {
		navigationController?.navigationBar.isHidden = false
		navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
		navigationController?.navigationBar.shadowImage = UIImage()
		
		navigationBackButtonView.tintColor = .primaryBlack
		
		nextButtonView.backgroundColor = UIColor(red: 219 / 255, green: 219 / 255, blue: 219 / 255, alpha: 1)
		nextButtonView.layer.cornerRadius = 0.5 * nextButtonView.bounds.size.height
		
		lessorView.layer.cornerRadius = 10
		lessorView.layer.shadowColor = CGColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.10000000149011612)
		lessorView.layer.shadowOpacity = 1
		lessorView.layer.shadowOffset = .zero
		lessorView.layer.shadowRadius = 16 / 2
		lessorView.layer.shadowPath = nil
		
		tenantView.layer.cornerRadius = 10
		tenantView.layer.shadowColor = CGColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.10000000149011612)
		tenantView.layer.shadowOpacity = 1
		tenantView.layer.shadowOffset = .zero
		tenantView.layer.shadowRadius = 16 / 2
		tenantView.layer.shadowPath = nil
		
		nextButtonView.isEnabled = false
	}
	
	//MARK:- Component(Action)
	@IBAction func navigationBackButton(_ sender: Any) {
		navigationController?.popViewController(animated: true)
	}
	
	@IBAction func nextButton(_ sender: Any) {
		let viewController = InfoViewController()
		navigationController?.pushViewController(viewController, animated: true)
	}
	
	@IBAction func lessorButton(_ sender: Any) {
		if !lessorView.isSelected {
			lessorView.layer.borderWidth = 2
			lessorView.layer.borderColor = CGColor(red: 255 / 255, green: 133 / 255, blue: 119 / 255, alpha: 1)
			lessorView.layer.cornerRadius = 10
			lessorView.layer.shadowColor = CGColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.10000000149011612)
			lessorView.layer.shadowOpacity = 1
			lessorView.layer.shadowOffset = .zero
			lessorView.layer.shadowRadius = 16 / 2
			lessorView.layer.shadowPath = nil
			lessorView.isSelected = true
			
			tenantView.isEnabled = false
			
			nextButtonView.layer.backgroundColor = UIColor.primaryBlack.cgColor
			nextButtonView.isEnabled = true
		}
		else {
			lessorView.isSelected = false
			lessorView.layer.borderColor = UIColor.clear.cgColor
			
			tenantView.isEnabled = true
			
			nextButtonView.layer.backgroundColor = CGColor(red: 219 / 255, green: 219 / 255, blue: 219 / 255, alpha: 1)
			nextButtonView.isEnabled = false
		}
	}
	@IBAction func tenantButton(_ sender: Any) {
		if !tenantView.isSelected {
			tenantView.layer.borderWidth = 2
			tenantView.layer.borderColor = CGColor(red: 255 / 255, green: 133 / 255, blue: 119 / 255, alpha: 1)
			tenantView.layer.cornerRadius = 10
			tenantView.layer.shadowColor = CGColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.10000000149011612)
			tenantView.layer.shadowOpacity = 1
			tenantView.layer.shadowOffset = .zero
			tenantView.layer.shadowRadius = 16 / 2
			tenantView.layer.shadowPath = nil
			tenantView.isSelected = true
			
			lessorView.isEnabled = false
			
			nextButtonView.layer.backgroundColor = UIColor.primaryBlack.cgColor
			nextButtonView.isEnabled = false
		}
		else {
			tenantView.isSelected = false
			tenantView.layer.borderColor = UIColor.clear.cgColor
			
			lessorView.isEnabled = true
			
			nextButtonView.layer.backgroundColor = CGColor(red: 219 / 255, green: 219 / 255, blue: 219 / 255, alpha: 1)
			nextButtonView.isEnabled = false
		}
	}
}

//MARK:- Extension Object
