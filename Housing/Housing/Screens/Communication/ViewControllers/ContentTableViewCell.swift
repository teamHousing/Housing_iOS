//
//  ContentTableViewCell.swift
//  Housing
//
//  Created by JUEUN KIM on 2021/01/05.
//

import UIKit

class ContentTableViewCell: UITableViewCell {
	
	@IBOutlet var whiteUIView: UIView!
	@IBOutlet var categoryLabel: UILabel!
	@IBOutlet var titleLabel: UILabel!
	@IBOutlet var statusLabel: UILabel!
	@IBOutlet var contentLabel: UILabel!
	@IBOutlet var labelBackView: UIView!
	
	var cellData:DetailData?
	
	func makeCell(){
		categoryLabel?.text = cellData?.category
		titleLabel?.text = cellData?.issueTitle
		statusLabel?.text = cellData?.
		contentLabel?.text = cellData?.content
	}
	
	func makeViewRounded(){
		whiteUIView.setRounded(radius: 16)
		labelBackView.setRounded(radius: 10)
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
