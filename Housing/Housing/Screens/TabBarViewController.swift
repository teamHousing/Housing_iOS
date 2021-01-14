//
//  TabBarViewController.swift
//  Housing
//
//  Created by 오준현 on 2021/01/03.
//

import UIKit

class TabBarViewController: UITabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tabbar()
		tabBarLayout()
	}

	private func tabBarLayout() {
		UITabBar.appearance().shadowImage = UIImage()
		UITabBar.appearance().backgroundImage = UIImage()
		UITabBar.appearance().backgroundColor = UIColor.white
		UITabBar.appearance().layer.borderWidth = 0.0
		tabBar.layer.applyShadow(color: .black, alpha: 0.2, x: 0, y: 5, blur: 5)
		tabBar.layer.applyShadow(color: .black, alpha: 0.12, x: 0, y: 3, blur: 14)
		tabBar.layer.applyShadow(color: .black, alpha: 0.14, x: 0, y: 8, blur: 10)
		UITabBar.appearance().tintColor = .primaryBlack
	}
	
	private func tabbar() {
		var navigationController: UINavigationController
		
		let storyboard = UIStoryboard(name: StoryboardStorage.communication,
																	bundle: nil)
		let communicationVC = storyboard.instantiateViewController(withIdentifier: "CommunicationViewController")
		let communicationTabItem = UITabBarItem(title: "홈",
																	 image: UIImage(named: "icHomeUnselected"),
																	 selectedImage: UIImage(named: "icHome"))
		communicationVC.tabBarItem = communicationTabItem
		navigationController = UINavigationController(rootViewController: communicationVC)

		let communicationTab = navigationController
		
		let calendarViewController = CalendarViewController()
		let calendarTabItem = UITabBarItem(title: "캘린더",
																	 image: UIImage(named: "icCalendarUnselected"),
																	 selectedImage: UIImage(named: "icCalencar"))
		calendarViewController.tabBarItem = calendarTabItem
		
		navigationController = UINavigationController(rootViewController: calendarViewController)

		let calendarTab = navigationController
		
		let homestoryboard = UIStoryboard(name: StoryboardStorage.notice,
																	bundle: nil)
		let homeVC = homestoryboard.instantiateViewController(withIdentifier: "NoticeViewController")
		let homeTabItem = UITabBarItem(title: "우리집 소식",
																	 image: UIImage(named: "icNotice"),
																	 selectedImage: UIImage(named: "icNoticeUnselected"))
		homeVC.tabBarItem = homeTabItem
		navigationController = UINavigationController(rootViewController: homeVC)

		let homeTab = navigationController

		self.viewControllers = [communicationTab, calendarTab, homeTab]
	}
}
