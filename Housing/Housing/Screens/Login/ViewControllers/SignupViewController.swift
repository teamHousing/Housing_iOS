//
//  SigninViewController.swift
//  Housing
//
//  Created by 곽기곤's Mac on 2021/01/06.
//

import UIKit

final class SignupViewController: UIViewController {
	
	// MARK: - Component(Outlet)
	@IBOutlet weak var lessorButton: UIButton!
	@IBOutlet weak var tenantButton: UIButton!
	@IBOutlet weak var nextButton: UIButton!
	
	var isHost: Int?
	
	// MARK: - Property
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		layout()
		
		navigationController?.interactivePopGestureRecognizer?.delegate = nil
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		navigationController?.navigationBar.isHidden = false
	}
	
	// MARK: - Helper
	private func layout() {
		navigationController?.navigationBar.topItem?.title = ""
		navigationController?.navigationBar.isHidden = false
		navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
		navigationController?.navigationBar.shadowImage = UIImage()
		
		nextButton.backgroundColor = UIColor(red: 219 / 255,
																				 green: 219 / 255,
																				 blue: 219 / 255,
																				 alpha: 1)
		nextButton.layer.cornerRadius = 0.5 * nextButton.bounds.size.height
		
		lessorButton.layer.cornerRadius = 10
		lessorButton.layer.shadowColor = UIColor.primaryBlack.withAlphaComponent(0.1).cgColor
		lessorButton.layer.shadowOpacity = 1
		lessorButton.layer.shadowOffset = .zero
		lessorButton.layer.shadowRadius = 16 / 2
		lessorButton.layer.shadowPath = nil
		
		tenantButton.layer.cornerRadius = 10
		tenantButton.layer.shadowColor = UIColor.primaryBlack.withAlphaComponent(0.1).cgColor
		tenantButton.layer.shadowOpacity = 1
		tenantButton.layer.shadowOffset = .zero
		tenantButton.layer.shadowRadius = 16 / 2
		tenantButton.layer.shadowPath = nil
		
		nextButton.isEnabled = false
	}
	
	//MARK:- Component(Action)
	@IBAction func navigationBackButton(_ sender: Any) {
		navigationController?.popViewController(animated: true)
	}
	
	@IBAction func nextButton(_ sender: Any) {
		if lessorButton.isSelected {
			isHost = 0
			let viewController = InfoViewController()
			viewController.isHost = isHost
			navigationController?.pushViewController(viewController, animated: true)
		}
		else if tenantButton.isSelected {
			isHost = 1
			let viewcontroller = self.storyboard?.instantiateViewController(
				withIdentifier: "TenantSignupViewController") as! TenantSignupViewController
			viewcontroller.isHost = isHost
			self.navigationController?.pushViewController(viewcontroller, animated: true)
		}
	}
	
	@IBAction func lessorButton(_ sender: Any) {
		if !lessorButton.isSelected {
			lessorButton.layer.borderWidth = 2
			lessorButton.layer.borderColor = UIColor.primaryOrange.cgColor
			lessorButton.layer.cornerRadius = 10
			lessorButton.layer.shadowColor = UIColor.primaryBlack.withAlphaComponent(0.1).cgColor
			lessorButton.layer.shadowOpacity = 1
			lessorButton.layer.shadowOffset = .zero
			lessorButton.layer.shadowRadius = 16 / 2
			lessorButton.layer.shadowPath = nil
			lessorButton.isSelected = true
			isHost = 0
			tenantButton.isEnabled = false
			
			nextButton.layer.backgroundColor = UIColor.primaryOrange.cgColor
			nextButton.isEnabled = true
		}
		else {
			lessorButton.isSelected = false
			lessorButton.layer.borderColor = UIColor.clear.cgColor
			
			tenantButton.isEnabled = true
			
			nextButton.layer.backgroundColor = CGColor(red: 219 / 255,
																								 green: 219 / 255,
																								 blue: 219 / 255,
																								 alpha: 1)
			nextButton.isEnabled = false
		}
	}
	
	@IBAction func tenantButton(_ sender: Any) {
		if !tenantButton.isSelected {
			tenantButton.layer.borderWidth = 2
			tenantButton.layer.borderColor = UIColor.primaryOrange.cgColor
			tenantButton.layer.cornerRadius = 10
			tenantButton.layer.shadowColor = UIColor.primaryBlack.withAlphaComponent(0.1).cgColor
			tenantButton.layer.shadowOpacity = 1
			tenantButton.layer.shadowOffset = .zero
			tenantButton.layer.shadowRadius = 16 / 2
			tenantButton.layer.shadowPath = nil
			tenantButton.isSelected = true
			isHost = 1
			lessorButton.isEnabled = false
			
			nextButton.layer.backgroundColor = UIColor.primaryOrange.cgColor
			nextButton.isEnabled = true
			
		} else {
			tenantButton.isSelected = false
			tenantButton.layer.borderColor = UIColor.clear.cgColor
			
			lessorButton.isEnabled = true
			
			nextButton.layer.backgroundColor = CGColor(red: 219 / 255,
																								 green: 219 / 255,
																								 blue: 219 / 255,
																								 alpha: 1)
			nextButton.isEnabled = false
		}
	}
}
