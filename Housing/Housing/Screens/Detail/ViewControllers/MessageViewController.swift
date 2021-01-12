//
//  MessageViewController.swift
//  Housing
//
//  Created by 노한솔 on 2021/01/06.
//

import UIKit

import SegementSlide
import SnapKit
import Then

class MessageViewController: UITableViewController, SegementSlideContentScrollViewDelegate {
	
	@objc var scrollView: UIScrollView {
		return tableView
	}
	
	func registerCell() {
		tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: MessageTableViewCell.reuseIdentifier)
		
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		registerCell()
		tableView.estimatedRowHeight = MessageTableViewCell.estimatedRowHeight()
		tableView.rowHeight = UITableView.automaticDimension
		tableView.contentInset.top = 30
		tableView.contentInset.bottom = 30
		tableView.isUserInteractionEnabled = true
		tableView.separatorStyle = .none
		tableView.showsVerticalScrollIndicator = false
		tableView.backgroundColor = .primaryGray
	}
	
	// MARK: - Table view data source
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return 1
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: MessageTableViewCell = tableView.dequeueCell(forIndexPath: indexPath)
		cell.awakeFromNib()
		cell.rootViewController = self
//		let cell2: MessageDetailTableViewCell = cell.messageTableView.dequeueCell(forIndexPath: indexPath)
//		cell2.awakeFromNib()
//		cell2.rootViewController = self
//		cell2.transitionButton.addTarget(self, action: #selector(self.touchUpConfirm), for: .touchUpInside)
//		cell.selectionStyle = .none
//		print(#function)
		return cell
	}
	
	@objc func touchUpConfirm(_ sender: UIButton) {
		let storyboard = UIStoryboard(name: StoryboardStorage.detail,bundle: nil)
		let viewcontroller = storyboard.instantiateViewController(withIdentifier: "ConfirmViewController")
		self.navigationController?.pushViewController(viewcontroller, animated: true)
	}
	
}
