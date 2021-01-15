//
//  emptyIncomTableViewCell.swift
//  Housing
//
//  Created by JUEUN KIM on 2021/01/08.
//

import UIKit

class EmptyIncomTableViewCell: UITableViewCell {

	@IBOutlet var emptyLabel: UILabel!
	@IBOutlet var inquiryButton: UIButton!

	func makeButtonRounded() {
		inquiryButton.setRounded(radius: 20)
	}

    override func awakeFromNib() {
        super.awakeFromNib()
    }
	
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
