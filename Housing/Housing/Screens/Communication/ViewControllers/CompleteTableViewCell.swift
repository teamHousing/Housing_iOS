//
//  CompleteTableViewCell.swift
//  Housing
//
//  Created by JUEUN KIM on 2021/01/07.
//

import UIKit

class CompleteTableViewCell: UITableViewCell {
	@IBOutlet var countOfComplete: UILabel!
	@IBOutlet var comToggle: UIImageView!
	
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
