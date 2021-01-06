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
	
	let cancelButton = UIButton().then{
		$0.setTitle("요청 취소", for: .normal)
		$0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
		$0.titleLabel?.textAlignment = .center
		$0.titleLabel?.textColor = .primaryBlack
		$0.setBorder(borderColor: .gray01, borderWidth: 1)
	}
	
	func layout() {
		contentView.backgroundColor = .white
		self.contentView.add(addedImageView) {
			$0.snp.makeConstraints {
				$0.top.trailing.equalTo(self.contentView)
				$0.bottom.equalTo(self.cancelButton).offset(-72)
				$0.leading.equalTo(self.contentView).offset(2)
			}
		}
		self.contentView.add(cancelButton) {
			$0.snp.makeConstraints {
				$0.leading.equalTo(self.contentView).offset(60)
				$0.trailing.equalTo(self.contentView).offset(-60)
				$0.bottom.equalTo(self.contentView).offset(20)
			}
		}
	}
	
	func configImg(imageURL: String) {
		print(imageURL)
		let data = try? Data(contentsOf: URL(string: imageURL)!)
		self.addedImageView.image = UIImage(data: data!)
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		layout()
	}
}
