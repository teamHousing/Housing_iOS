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
import SwiftKeychainWrapper

class ContentViewController: UITableViewController, SegementSlideContentScrollViewDelegate {
	
	// MARK: - Property
	@objc var scrollView: UIScrollView {
		return tableView
	}
	
	var model = DetailModel(id: 0,
													issueImages: [],
													promiseOption: [["1","1","1"]],
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
	var statusModel = [DetailStatus.init(ownerStatus: [], userStatus: [], id: 1)]
	
	// MARK: - Helper
	private func registerCell() {
		tableView.register(RequestTableViewCell.self, forCellReuseIdentifier: RequestTableViewCell.reuseIdentifier)
		tableView.register(CommunicateMethodTableViewCell.self, forCellReuseIdentifier: CommunicateMethodTableViewCell.reuseIdentifier)
		tableView.register(AddedImageTableViewCell.self, forCellReuseIdentifier: AddedImageTableViewCell.reuseIdentifier)
	}
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		tableView.isUserInteractionEnabled = true
		tableView.separatorStyle = .none
		tableView.showsVerticalScrollIndicator = false
		tableView.estimatedRowHeight = RequestTableViewCell.estimatedRowHeight() +
			CommunicateMethodTableViewCell.estimatedRowHeight() +
			AddedImageTableViewCell.estimatedRowHeight()
		tableView.rowHeight = UITableView.automaticDimension
		registerCell()
		tableView.reloadData()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		tableView.reloadData()
		navigationController?.setNavigationBarHidden(false, animated: true)
	}
	
	// MARK: - UITableView DataSources
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 3
	}
	
	// MARK: - UITableView Delegate
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
	-> UITableViewCell {
		if indexPath.row == 0 {
			let cell: RequestTableViewCell = tableView.dequeueCell(forIndexPath: indexPath)
			cell.awakeFromNib()
			cell.selectionStyle = .none
			print(model.requestedTerm)
			cell.contextLabel.text = self.model.requestedTerm
			cell.contextLabel.sizeToFit()
			return cell
		}
		else if indexPath.row == 1 {
			let cell: CommunicateMethodTableViewCell = tableView.dequeueCell(forIndexPath: indexPath)
			cell.selectionStyle = .none
			for i in 0 ..< self.model.promiseOption!.count {
				cell.method.append(CommunicationMethod(date: self.model.promiseOption![i][0], time: self.model.promiseOption![i][1], method: self.model.promiseOption![i][2]))
			}
			cell.awakeFromNib()
			return cell
		}
		else if indexPath.row == 2 {
			let cell: AddedImageTableViewCell = tableView.dequeueCell(forIndexPath: indexPath)
			cell.imageURL = self.model.issueImages!
			
			let isHost = KeychainWrapper.standard.integer(forKey: KeychainStorage.isHost)
			if isHost == 0 {
				cell.cancelButton.isHidden = true
				cell.cancelButton.isUserInteractionEnabled = false
			}
			if self.model.progress == 2 {
				cell.cancelButton.isHidden = true
				cell.cancelButton.isUserInteractionEnabled = false
			}
			
			cell.selectionStyle = .none
			cell.awakeFromNib()
			return cell
		}
		
		return UITableViewCell()
		
	}
	
}


