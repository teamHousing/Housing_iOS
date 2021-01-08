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
		$0.textAlignment = .center
	}
	let timeLabel = UILabel().then {
		$0.textColor = .primaryBlack
		$0.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
		$0.textAlignment = .center
	}
	let methodLabel = UILabel().then {
		$0.textColor = .primaryBlack
		$0.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
		$0.textAlignment = .center
	}
	
	let circleView = UIView().then() {
		$0.backgroundColor = .primaryBlack
		$0.layer.cornerRadius = 6
	}
	let firstSeperatorView = UIView().then {
		$0.backgroundColor = .gray01
	}
	let secondSeperatorView = UIView().then {
		$0.backgroundColor = .gray01
	}
	
	static func estimatedRowHeight() -> CGFloat {
		return 57
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
		self.contentView.add(circleView) {
			$0.snp.makeConstraints{
				$0.width.height.equalTo(12)
				$0.leading.equalTo(self.contentView.snp.leading).offset(20)
				$0.centerY.equalTo(self.containerView.snp.centerY)
			}
		}
		containerView.add(timeLabel) {
			$0.snp.makeConstraints {
				$0.centerX.equalTo(self.containerView.snp.centerX).offset(15)
				$0.centerY.equalTo(self.containerView.snp.centerY)
			}
		}
		containerView.add(dateLabel) {
			$0.snp.makeConstraints {
				$0.centerY.equalTo(self.containerView.snp.centerY)
				$0.centerX.equalTo(self.timeLabel.snp.centerX).offset(-109)
			}
		}
		containerView.add(methodLabel) {
			$0.snp.makeConstraints {
				$0.centerY.equalTo(self.containerView.snp.centerY)
				$0.centerX.equalTo(self.timeLabel.snp.centerX).offset(93)
			}
		}
		containerView.add(firstSeperatorView) {
			$0.snp.makeConstraints {
				$0.height.equalTo(self.methodLabel)
				$0.width.equalTo(2)
				$0.centerX.equalTo(self.timeLabel.snp.centerX).offset(-49)
				$0.centerY.equalTo(self.containerView.snp.centerY)
			}
		}
		containerView.add(secondSeperatorView) {
			$0.snp.makeConstraints {
				$0.height.equalTo(self.methodLabel)
				$0.width.equalTo(2)
				$0.centerX.equalTo(self.timeLabel.snp.centerX).offset(52)
				$0.centerY.equalTo(self.containerView.snp.centerY)
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
