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
	
	func layout() {
		contentView.backgroundColor = .white
		self.contentView.add(addedImageView) {
			$0.setBorder(borderColor: .red, borderWidth: 2)

			$0.snp.makeConstraints {
				$0.top.trailing.equalTo(self.contentView)
				$0.leading.equalTo(self.contentView).offset(2)
			}
		}
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		layout()
	}
}
