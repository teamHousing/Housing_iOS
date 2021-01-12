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
	
	var contentData:DetailData?
	
	func determineProgress(progress: Int) -> String {
		if progress == 0{
			return "확인전"
		} else if progress == 1{
			return "확인중"
		} else if progress == 2{
			return "해결 완료"
		}
		return ""
	}
	
	func filloutCell(){
		categoryLabel?.text = contentData?.category
		titleLabel?.text = contentData?.issueTitle
		statusLabel?.text = determineProgress(progress: contentData!.progress)
		contentLabel?.text = contentData?.issueContents
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
