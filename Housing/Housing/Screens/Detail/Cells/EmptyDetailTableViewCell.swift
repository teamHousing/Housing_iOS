//
//  EmptyDetailTableViewCell.swift
//  Housing
//
//  Created by 노한솔 on 2021/01/14.
//

import UIKit

import SnapKit
import Then

class EmptyDetailTableViewCell: UITableViewCell {
	// MARK: - Property
	let containerView = UIView().then {
		$0.backgroundColor = .clear
	}
	let emptyImageView = UIImageView().then {
		$0.image = UIImage(named: "imgHomeBlank")
	}
	let emptyLabel = UILabel().then {
		$0.text = "아직 도착한 쪽지가 없어요❌"
		$0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
		$0.textAlignment = .center
		$0.textColor = .primaryBlack
	}
	
	// MARK: - Helper
	static func estimatedRowHeight() -> CGFloat {
		return 300
	}
	
	private func layout() {
		self.contentView.add(self.containerView) {
			$0.snp.makeConstraints {
				$0.top.equalTo(self.contentView.snp.top).offset(52)
				$0.centerX.equalTo(self.contentView.snp.centerX)
				$0.width.height.equalTo(120)
			}
		}
		self.contentView.add(self.emptyLabel) {
			$0.snp.makeConstraints {
				$0.top.equalTo(self.containerView.snp.bottom).offset(24)
				$0.centerX.equalTo(self.contentView.snp.centerX)
			}
		}
		self.containerView.add(self.emptyImageView) {
			$0.snp.makeConstraints {
				$0.edges.equalTo(self.containerView)
			}
		}
	}
	
	// MARK: - Lifecycle
	override func awakeFromNib() {
		super.awakeFromNib()
		layout()
		self.backgroundColor = .primaryGray
	}
}
