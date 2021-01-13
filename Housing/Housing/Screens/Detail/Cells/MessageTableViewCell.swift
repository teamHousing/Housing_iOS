//
//  MessageTableViewCell.swift
//  Housing
//
//  Created by 노한솔 on 2021/01/07.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
	
	var status: [Int] = [0,1,2,3]
	var confirmedPromiseOption = ""
	var card: [MessageCard] = [MessageCard(title: "다시 한번 약속해주세요.", context: "작성하신 일정 중 가능한 일자가 없어요. 😂\n일자와 시간대를 수정 혹은 추가해주세요!", buttonTitle: "약속 수정하기"),
														 MessageCard(title: "다시 한번 약속해주세요.", context: "작성하신 일정 중 가능한 일자가 없어요. 😂\n일자와 시간대를 수정 혹은 추가해주세요!", buttonTitle: "약속 수정하기"),
														 MessageCard(title: "다시 한번 약속해주세요.", context: "작성하신 일정 중 가능한 일자가 없어요. 😂\n일자와 시간대를 수정 혹은 추가해주세요!", buttonTitle: "약속 수정하기"),
														 MessageCard(title: "다시 한번 약속해주세요.", context: "작성하신 일정 중 가능한 일자가 없어요. 😂\n일자와 시간대를 수정 혹은 추가해주세요!", buttonTitle: "약속 수정하기")]
	
	let messageTableView = UITableView()
	
	var rootViewController: UIViewController?
	
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
extension MessageTableViewCell: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if self.status[indexPath.row] == 0 || self.status[indexPath.row] == 1 || self.status[indexPath.row] == 3 {
		return 215
	}
		else {
			return 165
			
		}
	}
}

extension MessageTableViewCell: UITableViewDataSource {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: MessageDetailTableViewCell = tableView.dequeueCell(forIndexPath: indexPath)
		if self.status[indexPath.row] == 0 {
			cell.titleLabel.text = "문의사항이 등록되었어요!"
			cell.contextLabel.attributedText = self.makeAttributed(context: "아래의 버튼을 눌러\n약속시간을 정해보세요.")
			cell.transitionButton.setTitle("약속 확정하기", for: .normal)
		}
		else if self.status[indexPath.row] == 1 {
			cell.titleLabel.text = "약속이 확정되었어요!"
			var confirmedPromise = "\(self.confirmedPromiseOption)예정이에요\n 캘린더에서 일정을 확인해보세요."
			cell.contextLabel.attributedText = self.makeAttributed(context: confirmedPromise)
			
			
			cell.transitionButton.setTitle("캘린더 보기", for: .normal)
		}
		else if self.status[indexPath.row] == 2 {
			cell.titleLabel.text = "약속 수정 요청을 보냈어요!"
			cell.contextLabel.attributedText = self.makeAttributed(context: "앞으로도 하우징과 함께\n자취생과 소통해보세요!")
			cell.transitionButton.snp.makeConstraints {
				$0.height.equalTo(0)
			}
		}
		else if self.status[indexPath.row] == 3 {
			cell.titleLabel.text = "약속을 확정해주세요!"
			cell.contextLabel.attributedText = self.makeAttributed(context: "약속이 수정되었습니다.\n확인 후 약속을 확정해 주세요.")
			cell.transitionButton.setTitle("약속 확정하기", for: .normal)
		}
		else {
			cell.titleLabel.text = "문의사항이 해결되었어요!"
			cell.contextLabel.attributedText = self.makeAttributed(context: "앞으로도 하우징과 함께\n자취생과 소통해보세요!")
			cell.transitionButton.snp.makeConstraints {
				$0.height.equalTo(0)
			}
		}
		
		cell.selectionStyle = .none
		
		if indexPath.row == self.status.count-1 {
			cell.connectLineView.isHidden = true
			if(cell.transitionButton.isHidden == false) {
				cell.transitionButton.backgroundColor = .primaryBlack
				cell.transitionButton.isUserInteractionEnabled = true
			}
		}
		cell.awakeFromNib()
		return cell
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.status.count
	}
	
	
}
