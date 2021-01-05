//
//  RequestTableViewCell.swift
//  Housing
//
//  Created by 노한솔 on 2021/01/05.
//

import UIKit

import Then
import SnapKit

class RequestTableViewCell: UITableViewCell {
	
	let titleLabel = UILabel().then{
		$0.text = "요청 사항"
		$0.textColor = .primaryBlack
		$0.font = UIFont.systemFont(ofSize: 15, weight: .bold)
		$0.textAlignment = .left
	}
	let contextLabel = UILabel().then{
		$0.text = "요청 사항"
		$0.textColor = .primaryBlack
		$0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
		$0.textAlignment = .left
	}
	
	let requestView = UIView().then{
		$0.backgroundColor = .primaryWhite
	}
	
	static func estimatedRowHeight() -> CGFloat {
		return 138
	}
	
	func layout() {
		self.contentView.add(requestView){
			$0.snp.makeConstraints{
				$0.top.bottom.leading.trailing.equalTo(self.contentView).offset(0)
			}
		}
		self.requestView.add(titleLabel){
			$0.snp.makeConstraints{
				$0.top.equalTo(self.requestView.snp.top).offset(2)
				$0.leading.equalTo(self.requestView.snp.leading).offset(39)
			}
		}
		self.requestView.add(contextLabel){
			$0.snp.makeConstraints{
				$0.top.equalTo(self.titleLabel.snp.bottom).offset(12)
				$0.leading.equalTo(self.contentView.snp.leading).offset(20)
			}
		}
	}
	override func awakeFromNib() {
		super.awakeFromNib()
		layout()
		// Initialization code
	}
	
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
}
