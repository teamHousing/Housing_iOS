//
//  MessageTableViewCell.swift
//  Housing
//
//  Created by 노한솔 on 2021/01/07.
//

import UIKit

import RxMoya
import RxSwift
import RxCocoa
import Moya

class MessageTableViewCell: UITableViewCell {
	
	// MARK: - Property
	let messageTableView = UITableView()
	let disposeBag = DisposeBag()
	private let detailProvider = MoyaProvider<DetailService>(
		plugins: [NetworkLoggerPlugin(verbose: true)]
	)
	private let requestId = promiseId.shared.id
	
	var status: [Int] = [0,1,2,3]
	var userOrOwner = 3
	var confirmedPromiseOption = ""
	var rootViewController: UIViewController?
	var checkToModify = 1
	
	// MARK: - Helper
	static func estimatedRowHeight() -> CGFloat {
		return 1400
	}
	
	private func makeAttributed(context: String) -> NSAttributedString {
		let attributedString = NSMutableAttributedString(string: context)
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineSpacing = 4
		paragraphStyle.alignment = .center
		attributedString.addAttribute(NSAttributedString.Key.paragraphStyle,
																	value:paragraphStyle,
																	range:NSMakeRange(0, attributedString.length)
		)
		return attributedString
	}
	func loader() {
		self.detailProvider.rx.request(.confirmDetail(id: requestId))
			.asObservable()
			.subscribe { (next) in
				if next.statusCode == 200 {
					do {
					} catch {
						print(error)
					}
				}
			} onError: { (error) in
				print(error.localizedDescription)
			}.disposed(by: disposeBag)
	}
	private func layout() {
		self.contentView.then {
			$0.backgroundColor = .primaryGray
		}
		self.contentView.add(self.messageTableView) {
			$0.isScrollEnabled = false
			$0.isPagingEnabled = false
			$0.isUserInteractionEnabled = true
			$0.backgroundColor = .primaryGray
			$0.snp.makeConstraints {
				$0.top.equalTo(self.contentView.snp.top).offset(30)
				$0.leading.equalTo(self.contentView.snp.leading)
				$0.trailing.equalTo(self.contentView.snp.trailing)
				$0.bottom.equalTo(self.contentView.snp.bottom).offset(-30)
				$0.height.equalTo(self.status.count*215)
			}
		}
	}
	
	private func registerCell() {
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
	}
}

// MARK: - UITableView Delegate
extension MessageTableViewCell: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if self.userOrOwner == 0 {
			if self.status[indexPath.row] == 0 ||
					self.status[indexPath.row] == 1 ||
					self.status[indexPath.row] == 3 {
				return 215
			}
			else {
				return 165
			}
		}
		else {
			if self.status[indexPath.row] == 1 ||
					self.status[indexPath.row] == 2 ||
					self.status[indexPath.row] == 3 {
				return 215
			}
			else {
				return 165
			}
		}
	}
}

// MARK: - UITableView DataSource

extension MessageTableViewCell: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.status.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: MessageDetailTableViewCell = tableView.dequeueCell(forIndexPath: indexPath)
		if self.userOrOwner == 0 {
			if self.status[indexPath.row] == 0 {
				cell.titleLabel.text = "문의사항이 등록되었어요!"
				cell.contextLabel.attributedText = self.makeAttributed(
					context: "아래의 버튼을 눌러\n약속시간을 정해보세요."
				)
				cell.transitionButton.addTarget(self,
																				action: #selector(didTapConfirmButton(_:)),
																				for: .touchUpInside
				)
				cell.transitionButton.setTitle("약속 확정하기", for: .normal)
			}
			else if self.status[indexPath.row] == 1 {
				cell.titleLabel.text = "약속이 확정되었어요!"
				var confirmedPromise = "\(self.confirmedPromiseOption)예정이에요\n 캘린더에서 일정을 확인해보세요."
				cell.contextLabel.attributedText = self.makeAttributed(context: confirmedPromise)				
				cell.transitionButton.addTarget(self,
																				action: #selector(didTapCalendarButton(_:)),
																				for: .touchUpInside)
				cell.transitionButton.setTitle("캘린더 보기", for: .normal)
				cell.transitionButton.isUserInteractionEnabled = true
				cell.transitionButton.backgroundColor = .primaryOrange
			}
			else if self.status[indexPath.row] == 2 {
				cell.titleLabel.text = "약속 수정 요청을 보냈어요!"
				cell.contextLabel.attributedText = self.makeAttributed(
					context: "앞으로도 하우징과 함께\n자취생과 소통해보세요!"
				)
				cell.transitionButton.snp.makeConstraints {
					$0.height.equalTo(0)
				}
			}
			else if self.status[indexPath.row] == 3 {
				cell.titleLabel.text = "약속을 확정해주세요!"
				cell.contextLabel.attributedText = self.makeAttributed(
					context: "약속이 수정되었습니다.\n확인 후 약속을 확정해 주세요."
				)
				cell.transitionButton.addTarget(self,
																				action: #selector(didTapConfirmButton(_:)),
																				for: .touchUpInside)
				cell.transitionButton.setTitle("약속 확정하기", for: .normal)
			}
			else {
				cell.titleLabel.text = "문의사항이 해결되었어요!"
				cell.contextLabel.attributedText = self.makeAttributed(
					context: "앞으로도 하우징과 함께\n자취생과 소통해보세요!"
				)
				cell.transitionButton.snp.makeConstraints {
					$0.height.equalTo(0)
				}
			}
		}
		else if userOrOwner == 1 {
			if self.status[indexPath.row] == 1 {
				cell.titleLabel.text = "약속이 확정되었어요!"
				var confirmedPromise = "\(self.confirmedPromiseOption)예정이에요\n 캘린더에서 일정을 확인해보세요."
				cell.contextLabel.attributedText = self.makeAttributed(context: confirmedPromise)
				cell.transitionButton.addTarget(self,
																				action: #selector(didTapCalendarButton(_:)),
																				for: .touchUpInside)
				cell.transitionButton.isUserInteractionEnabled = true
				cell.transitionButton.backgroundColor = .primaryOrange
				cell.transitionButton.setTitle("캘린더 보기", for: .normal)
			}
			else if self.status[indexPath.row] == 2 {
				cell.titleLabel.text = "문의사항을 확인했어요!"
				cell.contextLabel.attributedText = self.makeAttributed(
					context: "관리자가 문의사항을 확인했어요.\n문제가 해결되었나요?"
				)
				cell.transitionButton.addTarget(self,
																				action: #selector(didTapFinishButton(_:)),
																				for: .touchUpInside)
				cell.transitionButton.setTitle("해결이 완료되었어요!", for: .normal)
			}
			else if self.status[indexPath.row] == 3 {
				cell.titleLabel.text = "다시 한 번 약속해주세요!"
				cell.contextLabel.attributedText = self.makeAttributed(
					context: "작성하신 일정 중 가능한 일자가 없어요.😂\n일자와 시간대를 수정 혹은 추가해주세요!"
				)
				cell.transitionButton.addTarget(self,
																				action: #selector(didTapModifyButton(_:)),
																				for: .touchUpInside)
				cell.transitionButton.setTitle("약속 수정하기", for: .normal)
			}
			else {
					cell.titleLabel.text = "문의사항이 해결되었어요!"
					cell.contextLabel.attributedText = self.makeAttributed(
						context: "앞으로도 하우징과 함께\n자취생과 소통해보세요!"
					)
				cell.transitionButton.snp.makeConstraints {
					$0.height.equalTo(0)
				}
			}
		}
		
		cell.selectionStyle = .none
		
		if indexPath.row == self.status.count-1 {
			cell.connectLineView.isHidden = true
			if (cell.transitionButton.isHidden == false) {
				print(self.status)
				print(#function)
				print(#line)
				cell.transitionButton.backgroundColor = .primaryOrange
				cell.transitionButton.isUserInteractionEnabled = true
			}
		}
		cell.awakeFromNib()
		return cell
	}
	
	
	@objc
	func didTapConfirmButton(_ sender: UIButton) {
		let storyboard = UIStoryboard(name: StoryboardStorage.detail,bundle: nil)
		
		let viewcontroller = storyboard.instantiateViewController(
			withIdentifier: "ConfirmViewController")
		rootViewController?.navigationController?.pushViewController(viewcontroller, animated: true)
	}
	
	@objc
	func didTapCalendarButton(_ sender: UIButton) {
		let viewController = CalendarViewController()
		viewController.isTab = true
		rootViewController?.navigationController?.pushViewController(viewController, animated: true)
	}
	
	@objc
	func didTapFinishButton(_ sender: UIButton) {
		self.loader()
		sender.isEnabled = false
		sender.backgroundColor = .gray01
		let storyboard = UIStoryboard(name: StoryboardStorage.detail,bundle: nil)
		let vc = storyboard.instantiateViewController(
			withIdentifier: "DetailViewController") as? DetailViewController
		vc?.loader()
		//		let vc2 = storyboard.instantiateViewController(
		//			withIdentifier: "MessageViewController") as? MessageViewController
	}
	
	@objc func didTapModifyButton(_ sender: UIButton) {
		let viewcontroller = AppointmentViewController()
		viewcontroller.issue_id = self.requestId
		viewcontroller.checkToModify = self.checkToModify
		rootViewController?.navigationController?.pushViewController(viewcontroller, animated: true)
	}
}

