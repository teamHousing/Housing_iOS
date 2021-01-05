//
//  CommunicateMethodTableViewCell.swift
//  Housing
//
//  Created by 노한솔 on 2021/01/05.
//

import UIKit

import Then
import SnapKit

class CommunicateMethodTableViewCell: UITableViewCell {
	
	var method = [CommunicationMethod(date: "aa", time: "bb", method: "cc"),
								CommunicationMethod(date: "", time: "", method: "")]
	
	let methodTableView = UITableView().then{
		$0.backgroundColor = .primaryWhite
	}
	
	let containerView = UIView().then{
		$0.backgroundColor = .primaryGray
	}
	
	static func estimatedRowHeight() -> CGFloat {
		return 202
	}
		override func awakeFromNib() {
			super.awakeFromNib()
			self.methodTableView.delegate = self
			self.methodTableView.dataSource = self
			// Initialization code
		}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
}
extension CommunicateMethodTableViewCell: UITableViewDelegate{
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "MethodDetailTableViewCell") as?
						MethodDetailTableViewCell else {
			return UITableViewCell()
		}
		return cell
	}
}

extension CommunicateMethodTableViewCell: UITableViewDataSource{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.method.count
	}
}
