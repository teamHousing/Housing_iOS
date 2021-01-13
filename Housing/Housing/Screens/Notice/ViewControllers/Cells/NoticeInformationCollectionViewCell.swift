//
//  NoticeInformationCollectionViewCell.swift
//  Housing
//
//  Created by 곽기곤's Mac on 2021/01/08.
//

import UIKit

class NoticeInformationCollectionViewCell: UICollectionViewCell {
	@IBOutlet weak var containerView: UIView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var contextLabel: UILabel!
	
	var noticeInfo: Notice?
	
	func fetchData() {
        titleLabel.text = noticeInfo?.noticeTitle
		contextLabel.text = noticeInfo?.noticeContents
		contextLabel.numberOfLines = 0
	}
}
