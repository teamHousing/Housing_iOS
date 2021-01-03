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
}
