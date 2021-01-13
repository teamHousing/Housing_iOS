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
	
	var contentData = DetailData(id: 0, issueTitle: "", issueContents: "", progress: 0, category: 0)
	
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

	func determineCategoty(category : Int) -> String {
		if category == 0 {
			return "고장수리"
		}else if category == 1 {
			return "계약관련"
		}else if category == 2 {
			return "요금납부"
		}else if category == 3 {
			return "소음관련"
		}else if category == 4 {
			return "문의사항"
		}else if category == 5 {
			return "기타"
		}
		return ""
	}
	func filloutCell(){
		statusLabel?.text = determineProgress(progress: contentData.progress)
		categoryLabel?.text = determineCategoty(category: contentData.category)
		titleLabel?.text = contentData.issueTitle
		contentLabel?.text = contentData.issueContents
	}
	func makeViewRounded(){
		whiteUIView.setRounded(radius: 16)
		labelBackView.setRounded(radius: 10)
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		filloutCell()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
}
