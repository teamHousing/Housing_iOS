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
	
	// MARK: - Property
	var model = DetailModel(id: 0,
													issueImages: [],
													promiseOption: [[]],
													category: 0,
													issueTitle: "",
													issueContents: "",
													progress: 0,
													requestedTerm: "",
													promiseYear: 0,
													promiseMonth: 0,
													promiseDay: 0,
													promiseTime: "",
													solutionMethod: "",
													confirmedPromiseOption: []
	)
	var statusModel: [DetailStatus] = []
	
	@objc var scrollView: UIScrollView {
		return tableView
	}
	
	// MARK: - Helper
	private func registerCell() {
		tableView.register(MessageTableViewCell.self,
											 forCellReuseIdentifier: MessageTableViewCell.reuseIdentifier)
		tableView.register(EmptyTableViewCell.self,
											 forCellReuseIdentifier: EmptyTableViewCell.reuseIdentifier)
	}
	
	// MARK: - Lifecycle
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
		pullToRefresh(scrollview: scrollView)
	}
	
	// MARK: - UITableView data source
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView,
													cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if self.statusModel[0].userStatus == [0] {
			let cell: EmptyTableViewCell = tableView.dequeueCell(forIndexPath: indexPath)
			cell.awakeFromNib()
			return cell
		}
		else {
			let cell: MessageTableViewCell = tableView.dequeueCell(forIndexPath: indexPath)
			if self.statusModel[0].userStatus?.isEmpty == true {
				cell.status = self.statusModel[0].ownerStatus!
				cell.userOrOwner = 0
			}
			else if self.statusModel[0].ownerStatus?.isEmpty == true {
				cell.status = self.statusModel[0].userStatus!
				cell.userOrOwner = 1
			}
			if let promiseArray = model.confirmedPromiseOption {
				cell.confirmedPromiseOption = "\(promiseArray[0]) / \(promiseArray[1]) / \(promiseArray[2])"
			}
			cell.rootViewController = self
			cell.awakeFromNib()
			return cell
		}
	}	
}
