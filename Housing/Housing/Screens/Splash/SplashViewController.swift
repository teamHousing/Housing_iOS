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

	private let communicationButton = UIButton().then {
		$0.setTitle("민제", for: .normal)
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
		$0.setTitle("주은", for: .normal)
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
			communicationButton,
			promiseButton,
			detailButton,
			calendarButton,
			homeButton
		])
		
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
	
	@objc
	func communicationButtonDidTap() {
		let storyboard = UIStoryboard(name: StoryboardStorage.communication,
																	bundle: nil)
		let viewcontroller = storyboard.instantiateViewController(withIdentifier: "CommunicationViewController")
		viewcontroller.modalPresentationStyle = .fullScreen
		present(viewcontroller, animated: true)
	}
	@objc
	func promiseButtonDidTap() {
		let storyboard = UIStoryboard(name: StoryboardStorage.promise,
																	bundle: nil)
		let viewcontroller = storyboard.instantiateViewController(withIdentifier: "PromiseViewController")
		viewcontroller.modalPresentationStyle = .fullScreen
		present(viewcontroller, animated: true)
	}
	@objc
	func detailButtonDidTap() {
		let storyboard = UIStoryboard(name: StoryboardStorage.detail,
																	bundle: nil)
		let viewcontroller = storyboard.instantiateViewController(withIdentifier: "DetailViewController")
		viewcontroller.modalPresentationStyle = .fullScreen
		present(viewcontroller, animated: true)
	}
	@objc
	func calendarButtonDidTap() {
		let viewcontroller = CalendarViewController()
		viewcontroller.modalPresentationStyle = .fullScreen
		present(viewcontroller, animated: true)
	}
	@objc
	func homeButtonDidTap() {
		let storyboard = UIStoryboard(name: StoryboardStorage.home,
																	bundle: nil)
		let viewcontroller = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
		viewcontroller.modalPresentationStyle = .fullScreen
		present(viewcontroller, animated: true)
	}
}
