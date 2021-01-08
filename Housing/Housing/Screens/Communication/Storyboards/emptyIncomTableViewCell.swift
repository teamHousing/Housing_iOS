//
//  emptyIncomTableViewCell.swift
//  Housing
//
//  Created by JUEUN KIM on 2021/01/08.
//

import UIKit

class emptyIncomTableViewCell: UITableViewCell {
	@IBOutlet var inquiryButton: UIButton!
	func makeButtonRounded(){
		inquiryButton.setRounded(radius: 15)
		
	}
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
