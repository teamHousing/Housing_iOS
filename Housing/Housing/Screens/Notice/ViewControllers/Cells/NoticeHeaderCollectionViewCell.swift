//
//  NoticeHeaderCollectionViewCell.swift
//  Housing
//
//  Created by 곽기곤's Mac on 2021/01/08.
//

import UIKit

class NoticeHeaderCollectionViewCell: UICollectionViewCell {
	
	var id: Int?
	var info: HouseInfo?
	@IBOutlet weak var headerBackgroundView: UIView!
	@IBOutlet weak var profileMessageView: UIView!
	@IBOutlet weak var hopeTimeLabel: UILabel!
	@IBOutlet weak var responseTimeLabel: UILabel!
	@IBOutlet weak var profileMessageLabel: UILabel!
	@IBOutlet weak var profileImage: UIImageView!
	@IBOutlet weak var ownerNameLabel: UILabel!
	
	func headerlayout() {
		self.headerBackgroundView.layer.applyShadow()
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
	}
	
	func houseInfo() {
		guard let time1 = info?.hopeTime[0],
					let time2 = info?.hopeTime[1],
					let time3 = info?.responseTime
		else {
			return
		}
		hopeTimeLabel.text = "\(time1) - \(time2) 연락가능"
		responseTimeLabel.text = "\(time3)"
		profileMessageLabel.text = info?.profileMessage
		profileImage.setImage(from: info?.profileImg ?? "", UIImage())
		ownerNameLabel.text = info?.ownerName
//		self.id = id
		self.id = info?.id
	}
}
