//
//  CommunmicationTableViewCell.swift
//  Housing
//
//  Created by JUEUN KIM on 2021/01/04.
//

import UIKit

class CommunmicationTableViewCell: UITableViewCell {
	//MARK: Property
	@IBOutlet var category: UILabel!
	@IBOutlet var titleLabel: UILabel!
	@IBOutlet var statusLabel: UILabel!
	@IBOutlet var contentLabel: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
