//
//  emptyIncomTableViewCell.swift
//  Housing
//
//  Created by JUEUN KIM on 2021/01/08.
//

import UIKit

class EmptyIncomTableViewCell: UITableViewCell {

	@IBOutlet var emptyLabel: UILabel!
	@IBOutlet var inquiryButton: UIButton!
	
	var rootViewController: UIViewController?
	
	func makeButtonRounded(){
		inquiryButton.setRounded(radius: 20)
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		inquiryButton.addTarget(self, action: #selector(inquiryButtonDidTap), for: .touchUpInside)
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
	@objc
	func inquiryButtonDidTap() {
		guard let buttonText = inquiryButton.titleLabel?.text else { return }
		if buttonText == "초대하기" {
			let viewController = VerifyNumberViewController()
			rootViewController?.navigationController?.pushViewController(viewController, animated: true)
		} else {
			let viewController = PromiseViewController()
			rootViewController?.navigationController?.pushViewController(viewController, animated: true)
		}
	}
	

}
