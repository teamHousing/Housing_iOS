//
//  EmptyTableViewCell.swift
//  Housing
//
//  Created by 노한솔 on 2021/01/14.
//

import UIKit

import SnapKit
import Then

class EmptyTableViewCell: UITableViewCell {
	
	// MARK: - Property
	let emptyTableView = UITableView()
	
	// MARK: - Helper
	static func estimatedRowHeight() -> CGFloat {
		return 350
	}
	
	private func layout() {
		self.contentView.add(self.emptyTableView) {
			$0.isScrollEnabled = false
			$0.isPagingEnabled = false
			$0.isUserInteractionEnabled = true
			$0.backgroundColor = .primaryGray
			$0.snp.makeConstraints {
				$0.edges.equalTo(self.contentView)
				$0.height.equalTo(400)
			}
		}
	}
	
	private func registerCell() {
		emptyTableView.register(EmptyDetailTableViewCell.self,
														forCellReuseIdentifier: EmptyDetailTableViewCell.reuseIdentifier)
	}
	
	// MARK: - Lifecycle
	override func awakeFromNib() {
		super.awakeFromNib()
		layout()
		registerCell()
		self.emptyTableView.delegate = self
		self.emptyTableView.dataSource = self
		self.emptyTableView.estimatedRowHeight = EmptyDetailTableViewCell.estimatedRowHeight()
		self.emptyTableView.rowHeight = UITableView.automaticDimension
		self.emptyTableView.separatorStyle = .none
		self.emptyTableView.reloadData()
		self.backgroundColor = .primaryGray
	}
}

// MARK: - UITableView Delegate
extension EmptyTableViewCell: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 400
	}
}
// MARK: - UITableView DataSource
extension EmptyTableViewCell: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: EmptyDetailTableViewCell = tableView.dequeueCell(forIndexPath: indexPath)
		cell.awakeFromNib()
		tableView.isScrollEnabled = false
		cell.selectionStyle = .none
		return cell
	}
}
