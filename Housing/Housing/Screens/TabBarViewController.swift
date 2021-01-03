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
	}

	private func tabbar() {
		var navigationController: UINavigationController
		
		let storyboard = UIStoryboard(name: StoryboardStorage.communication,
																	bundle: nil)
		let communicationVC = storyboard.instantiateViewController(withIdentifier: "CommunicationViewController")
		let communicationTabItem = UITabBarItem(title: "홈",
																	 image: UIImage(systemName: "house"),
																	 tag: 0)
		communicationVC.tabBarItem = communicationTabItem
		navigationController = UINavigationController(rootViewController: communicationVC)

		let communicationTab = navigationController
		
		let calendarViewController = CalendarViewController()
		let calendarTabItem = UITabBarItem(title: "캘린더",
																	 image: UIImage(systemName: "eyes"),
																	 tag: 1)
		calendarViewController.tabBarItem = calendarTabItem
		
		navigationController = UINavigationController(rootViewController: calendarViewController)

		let calendarTab = navigationController
		
		let homestoryboard = UIStoryboard(name: StoryboardStorage.home,
																	bundle: nil)
		let homeVC = homestoryboard.instantiateViewController(withIdentifier: "HomeViewController")
		let homeTabItem = UITabBarItem(title: "우리집 소식",
																	 image: UIImage(systemName: "house.fill"),
																	 tag: 1)
		homeVC.tabBarItem = homeTabItem
		navigationController = UINavigationController(rootViewController: homeVC)

		let homeTab = navigationController

		self.viewControllers = [communicationTab, calendarTab, homeTab]
	}
}
