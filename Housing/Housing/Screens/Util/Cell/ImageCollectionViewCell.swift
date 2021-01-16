//
//  ImageCollectionViewCell.swift
//  Housing
//
//  Created by 오준현 on 2021/01/16.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
	
	let imageView = UIImageView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		layout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func layout() {
		contentView.add(imageView) {
			$0.snp.makeConstraints {
				$0.centerX.centerY.equalTo(self.contentView)
				$0.width.height.equalTo(self.contentView.frame.width)
			}
		}
	}
	
	func image(_ url: String) {
		imageView.imageFromUrl(url, defaultImgPath: "")
	}
	func image(_ image: UIImage) {
		imageView.image = image
	}
}
