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
	
	var model = DetailModel(id: 0, issueImages: [], promiseOption: [[]], category: 0, issueTitle: "", issueContents: "", progress: 0, requestedTerm: "", promiseYear: 0, promiseMonth: 0, promiseDay: 0, promiseTime: "", solutionMethod: "", confirmedPromiseOption: [])
	var statusModel: [DetailStatus] = []
	@objc var scrollView: UIScrollView {
		return tableView
	}
	
	func registerCell() {
		tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: MessageTableViewCell.reuseIdentifier)
		
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		print("hi")
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
		cell.status = self.statusModel[0].ownerStatus!
		cell.confirmedPromiseOption = "\(self.model.confirmedPromiseOption![0]) / \(self.model.confirmedPromiseOption![1]) / \(self.model.confirmedPromiseOption![2]) "
		cell.rootViewController = self
		cell.awakeFromNib()
		return cell
	}
	
	@objc func touchUpConfirm(_ sender: UIButton) {
		let storyboard = UIStoryboard(name: StoryboardStorage.detail,bundle: nil)
		let viewcontroller = storyboard.instantiateViewController(withIdentifier: "ConfirmViewController")
		self.navigationController?.pushViewController(viewcontroller, animated: true)
	}
	
}
