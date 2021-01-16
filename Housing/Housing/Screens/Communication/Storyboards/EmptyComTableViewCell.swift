//
//  emptyComTableViewCell.swift
//  Housing
//
//  Created by JUEUN KIM on 2021/01/08.
//

import UIKit

class EmptyComTableViewCell: UITableViewCell {

	@IBOutlet var emptyLabel: UILabel!
	override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
