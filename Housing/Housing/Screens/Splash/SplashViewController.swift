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
	
	private let logoLabel = UILabel().then {
		$0.text = "Housing"
		$0.font = BaskervilleFont.bold.of(size: 30)
	}
	
	private let tabButton = UIButton().then {
		$0.setTitle("탭바", for: .normal)
		$0.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
		$0.backgroundColor = .black
		$0.setRounded(radius: 10)
		$0.addTarget(self, action: #selector(tabButtonDidTap), for: .touchUpInside)
	}
	
	
	private let promiseButton = UIButton().then {
		$0.setTitle("문의/태훈", for: .normal)
		$0.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
		$0.setRounded(radius: 10)
		$0.backgroundColor = .black
		$0.addTarget(self, action: #selector(promiseButtonDidTap), for: .touchUpInside)
	}
	
	private let detailButton = UIButton().then {
		$0.setTitle("상세/한솔", for: .normal)
		$0.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
		$0.backgroundColor = .black
		$0.addTarget(self, action: #selector(detailButtonDidTap), for: .touchUpInside)
		$0.setRounded(radius: 10)
	}
	
	private let homeButton = UIButton().then {
		$0.setTitle("로그인/민제", for: .normal)
		$0.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
		$0.backgroundColor = .black
		$0.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
		$0.setRounded(radius: 10)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		layout()
	}
	
	private func layout() {
		view.adds([
			logoLabel,
			tabButton,
			promiseButton,
			detailButton,
			homeButton
		])
		
		logoLabel.snp.makeConstraints {
			$0.centerX.equalToSuperview()
			$0.top.equalToSuperview().offset(60)
		}
		tabButton.snp.makeConstraints {
			$0.centerX.centerY.equalTo(view)
			$0.width.height.equalTo(60)
		}
		homeButton.snp.makeConstraints {
			$0.bottom.equalTo(view).offset(-50)
			$0.leading.equalTo(view).offset(10)
			$0.width.equalTo((view.frame.width/3)-10)
			$0.height.equalTo(60)
		}
		detailButton.snp.makeConstraints {
			$0.bottom.equalTo(view).offset(-50)
			$0.leading.equalTo(homeButton.snp.trailing).offset(10)
			$0.width.equalTo((view.frame.width/3)-10)
			$0.height.equalTo(60)
		}
		promiseButton.snp.makeConstraints {
			$0.bottom.equalTo(view).offset(-50)
			$0.leading.equalTo(detailButton.snp.trailing).offset(10)
			$0.width.equalTo((view.frame.width/3)-20)
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
	
	// 태훈
	@objc
	func promiseButtonDidTap() {
		let storyboard = UIStoryboard(name: StoryboardStorage.promise,
																	bundle: nil)
		let viewcontroller = PromiseViewController()
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
		viewcontroller.modalPresentationStyle = .fullScreen
		present(viewcontroller, animated: true)
	}
	
	// 준현
	@objc
	func tabButtonDidTap() {
		let viewcontroller = TabBarViewController()
		viewcontroller.modalPresentationStyle = .fullScreen
		present(viewcontroller, animated: true)
	}
}
