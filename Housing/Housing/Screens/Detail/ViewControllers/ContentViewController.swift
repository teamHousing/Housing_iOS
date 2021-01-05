//
//  ContentViewController.swift
//  Housing
//
//  Created by 노한솔 on 2021/01/04.
//

import UIKit

import SegementSlide
import Then
import SnapKit


class ContentViewController: UIViewController, SegementSlideContentScrollViewDelegate{
	
	let detailView = UIScrollView().then{
		$0.isScrollEnabled = true
	}
	
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
	
	func layout() {
		self.view.add(detailView){
			$0.snp.makeConstraints{
				$0.top.equalTo(self.view.snp.top).offset(0)
				$0.bottom.equalTo(self.view.snp.bottom).offset(0)
				$0.leading.equalTo(self.view.snp.trailing).offset(0)
				$0.trailing.equalTo(self.view.snp.trailing).offset(0)
			}
		}
		self.detailView.add(titleLabel){
			$0.snp.makeConstraints{
				$0.top.equalTo(self.detailView.snp.top).offset(52)
				$0.leading.equalTo(self.detailView.snp.leading).offset(39)
			}
		}
		self.detailView.add(contextLabel){
			$0.snp.makeConstraints{
				$0.top.equalTo(self.titleLabel.snp.bottom).offset(12)
				$0.leading.equalTo(self.detailView.snp.leading).offset(20)
			}
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.layout()
		self.detailView.delegate = self
	}
}

extension ContentViewController: UIScrollViewDelegate{
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		if (scrollView.contentOffset.y == (scrollView.contentSize.height
																				- scrollView.bounds.size.height)) {
			
		}
	}
}



//class ContentViewController: UITableViewController, SegementSlideContentScrollViewDelegate {
//	@objc var scrollView: UIScrollView {
//		return tableView
//	}
//
//	func registerCell() {
//		tableView.register(RequestTableViewCell.self, forCellReuseIdentifier: RequestTableViewCell.reuseIdentifier)
//		tableView.register(CommunicateMethodTableViewCell.self, forCellReuseIdentifier: CommunicateMethodTableViewCell.reuseIdentifier)
//		tableView.register(AddedImageTableViewCell.self, forCellReuseIdentifier: AddedImageTableViewCell.reuseIdentifier)
//	}
//
//	override func viewDidLoad() {
//		super.viewDidLoad()
//		tableView.rowHeight = UITableView.automaticDimension
//		tableView.estimatedRowHeight = RequestTableViewCell.estimatedRowHeight() + CommunicateMethodTableViewCell.estimatedRowHeight() + AddedImageTableViewCell.estimatedRowHeight()
//		registerCell()
//		print(tableView.estimatedRowHeight)
//		self.reloadInputViews()
//	}
//
//	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////		if indexPath.row == 0 {
////			let cell: RequestTableViewCell = tableView.dequeueCell(forIndexPath: indexPath)
////			return cell
////		}
////		else if indexPath.row == 1{
////			let cell: CommunicateMethodTableViewCell = tableView.dequeueCell(forIndexPath: indexPath)
////			return cell
////		}
////		else {
////			let cell: AddedImageTableViewCell = tableView.dequeueCell(forIndexPath: indexPath)
////			return cell
////		}
//		guard let cell = tableView.dequeueReusableCell(withIdentifier: RequestTableViewCell.reuseIdentifier)
//						as? RequestTableViewCell else {return UITableViewCell()}
//		return cell
//	}
//
//	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//		return 3
//	}
//}
//

