//
//  IncompleteTableViewCell.swift
//  Housing
//
//  Created by JUEUN KIM on 2021/01/07.
//

import UIKit

class IncompleteTableViewCell: UITableViewCell {

	@IBOutlet var roomNumberView: UIView!
	@IBOutlet var countOfIncomplete: UILabel!
	@IBOutlet var incomButton: UIButton!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	
	func makeViewRounded(){
		roomNumberView.setRounded(radius: 15)
	}
//	@IBAction func touchUpIncomButton(_ sender: Any) {
//		incomButton.addTarget(CommunicationViewController(), action: #selector(CommunicationViewController.handleExpandAndClose), for: .touchUpInside)
//	}
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
