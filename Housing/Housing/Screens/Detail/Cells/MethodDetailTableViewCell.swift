//
//  MethodDetailTableViewCell.swift
//  Housing
//
//  Created by 노한솔 on 2021/01/05.
//

import UIKit

class MethodDetailTableViewCell: UITableViewCell {
	
	let containerView = UIView().then {
		$0.backgroundColor = .primaryGray
	}
	let dateLabel = UILabel().then{
		$0.textColor = .primaryBlack
		$0.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
		$0.textAlignment = .left
	}
	let timeLabel = UILabel().then {
		$0.textColor = .primaryBlack
		$0.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
		$0.textAlignment = .left
	}
	let methodLabel = UILabel().then {
		$0.textColor = .primaryBlack
		$0.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
		$0.textAlignment = .left
	}
	
	func layout() {
		self.contentView.add(containerView) {
			$0.snp.makeConstraints{
				$0.top.equalTo(self.contentView.snp.top).offset(6)
				$0.bottom.equalTo(self.contentView.snp.bottom).offset(-6)
				$0.leading.equalTo(self.contentView.snp.leading).offset(48)
				$0.trailing.equalTo(self.contentView.snp.trailing).offset(-20)
			}
		}
		containerView.add(dateLabel) {
			$0.snp.makeConstraints {
				$0.centerY.equalTo(self.containerView.snp.centerY)
				$0.leading.equalTo(self.containerView.snp.leading).offset(20)
			}
		}
		containerView.add(timeLabel) {
			$0.snp.makeConstraints {
				$0.centerY.equalTo(self.containerView.snp.centerY)
				$0.leading.equalTo(self.dateLabel.snp.trailing).offset(48)
			}
		}
		containerView.add(methodLabel) {
			$0.snp.makeConstraints {
				$0.centerY.equalTo(self.containerView.snp.centerY)
				$0.leading.equalTo(self.timeLabel.snp.trailing).offset(48)
			}
		}
	}
	override func awakeFromNib() {
		super.awakeFromNib()
		layout()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
}
