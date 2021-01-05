//
//  ViewController.swift
//  Housing
//
//  Created by 오준현 on 2020/12/27.
//

import UIKit

import Then
import SnapKit

class SplashViewController: BaseViewController {

	private let loginButton = UIButton().then {
		$0.setTitle("로그인", for: .normal)
		$0.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
		$0.backgroundColor = .black
		$0.setRounded(radius: 10)
		$0.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
	}
	
	private let communicationButton = UIButton().then {
		$0.setTitle("주은", for: .normal)
		$0.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
		$0.backgroundColor = .black
		$0.setRounded(radius: 10)
		$0.addTarget(self, action: #selector(communicationButtonDidTap), for: .touchUpInside)
	}
	
	private let promiseButton = UIButton().then {
		$0.setTitle("태훈", for: .normal)
		$0.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
		$0.setRounded(radius: 10)
		$0.backgroundColor = .black
		$0.addTarget(self, action: #selector(promiseButtonDidTap), for: .touchUpInside)
	}
	
	private let detailButton = UIButton().then {
		$0.setTitle("한솔", for: .normal)
		$0.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
		$0.backgroundColor = .black
		$0.addTarget(self, action: #selector(detailButtonDidTap), for: .touchUpInside)
		$0.setRounded(radius: 10)
	}
	
	private let calendarButton = UIButton().then {
		$0.setTitle("준현", for: .normal)
		$0.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
		$0.backgroundColor = .black
		$0.addTarget(self, action: #selector(calendarButtonDidTap), for: .touchUpInside)
		$0.setRounded(radius: 10)
	}
	
	private let homeButton = UIButton().then {
		$0.setTitle("민제", for: .normal)
		$0.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
		$0.backgroundColor = .black
		$0.addTarget(self, action: #selector(homeButtonDidTap), for: .touchUpInside)
		$0.setRounded(radius: 10)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		layout()
	}
	
	private func layout() {
		view.adds([
			loginButton,
			communicationButton,
			promiseButton,
			detailButton,
			calendarButton,
			homeButton
		])
		loginButton.snp.makeConstraints {
			$0.centerX.centerY.equalTo(view)
			$0.width.height.equalTo(60)
		}
		homeButton.snp.makeConstraints {
			$0.bottom.equalTo(view).offset(-50)
			$0.leading.equalTo(view).offset(10)
			$0.width.equalTo((view.frame.width/5)-10)
			$0.height.equalTo(60)
		}
		detailButton.snp.makeConstraints {
			$0.bottom.equalTo(view).offset(-50)
			$0.leading.equalTo(homeButton.snp.trailing).offset(10)
			$0.width.equalTo((view.frame.width/5)-10)
			$0.height.equalTo(60)
		}
		promiseButton.snp.makeConstraints {
			$0.bottom.equalTo(view).offset(-50)
			$0.leading.equalTo(detailButton.snp.trailing).offset(10)
			$0.width.equalTo((view.frame.width/5)-10)
			$0.height.equalTo(60)
		}
		calendarButton.snp.makeConstraints {
			$0.bottom.equalTo(view).offset(-50)
			$0.leading.equalTo(promiseButton.snp.trailing).offset(10)
			$0.width.equalTo((view.frame.width/5)-10)
			$0.height.equalTo(60)
		}
		communicationButton.snp.makeConstraints {
			$0.bottom.equalTo(view).offset(-50)
			$0.leading.equalTo(calendarButton.snp.trailing).offset(10)
			$0.width.equalTo((view.frame.width/5)-10)
			$0.height.equalTo(60)
		}
	}
	
	// 민제
	@objc
	func loginButtonDidTap() {
		let storyboard = UIStoryboard(name: StoryboardStorage.login,
																	bundle: nil)
		let viewcontroller = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
		viewcontroller.modalPresentationStyle = .fullScreen
		present(viewcontroller, animated: true)
	}

	// 주은
	@objc
	func communicationButtonDidTap() {
		let storyboard = UIStoryboard(name: StoryboardStorage.communication,
																	bundle: nil)
		let viewcontroller = storyboard.instantiateViewController(withIdentifier: "CommunicationViewController")
		viewcontroller.modalPresentationStyle = .fullScreen
		present(viewcontroller, animated: true)
	}
	
	// 태훈
	@objc
	func promiseButtonDidTap() {
		let storyboard = UIStoryboard(name: StoryboardStorage.promise,
																	bundle: nil)
		let viewcontroller = storyboard.instantiateViewController(withIdentifier: "PromiseViewController")
		viewcontroller.modalPresentationStyle = .fullScreen
		present(viewcontroller, animated: true)
		//self.navigationController?.pushViewController(viewcontroller, animated: true)
	}
	
	// 한솔
	@objc
	func detailButtonDidTap() {
		let storyboard = UIStoryboard(name: StoryboardStorage.detail,
																	bundle: nil)
		let viewcontroller = storyboard.instantiateViewController(withIdentifier: "DetailViewController")
		let navigationViewController = UINavigationController(rootViewController: viewcontroller)
		navigationViewController.modalPresentationStyle = .fullScreen
		present(navigationViewController, animated: true)
	}
	
	// 준현
	@objc
	func calendarButtonDidTap() {
		let viewcontroller = CalendarViewController()
		viewcontroller.modalPresentationStyle = .fullScreen
		present(viewcontroller, animated: true)
	}
	
	// 민제
	@objc
	func homeButtonDidTap() {
		let storyboard = UIStoryboard(name: StoryboardStorage.home,
																	bundle: nil)
		let viewcontroller = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
		viewcontroller.modalPresentationStyle = .fullScreen
		present(viewcontroller, animated: true)
	}
}
