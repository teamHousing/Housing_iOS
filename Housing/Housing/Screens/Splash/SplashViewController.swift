//
//  ViewController.swift
//  Housing
//
//  Created by 오준현 on 2020/12/27.
//

import UIKit

import Then
import SnapKit
import SwiftKeychainWrapper
import Lottie

final class SplashViewController: BaseViewController {
	//private let lottieAnimationView = LOTAnimationView(named:"")
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			self.detectIsSignIn()
		}
	}
	
	private func toLogin() {
		let storyboard = UIStoryboard(name: StoryboardStorage.login,
																	bundle: nil)
		let viewcontroller = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
		let navigationViewController = UINavigationController(rootViewController: viewcontroller)
		navigationViewController.modalPresentationStyle = .fullScreen
		present(navigationViewController, animated: false)
	}
	
	private func toMain() {
		let viewcontroller = TabBarViewController()
		viewcontroller.modalPresentationStyle = .fullScreen
		present(viewcontroller, animated: false)
	}
	
	private func detectIsSignIn() {
		let token = KeychainWrapper.standard.string(forKey: KeychainStorage.accessToken)
		if token == "" || token == nil {
			toLogin()
		} else {
			toMain()
		}
	}
}
