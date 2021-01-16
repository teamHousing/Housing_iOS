//
//  IncompleteTableViewCell.swift
//  Housing
//
//  Created by JUEUN KIM on 2021/01/07.
//

import UIKit

class IncompleteTableViewCell: UITableViewCell {

	@IBOutlet var roomNumberButton: UIButton!
	@IBOutlet var countOfIncomplete: UILabel!
	@IBOutlet var incomToggle: UIImageView!

	override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
