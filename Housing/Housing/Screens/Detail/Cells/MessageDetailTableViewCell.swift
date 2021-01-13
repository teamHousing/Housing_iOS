//
//  MessageDetailTableViewCell.swift
//  Housing
//
//  Created by 노한솔 on 2021/01/07.
//

import UIKit

class MessageDetailTableViewCell: UITableViewCell {
	
	// MARK: - Property
	let containerView = UIView().then {
		$0.backgroundColor = .primaryWhite
		$0.layer.cornerRadius = 16
		$0.layer.applyCardShadow()
	}
	let titleLabel = UILabel().then {
		$0.textColor = .primaryBlack
		$0.font = UIFont.systemFont(ofSize: 17, weight: .bold)
		$0.textAlignment = .center
	}
	let contextLabel = UILabel().then {
		$0.textColor = .primaryBlack
		$0.font = UIFont.systemFont(ofSize: 13, weight: .regular)
		$0.textAlignment = .center
		$0.numberOfLines = 0
	}
	let transitionButton = UIButton().then {
		$0.backgroundColor = .gray01
		$0.isUserInteractionEnabled = false
		$0.layer.cornerRadius = 20
		$0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
		$0.titleLabel?.textAlignment = .center
		$0.titleLabel?.textColor = .primaryWhite
		$0.setTitleColor(.primaryWhite, for: .normal)
	}
	let circleView = UIView().then() {
		$0.backgroundColor = .primaryBlack
		$0.layer.cornerRadius = 6
	}
	let connectLineView = UIView().then {
		$0.backgroundColor = .gray01
	}
	
	var rootViewController: UIViewController?
	
	// MARK: - Helper
	static func estimatedRowHeight() -> CGFloat {
		return 300
	}
	
	private func layout() {
		self.contentView.add(containerView) {
			$0.snp.makeConstraints {
				$0.top.equalTo(self.contentView.snp.top).offset(0)
				$0.bottom.equalTo(self.contentView.snp.bottom).offset(0)
				$0.leading.equalTo(self.contentView.snp.leading).offset(52)
				$0.trailing.equalTo(self.contentView.snp.trailing).offset(-20)
			}
		}
		self.contentView.add(circleView) {
			$0.snp.makeConstraints {
				$0.width.height.equalTo(12)
				$0.leading.equalTo(self.contentView.snp.leading).offset(20)
				$0.top.equalTo(self.containerView.snp.top).offset(20)
			}
		}
		containerView.add(titleLabel) {
			$0.snp.makeConstraints {
				$0.centerX.equalTo(self.containerView.snp.centerX)
				$0.top.equalTo(self.containerView.snp.top).offset(28)
				$0.height.equalTo(22)
			}
		}
		containerView.add(contextLabel) {
			$0.snp.makeConstraints {
				$0.centerX.equalTo(self.containerView.snp.centerX)
				$0.top.equalTo(self.titleLabel.snp.bottom).offset(8)
				$0.height.equalTo(50)
			}
		}
		containerView.add(transitionButton) {
			$0.snp.makeConstraints {
				$0.centerX.equalTo(self.containerView.snp.centerX)
				$0.top.equalTo(self.contextLabel.snp.bottom).offset(24)
				$0.height.equalTo(40)
				$0.width.equalTo(203)
			}
		}
		containerView.add(connectLineView) {
			$0.clipsToBounds = false
			$0.snp.makeConstraints {
				$0.height.equalTo(180)
				$0.width.equalTo(1)
				$0.centerX.equalTo(self.circleView.snp.centerX)
				$0.top.equalTo(self.circleView.snp.bottom).offset(12)
			}
		}
	}
	
	override func layoutSubviews() {
		super .layoutSubviews()
		contentView.frame = contentView.frame.inset(
			by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
		)
	}
	
	// MARK: - Lifecycle
	override func awakeFromNib() {
		super.awakeFromNib()
		layout()
		self.backgroundColor = .primaryGray
	}
}
