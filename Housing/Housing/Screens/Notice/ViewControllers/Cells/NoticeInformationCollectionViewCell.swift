//
//  NoticeInformationCollectionViewCell.swift
//  Housing
//
//  Created by 곽기곤's Mac on 2021/01/08.
//

import UIKit

struct NoticeData {
		var title: String
		var context: String
}

class NoticeInformationCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
		@IBOutlet weak var contextLabel: UILabel!
		
		var FDF: NoticeData?
		
		func fetchData() {
				titleLabel.text = FDF?.title
				contextLabel.text = FDF?.context
				contextLabel.numberOfLines = 0
		}
}
