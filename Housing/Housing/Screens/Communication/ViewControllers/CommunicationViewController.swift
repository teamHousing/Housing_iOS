//
//  CommunicationViewController.swift
//  Housing
//
//  Created by 김주은 on 2021/01/01.
//

import UIKit

struct cellData{
	var opened = Bool()
	var title = String()
	var sectionData = [DetailData]()
}

struct DetailData {
	var category = String()
	var issueTitle = String()
	var progress = Int()
	var issueContents = String()
}

final class CommunicationViewController: UIViewController {
	
	//MARK: - Component
	
	@IBOutlet var communicationTableView: UITableView!
	@IBOutlet var headerView: UIView!
	lazy var shareButton = UIBarButtonItem(image: UIImage(named: "iconShare"),
																				 style: .done,
																				 target: self,
																				 action: #selector(settingButtonDidTap))
	
	//MARK: - Property
	
	var incompleteLength = 0
	var completeLength = 1
	var mode = 1// 집주인이 0, 자취생이 1
	private var tableViewData = [cellData]()
	private var incomDetailCellData = [
		DetailData(category: "고장/수리1",
							 issueTitle: "incom111",
							 progress: 1,
							 issueContents: "집도 좋고 늘 빠르게 소통해주셔서 2년간 굉장히 만족하면서 생활했어요. 계약 만료 기간이 끝나 가는데 다시 재계..."),
		DetailData(category: "고장/수리2",
							 issueTitle: "incom222",
							 progress: 0,
							 issueContents: "집도 좋고 늘 빠르게 소통해주셔서 2년간 굉장히 만족하면서 생활했어요. 계약 만료 기간이 끝나 가는데 다시 재계..."),
		DetailData(category: "고장/수리3 ",
							 issueTitle: "incom333",
							 progress: 1,
							 issueContents: "집도 좋고 늘 빠르게 소통해주셔서 2년간 굉장히 만족하면서 생활했어요. 계약 만료 기간이 끝나 가는데 다시 재계...")]
	
	private var comDetailCellData = [
		DetailData(category: "고장/수리1",
							 issueTitle: "com111",
							 progress: 2,
							 issueContents: "집도 좋고 늘 빠르게 소통해주셔서 2년간 굉장히 만족하면서 생활했어요. 계약 만료 기간이 끝나 가는데 다시 재계..."),
		DetailData(category: "고장/수리2",
							 issueTitle: "com222",
							 progress: 2,
							 issueContents: "집도 좋고 늘 빠르게 소통해주셔서 2년간 굉장히 만족하면서 생활했어요. 계약 만료 기간이 끝나 가는데 다시 재계..."),
		DetailData(category: "고장/수리3 ",
							 issueTitle: "com333",
							 progress: 2,
							 issueContents: "집도 좋고 늘 빠르게 소통해주셔서 2년간 굉장히 만족하면서 생활했어요. 계약 만료 기간이 끝나 가는데 다시 재계...")]
	
	// MARK : - LifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()
		tableViewData = [cellData(opened: true,
															title: "fixing",
															sectionData: incomDetailCellData), /// incomplete
										 cellData(opened: true,
															title: "fixed",
															sectionData: comDetailCellData)] /// complete
		configTableView()
		configHeaderView()
		layoutNavigationBar()
	}
	
	enum cases { // case문으로 하면 좋을텐데
		 case incom0com0
		 case incom0com1
		 case incom1com0
		 case incom1com1
 }
	private func determineCase(){
	}
	
	private func configTableView() {
		communicationTableView.dataSource = self
		communicationTableView.delegate = self
	}
	
	private func configHeaderView() {
		headerView.setRounded(radius: 15)
		headerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
	}
	
	private func layoutNavigationBar() {
		navigationItem.rightBarButtonItem = shareButton
		navigationController?.navigationBar.shadowImage = UIImage()
		navigationController?.navigationBar.isTranslucent = false
		navigationController?.navigationBar.tintColor = .black
	}
	private func makeCellGrey(cell : UITableViewCell){
		cell.contentView.backgroundColor = UIColor(named: "paleGrey")
	}
	//	@objc func handleExpandClose() {
	//		print("trying") //여기서 막 열리고 닫히고 관련한 action을 넣으면 됨.
	//		let section = incomButton.tag
	//
	//		// we'll try to close the section first by deleting the rows
	//		var indexPaths = [IndexPath]()
	//		for row in tableViewData[section].sectionData.indices {
	//				print(0, row)
	//				let indexPath = IndexPath(row: row, section: section)
	//				indexPaths.append(indexPath)
	//		}
	//
	//		let opened = tableViewData[section].opened
	//		tableViewData[section].opened = !opened
	//
	//		incomButton.setTitle(opened ? "Open" : "Close", for: .normal)
	//
	//		if opened {
	//			communicationTableView.deleteRows(at: indexPaths, with: .fade)
	//		} else {
	//			communicationTableView.insertRows(at: indexPaths, with: .fade)
	//		}
	//	}
	@objc
	private func settingButtonDidTap() {
		print(#function)
	}
	
	func determineProgress(progress: Int) -> String {
		if progress == 0{
			return "확인전"
		} else if progress == 1{
			return "확인중"
		} else if progress == 2{
			return "확인완료"
		}
		return ""
	}
}

// MARK: - UITableView

extension CommunicationViewController: UITableViewDelegate { /// 이게 cell이 아니라 button에 반응하도록 해야함.
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		//let selectedIndexPath = tableView.indexPathForSelectedRow
		
		if indexPath.row == 0 {
			if tableViewData[indexPath.section].opened == true{
				tableViewData[indexPath.section].opened = false
				communicationTableView.backgroundColor = .primaryGray
				let sections = IndexSet(integer: indexPath.section)
				tableView.reloadSections(sections, with: .none) ///animaion
				
			}else {
				tableViewData[indexPath.section].opened = true
				communicationTableView.backgroundColor = .primaryGray
				let sections = IndexSet(integer: indexPath.section)
				tableView.reloadSections(sections, with: .none) ///animaion
			}
		} else {
			let viewController = DetailViewController()
			navigationController?.pushViewController(viewController, animated: true)
		}
	}
}

extension CommunicationViewController: UITableViewDataSource{
	
	func numberOfSections(in tableView: UITableView) -> Int {
		tableViewData.count
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.row == 0{ /// title의 높이 지정.
			if indexPath.section == 0 {
				if mode == 0{
					return 80 ///호수 선택하는 버튼 들어가야됨.
				} else if mode == 1{
					return 70
				}
			} else if indexPath.section == 1{
				return 70
			}
		} else if indexPath.row > 0 { ///cell의 높이 지정
			if incompleteLength == 0 && completeLength == 0{ ///incom에만 empty
				if indexPath.section == 0 {
					return 250 //with button
				} else {
					return 0
				}
			}else if incompleteLength == 0 && completeLength > 0{
				if indexPath.section == 0 {
					return 230 // without button
				} else {
					return 180 //contentcell의 높이
				}
			} else if incompleteLength > 0 && completeLength == 0{
				if indexPath.section == 0 {
					return 180 //contentcell의 높이
				} else {
					return 230 // emptycomcell의 높이
				}
			} else if incompleteLength > 0 && completeLength > 0{
				return 180 //contentcell의 높이
			}}
		return 180}
	
	func tableView(_ tableView: UITableView,
								 numberOfRowsInSection section: Int) -> Int {
		if tableViewData[section].opened == true {
			if section == 0 { ///글의 수만큼 보여주기.
				if incompleteLength == 0 { ///incomplete부분은 아무것도 없으면 EmptyCell보여줘야됨.
					return 2
				}
				return incompleteLength + 1
			}
			else if section == 1 {
				if incompleteLength > 0 && completeLength == 0 {
					return 2 /// income은 있는데, com이 없는 경우에도 com부분에 empty보여줘야됨.
				}
				return completeLength + 1
			}
		}
		return 1
	}
	
	
	func tableView(_ tableView: UITableView,
								 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		///title부분에 쓸 cell
		guard let incomCell = tableView.dequeueReusableCell(withIdentifier: "IncompleteTableViewCell")
						as? IncompleteTableViewCell
		else { return UITableViewCell() }
		incomCell.contentView.backgroundColor = UIColor(named: "paleGrey")
		incomCell.makeViewRounded()
		incomCell.countOfIncomplete.text = "(\(incompleteLength))"
		///incomCell.incomButton.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
		
		if mode == 1 {
			incomCell.roomNumberView.isHidden = true
		} else {
			incomCell.roomNumberView.isHidden = false
		}
		
		guard let comCell = tableView.dequeueReusableCell(withIdentifier: "CompleteTableViewCell")
						as? CompleteTableViewCell
		else { return UITableViewCell()}
		comCell.countOfComplete.text = "(\(completeLength))"
		makeCellGrey(cell: comCell)
		
		///cell부분에 쓸 cell
		guard let emptyIncomCell = tableView.dequeueReusableCell(withIdentifier: "emptyIncomTableViewCell")
						as? EmptyIncomTableViewCell
		else { return UITableViewCell()}
		emptyIncomCell.emptyLabel.numberOfLines = 2
		makeCellGrey(cell: emptyIncomCell)
		emptyIncomCell.emptyLabel.textAlignment = .center
		emptyIncomCell.makeButtonRounded()
		
		guard let emptyComCell = tableView.dequeueReusableCell(withIdentifier: "emptyComTableViewCell")
						as? EmptyComTableViewCell
		else { return UITableViewCell()}
		emptyComCell.emptyLabel.numberOfLines = 2
		makeCellGrey(cell: emptyComCell)
		
		guard let contentCell = tableView.dequeueReusableCell(withIdentifier: "ContentTableViewCell")
						as? ContentTableViewCell
		else { return UITableViewCell() }
		contentCell.makeViewRounded()
		makeCellGrey(cell: contentCell)
		
		guard let emptyCell = tableView.dequeueReusableCell(withIdentifier: "RealEmptyTableViewCell")
						as? RealEmptyTableViewCell
		else { return UITableViewCell() }
		///let incomcell : IncompleteTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
		///let comcell : CompleteTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
		makeCellGrey(cell: emptyCell)
	
		if indexPath.row == 0 { ///여기가 title 부분. /// 완료된 것이 없을 때는 title이 뜨지 않도록 했음.
			if incompleteLength == 0 && completeLength == 0 {
				if indexPath.section == 0 {
					return incomCell
				} else if indexPath.section == 1 {
					return emptyCell
				}
			} else {
				if indexPath.section == 0 {
					return incomCell
				}
				if indexPath.section == 1 {
					return comCell
				}
			}
		} else{  ///여기가 내부 cell 부분.
			if incompleteLength == 0 && completeLength == 0{
				if indexPath.section == 0{ ///cell중에서도 incomplete부분.
					if mode == 0{
					emptyIncomCell.emptyLabel.text = "등록된 문의 사항이 없어요!\n자취생을 초대해 볼까요?"
						emptyIncomCell.inquiryButton.setTitle("초대하기", for: .normal)
					} else{
						emptyIncomCell.emptyLabel.text = "등록된 문의 사항이 없어요!\n집주인과 소통을 시작해볼까요?"
							emptyIncomCell.inquiryButton.setTitle("문의하기", for: .normal)
					}
					return emptyIncomCell
				} else { ///cell중에서도 complete부분
					return emptyCell
				}
			} else if incompleteLength == 0 && completeLength > 0{
				if indexPath.section == 0{ ///cell중에서도 incomplete부분.
					emptyIncomCell.inquiryButton.isHidden = true
					emptyIncomCell.emptyLabel.text = "모든 문의가 해결되었어요!"
					return emptyIncomCell
				} else { ///cell중에서도 complete부분
					contentCell.contentData = tableViewData[indexPath.section].sectionData[indexPath.row-1]
						contentCell.filloutCell()
					return contentCell
				}
			} else if incompleteLength > 0 && completeLength == 0{
				if indexPath.section == 0{ ///cell중에서도 incomplete부분.
					contentCell.contentData = tableViewData[indexPath.section].sectionData[indexPath.row-1]
						contentCell.filloutCell()
					return contentCell
				} else { ///cell중에서도 complete부분
					return emptyComCell
				}
			} else if incompleteLength > 0 && completeLength > 0{
				if indexPath.section == 0{ ///cell중에서도 incomplete부분.
					contentCell.contentData = tableViewData[indexPath.section].sectionData[indexPath.row-1]
						contentCell.filloutCell()
					return contentCell
				} else { ///cell중에서도 complete부분
					contentCell.contentData = tableViewData[indexPath.section].sectionData[indexPath.row-1]
						contentCell.filloutCell()
					return contentCell
				}
			}
		}
		return UITableViewCell()
	}
}

extension CommunicationViewController: UIScrollViewDelegate{
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		
		if scrollView.contentOffset.y < -1 {
			communicationTableView.backgroundColor = .white
		} else if scrollView.contentOffset.y >= -1 {
			communicationTableView.backgroundColor = .primaryGray }
	}
}
