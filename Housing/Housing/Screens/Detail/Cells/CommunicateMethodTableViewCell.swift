//
//  CommunicateMethodTableViewCell.swift
//  Housing
//
//  Created by 노한솔 on 2021/01/05.
//

import UIKit

import Then
import SnapKit

class CommunicateMethodTableViewCell: UITableViewCell {
	
	// MARK: - Property
	var method : [CommunicationMethod] = []
	
	let titleLabel = UILabel().then {
		$0.text = "🗣 소통 방식"
		$0.textColor = .primaryBlack
		$0.font = UIFont.systemFont(ofSize: 15, weight: .bold)
		$0.textAlignment = .left
	}
	let methodTableView = UITableView().then {
		$0.backgroundColor = .primaryWhite
	}
	
	// MARK: - helper
	static func estimatedRowHeight() -> CGFloat {
		return 300
	}
	
	private func layout() {
		self.contentView.add(titleLabel) {
			$0.snp.makeConstraints{
				$0.top.equalTo(self.contentView.snp.top).offset(5)
				$0.leading.equalTo(self.contentView.snp.leading).offset(20)
			}
		}
		self.contentView.add(self.methodTableView) {
			$0.isScrollEnabled = false
			$0.isPagingEnabled = false
			$0.isUserInteractionEnabled = false
			$0.snp.makeConstraints{
				$0.top.equalTo(self.titleLabel.snp.bottom).offset(20)
				$0.leading.equalTo(self.contentView.snp.leading)
				$0.trailing.equalTo(self.contentView.snp.trailing)
				$0.bottom.equalTo(self.contentView.snp.bottom)
				$0.height.equalTo(self.method.count*70)
			}
		}
	}
	
	private func registerCell() {
		methodTableView.register(MethodDetailTableViewCell.self, forCellReuseIdentifier: MethodDetailTableViewCell.reuseIdentifier)
	}
	
	// MARK: - Lifecycle
	override func awakeFromNib() {
		super.awakeFromNib()
		registerCell()
		layout()
		self.methodTableView.isScrollEnabled = false
		self.methodTableView.separatorStyle = .none
		self.methodTableView.delegate = self
		self.methodTableView.dataSource = self
		self.methodTableView.estimatedRowHeight = CGFloat(self.method.count * 70)
		self.methodTableView.rowHeight = UITableView.automaticDimension
		self.methodTableView.reloadData()
	}
}

// MARK: - UITableView Delegate
extension CommunicateMethodTableViewCell: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 70
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "MethodDetailTableViewCell") as?
						MethodDetailTableViewCell else {
			return UITableViewCell()
		}
		cell.awakeFromNib()
		cell.dateLabel.text = self.method[indexPath.row].date
		cell.timeLabel.text = self.method[indexPath.row].time
		cell.methodLabel.text = self.method[indexPath.row].method
		cell.selectionStyle = .none
		return cell
	}
}

// MARK: - UITableView DataSource
extension CommunicateMethodTableViewCell: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.method.count
	}
}
