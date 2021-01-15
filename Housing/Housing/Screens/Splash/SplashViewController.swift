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
	
	private let lottieAnimationView = AnimationView(name:"splash")
	
	override func viewDidLoad() {
		super.viewDidLoad()
		lottieAnimationView.frame = CGRect(x: 0,
															y: 0,
															width: view.frame.width,
															height: view.frame.height)
		lottieAnimationView.contentMode = .scaleAspectFit
		lottieAnimationView.backgroundColor = .primaryBlack
		self.view.addSubview(lottieAnimationView)
		lottieAnimationView.play()

		DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
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
//		if token == "" || token == nil {
			toLogin()
//		} else {
//			toMain()
//		}
	}
}
