//
//  photoCollectionViewCell.swift
//  Housing
//
//  Created by 김태훈 on 2021/01/04.
//

import UIKit

class photoCollectionViewCell: UICollectionViewCell {
    static let identifier = "photos"
	
	static let registerId = "\(photoCollectionViewCell.self)"
	let evidenceImages = UIImageView().then{
		$0.setRounded(radius: 15)
		$0.layer.applyShadow()
	}
	let deleteBtn = UIButton().then{
		$0.isHidden = false
	}
  @IBOutlet weak var cellHeight: NSLayoutConstraint!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		bindConstraints()
		
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		bindConstraints()
	}

	private func bindConstraints() {
		adds([evidenceImages,
		deleteBtn])
		evidenceImages.snp.makeConstraints{
			$0.edges.equalTo(0)
		}
		deleteBtn.snp.makeConstraints{
			$0.top.equalTo(evidenceImages.snp.top).offset(10)
			$0.trailing.equalTo(evidenceImages.snp.trailing).offset(10)
			$0.width.height.equalTo(44)
			
		}
	}
}
