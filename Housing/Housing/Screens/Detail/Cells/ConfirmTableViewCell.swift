//
//  ConfirmTableViewCell.swift
//  Housing
//
//  Created by 노한솔 on 2021/01/08.
//

import UIKit

class ConfirmTableViewCell: UITableViewCell {
	
	// MARK: - Property
	let containerView = UIView().then {
		$0.backgroundColor = .primaryGray
		$0.layer.cornerRadius = 12
	}
	let dateLabel = UILabel().then {
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
	let circleView = UIButton().then() {
		$0.isUserInteractionEnabled = true
	}
	let firstSeperatorView = UIView().then {
		$0.backgroundColor = .gray01
	}
	let secondSeperatorView = UIView().then {
		$0.backgroundColor = .gray01
	}
	
	var buttonState = false
	
	// MARK: - Helper
	static func estimatedRowHeight() -> CGFloat {
		return 57
	}
	
	private func layout() {
		self.contentView.add(containerView) {
			$0.snp.makeConstraints {
				$0.top.equalTo(self.contentView.snp.top).offset(6)
				$0.bottom.equalTo(self.contentView.snp.bottom).offset(-6)
				$0.leading.equalTo(self.contentView.snp.leading).offset(53)
				$0.trailing.equalTo(self.contentView.snp.trailing).offset(-40)
			}
		}
		self.contentView.add(circleView) {
			if self.buttonState == false {
				$0.setBackgroundImage(UIImage(named: "group580"), for: .normal)
			}
			else {
				$0.setBackgroundImage(UIImage(named: "group579"), for: .normal)
				
			}
			$0.snp.makeConstraints {
				$0.width.height.equalTo(13)
				$0.leading.equalTo(self.contentView.snp.leading).offset(20)
				$0.centerY.equalTo(self.containerView.snp.centerY)
			}
		}
		containerView.add(timeLabel) {
			$0.snp.makeConstraints {
				$0.centerX.equalTo(self.containerView.snp.centerX).offset(20)
				$0.centerY.equalTo(self.containerView.snp.centerY)
			}
		}
		containerView.add(dateLabel) {
			$0.snp.makeConstraints {
				$0.centerY.equalTo(self.containerView.snp.centerY)
				$0.centerX.equalTo(self.timeLabel.snp.centerX).offset(-95)
			}
		}
		containerView.add(methodLabel) {
			$0.snp.makeConstraints {
				$0.centerY.equalTo(self.containerView.snp.centerY)
				$0.trailing.equalTo(self.timeLabel.snp.trailing).offset(73)
			}
		}
		containerView.add(firstSeperatorView) {
			$0.snp.makeConstraints {
				$0.height.equalTo(self.methodLabel)
				$0.width.equalTo(2)
				$0.centerX.equalTo(self.timeLabel.snp.centerX).offset(-53)
				$0.centerY.equalTo(self.containerView.snp.centerY)
			}
		}
		containerView.add(secondSeperatorView) {
			$0.snp.makeConstraints {
				$0.height.equalTo(self.methodLabel)
				$0.width.equalTo(2)
				$0.centerX.equalTo(self.timeLabel.snp.centerX).offset(55)
				$0.centerY.equalTo(self.containerView.snp.centerY)
			}
		}
	}
	
	// MARK: - Lifecycle
	override func awakeFromNib() {
		super.awakeFromNib()
		layout()
	}
}
