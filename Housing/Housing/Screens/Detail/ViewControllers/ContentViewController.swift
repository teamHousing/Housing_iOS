//
//  ContentViewController.swift
//  Housing
//
//  Created by 노한솔 on 2021/01/04.
//

import UIKit

import SegementSlide
import Then
import SnapKit



class ContentViewController: UITableViewController, SegementSlideContentScrollViewDelegate {
	@objc var scrollView: UIScrollView {
		return tableView
		
	}

	func registerCell() {
		tableView.register(RequestTableViewCell.self, forCellReuseIdentifier: RequestTableViewCell.reuseIdentifier)
		tableView.register(CommunicateMethodTableViewCell.self, forCellReuseIdentifier: CommunicateMethodTableViewCell.reuseIdentifier)
		tableView.register(AddedImageTableViewCell.self, forCellReuseIdentifier: AddedImageTableViewCell.reuseIdentifier)
	}
	
	func layout() {
		tableView.snp.makeConstraints{
			$0.top.equalTo(view.snp.top).offset(52)
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		layout()
		tableView.separatorStyle = .none
		tableView.estimatedRowHeight = RequestTableViewCell.estimatedRowHeight() + CommunicateMethodTableViewCell.estimatedRowHeight() + AddedImageTableViewCell.estimatedRowHeight()
		registerCell()
		self.reloadInputViews()
	}

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.row == 0 {
			return RequestTableViewCell.estimatedRowHeight()
		}
		else if indexPath.row == 1 {
			return CommunicateMethodTableViewCell.estimatedRowHeight()
		}
		else {
			return AddedImageTableViewCell.estimatedRowHeight()
		}
	}
	
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.row == 0 {
			let cell: RequestTableViewCell = tableView.dequeueCell(forIndexPath: indexPath)
			cell.awakeFromNib()
			return cell
		}
		else if indexPath.row == 1{
			let cell: CommunicateMethodTableViewCell = tableView.dequeueCell(forIndexPath: indexPath)
			cell.awakeFromNib()
			return cell
		}
		else {
			let cell: AddedImageTableViewCell = tableView.dequeueCell(forIndexPath: indexPath)
			cell.awakeFromNib()
			return cell
		}
		
	}
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 3
	}
	
}


