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
	
	var method = [CommunicationMethod(date: "2020. 10. 20", time: "14 - 18시", method: "집 방문"),
								CommunicationMethod(date: "", time: "", method: "")]
	
	let titleLabel = UILabel().then{
		$0.text = "소통 방식"
		$0.textColor = .primaryBlack
		$0.font = UIFont.systemFont(ofSize: 15, weight: .bold)
		$0.textAlignment = .left
	}
	let methodTableView = UITableView().then{
		$0.backgroundColor = .primaryBlack
	}
	
	
	static func estimatedRowHeight() -> CGFloat {
		return 202
	}
	
	
	
	func layout() {
		self.contentView.add(titleLabel){
			$0.snp.makeConstraints{
				$0.top.equalTo(self.contentView.snp.top).offset(5)
				$0.leading.equalTo(self.contentView.snp.leading).offset(40)
			}
		}
		self.contentView.add(self.methodTableView){
			$0.snp.makeConstraints{
				$0.top.equalTo(self.titleLabel.snp.bottom).offset(20)
				$0.leading.equalTo(self.contentView.snp.leading)
				$0.trailing.equalTo(self.contentView.snp.trailing)
				$0.height.equalTo(126)
			}
		}
	}
	
	func registerCell() {
		methodTableView.register(MethodDetailTableViewCell.self, forCellReuseIdentifier: MethodDetailTableViewCell.reuseIdentifier)
	}

		override func awakeFromNib() {
			super.awakeFromNib()
			registerCell()
			layout()
			self.methodTableView.isScrollEnabled = false
			self.methodTableView.separatorStyle = .none
			self.methodTableView.delegate = self
			self.methodTableView.dataSource = self
			// Initialization code
		}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
}
extension CommunicateMethodTableViewCell: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 70
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "MethodDetailTableViewCell") as?
						MethodDetailTableViewCell else {
			return UITableViewCell()
		}
		print(#function)
		cell.awakeFromNib()
		cell.dateLabel.text = self.method[indexPath.row].date
		cell.timeLabel.text = self.method[indexPath.row].time
		cell.methodLabel.text = self.method[indexPath.row].method
		return cell
	}
	

}

extension CommunicateMethodTableViewCell: UITableViewDataSource{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.method.count
	}
}
