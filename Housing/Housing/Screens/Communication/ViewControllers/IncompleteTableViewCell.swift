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
        // Initialization code
    }
	

	@IBAction func touchUpInComButton(_ sender: Any) {
	}
	//	@IBAction func touchUpIncomButton(_ sender: Any) {
//		incomButton.addTarget(CommunicationViewController(), action: #selector(CommunicationViewController.handleExpandAndClose), for: .touchUpInside)
////	}
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
