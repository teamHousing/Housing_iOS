//
//  MessageTableViewCell.swift
//  Housing
//
//  Created by 노한솔 on 2021/01/07.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
	
	var status: [Int] = [0,1,2,3]
	
	var card: [MessageCard] = [MessageCard(title: "다시 한번 약속해주세요.", context: "작성하신 일정 중 가능한 일자가 없어요. 😂\n일자와 시간대를 수정 혹은 추가해주세요!", buttonTitle: "약속 수정하기"),
														 MessageCard(title: "다시 한번 약속해주세요.", context: "작성하신 일정 중 가능한 일자가 없어요. 😂\n일자와 시간대를 수정 혹은 추가해주세요!", buttonTitle: "약속 수정하기"),
														 MessageCard(title: "다시 한번 약속해주세요.", context: "작성하신 일정 중 가능한 일자가 없어요. 😂\n일자와 시간대를 수정 혹은 추가해주세요!", buttonTitle: "약속 수정하기"),
														 MessageCard(title: "다시 한번 약속해주세요.", context: "작성하신 일정 중 가능한 일자가 없어요. 😂\n일자와 시간대를 수정 혹은 추가해주세요!", buttonTitle: "약속 수정하기")]
	
	let messageTableView = UITableView()
	
	static func estimatedRowHeight() -> CGFloat {
		return 1400
	}
	
	func makeAttributed(context: String) -> NSAttributedString{
		let attributedString = NSMutableAttributedString(string: context)
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineSpacing = 4
		paragraphStyle.alignment = .center
		attributedString.addAttribute(NSAttributedString.Key.paragraphStyle,
																	value:paragraphStyle,
																	range:NSMakeRange(0, attributedString.length))
		return attributedString
	}
	
	func layout() {
		self.contentView.then {
			$0.backgroundColor = .primaryGray
		}
		self.contentView.add(self.messageTableView){
			$0.isScrollEnabled = false
			$0.isPagingEnabled = false
			$0.isUserInteractionEnabled = true
			$0.backgroundColor = .primaryGray
			$0.snp.makeConstraints{
				$0.top.equalTo(self.contentView.snp.top).offset(30)
				$0.leading.equalTo(self.contentView.snp.leading)
				$0.trailing.equalTo(self.contentView.snp.trailing)
				$0.bottom.equalTo(self.contentView.snp.bottom).offset(-30)
				$0.height.equalTo(self.status.count*215)
			}
		}
	}
	
	func registerCell() {
		messageTableView.register(MessageDetailTableViewCell.self, forCellReuseIdentifier: MessageDetailTableViewCell.reuseIdentifier)
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		registerCell()
		layout()
		self.messageTableView.isScrollEnabled = false
		self.messageTableView.separatorStyle = .none
		self.messageTableView.delegate = self
		self.messageTableView.dataSource = self
		self.messageTableView.estimatedRowHeight = CGFloat(self.status.count * 208)
		self.messageTableView.rowHeight = UITableView.automaticDimension
		self.messageTableView.reloadData()
		self.backgroundColor = .primaryGray
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
}
extension MessageTableViewCell: UITableViewDelegate{
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 215
	}
}

extension MessageTableViewCell: UITableViewDataSource{
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "MessageDetailTableViewCell") as?
						MessageDetailTableViewCell else {
			return UITableViewCell()
		}
		cell.awakeFromNib()
		cell.titleLabel.text = self.card[indexPath.row].title
		cell.contextLabel.attributedText = self.makeAttributed(context: self.card[indexPath.row].context)
		cell.transitionButton.setTitle(self.card[indexPath.row].buttonTitle, for: .normal)
		cell.selectionStyle = .none
		if indexPath.row == self.status.count-1 {
			cell.connectLineView.isHidden = true
		}
		return cell
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.status.count
	}
	
	
}
