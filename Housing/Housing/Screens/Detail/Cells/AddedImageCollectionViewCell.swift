//
//  AddedImageCollectionViewCell.swift
//  Housing
//
//  Created by 노한솔 on 2021/01/06.
//

import UIKit

import Kingfisher
import SnapKit
import Then

class AddedImageCollectionViewCell: UICollectionViewCell {
	
	let addedImageView = UIImageView()
	let blurView = UIView()
	let circleView = UIView()
	let plusLabel = UILabel()
	
	func layout() {
		contentView.backgroundColor = .white
		self.contentView.add(addedImageView) {
			$0.layer.cornerRadius = 16
			$0.snp.makeConstraints {
				$0.edges.equalTo(self.contentView)
			}
		}
		self.contentView.add(blurView) {
			$0.layer.opacity = 0.8
			$0.backgroundColor = .primaryWhite
			$0.isHidden = true
			$0.snp.makeConstraints {
				$0.edges.equalTo(self.contentView)
			}
		}
		self.contentView.add(circleView) {
			$0.backgroundColor = .primaryOrange
			$0.isHidden = true
			$0.layer.cornerRadius = 13
			$0.snp.makeConstraints {
				$0.height.equalTo(26)
				$0.width.equalTo(26)
				$0.centerX.equalTo(self.contentView.snp.centerX)
				$0.centerY.equalTo(self.contentView.snp.centerY)
			}
		}
		self.circleView.add(plusLabel) {
			$0.font = UIFont.systemFont(ofSize: 13, weight: .bold)
			$0.textColor = .primaryWhite
			$0.textAlignment = .center
			$0.isHidden = true
			$0.snp.makeConstraints {
				$0.centerY.equalTo(self.circleView.snp.centerY)
				$0.centerX.equalTo(self.circleView.snp.centerX)
			}
		}
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		layout()
	}
}
