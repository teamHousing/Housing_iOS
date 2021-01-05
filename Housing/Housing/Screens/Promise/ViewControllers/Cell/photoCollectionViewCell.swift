//
//  photoCollectionViewCell.swift
//  Housing
//
//  Created by 김태훈 on 2021/01/04.
//

import UIKit

class photoCollectionViewCell: UICollectionViewCell {
    static let identifier = "photos"
	@IBOutlet weak var evidenceImages: UIImageView!
	@IBOutlet weak var deleteBtn: UIButton!
  @IBOutlet weak var cellHeight: NSLayoutConstraint!
	override func awakeFromNib() {
		super.awakeFromNib()
		//evidenceImages.translatesAutoresizingMaskIntoConstraints = true
		//self.cellHeight.constant = 214
		//evidenceImages.widthConstraint?.constant = 162
		//evidenceImages.heightConstraint?.constant = 162
 	}

}
