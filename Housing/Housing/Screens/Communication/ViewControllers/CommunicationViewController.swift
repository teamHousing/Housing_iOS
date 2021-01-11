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

	//MARK: - Property
	
	var incompleteLength = 2
	var completeLength = 3
	var mode = 1 // 집주인이 0, 자취생이 1
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
	
	//detailCellData.count
	override func viewDidLoad() {
		super.viewDidLoad()
		tableViewData = [cellData(opened: true,
															title: "fixing",
															sectionData: incomDetailCellData), // incomplete
										 cellData(opened: true,
															title: "fixed",
															sectionData: comDetailCellData)] // complete

		configTableView()
		configHeaderView()
		
	}
	
	private func configTableView() {
		communicationTableView.dataSource = self
		communicationTableView.delegate = self
	}
	
	private func configHeaderView() {
		headerView.setRounded(radius: 15)
		headerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
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

extension CommunicationViewController: UITableViewDelegate { // 이게 cell이 아니라 button에 반응하도록 해야함.
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		//let selectedIndexPath = tableView.indexPathForSelectedRow
		
		if indexPath.row == 0 {
			if tableViewData[indexPath.section].opened == true{
				tableViewData[indexPath.section].opened = false
				communicationTableView.backgroundColor = .primaryGray
				let sections = IndexSet(integer: indexPath.section)
				tableView.reloadSections(sections, with: .none) //animaion
				
			}else {
				tableViewData[indexPath.section].opened = true
				communicationTableView.backgroundColor = .primaryGray
				let sections = IndexSet(integer: indexPath.section)
				tableView.reloadSections(sections, with: .none) //animaion
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
		if indexPath.row == 0{ // title의 높이 지정.
			if indexPath.section == 0 {
				if mode == 0{
					return 90
				}else if mode == 1{
					return 70
				}
			} else if indexPath.section == 1{
				return 70
			}
		} else if indexPath.row == 1 { //cell의 높이 지정
				if incompleteLength == 0 && indexPath.section == 0{
					if completeLength > 0 {
						return 180
					}
					return 230 // 수리중 emptyCell의 높이 지정.
				} else if incompleteLength != 0 && indexPath.section == 0 ||
										completeLength != 0 && indexPath.section == 1 {
					return 180 // 수리중 contentCell의 높이 지정.
				}
				else if completeLength == 0 && indexPath.section == 1{
					return 180 // 수리완료 emptyCell의 높이 지정.
				}
			}
			return 180
		}
	
	func tableView(_ tableView: UITableView,
								 numberOfRowsInSection section: Int) -> Int {
		if tableViewData[section].opened == true {
			if section == 0 { //글의 수만큼 보여주기.
				if incompleteLength == 0 { //incomplete부분은 아무것도 없으면 Empty보여줘야됨.
					return 2
				}
				return incompleteLength + 1
			}
			else if section == 1 {
				if incompleteLength > 0 && completeLength == 0 {
					return 2 // income은 있는데, com이 없는 경우에도 com부분에 empty보여줘야됨.
				}
				return completeLength + 1
			}
		}
		return 1
	}
	
	
	func tableView(_ tableView: UITableView,
								 cellForRowAt indexPath: IndexPath) -> UITableViewCell { //title부분에 쓸 cell
		guard let incomCell = tableView.dequeueReusableCell(withIdentifier: "IncompleteTableViewCell") as? IncompleteTableViewCell
		else { return UITableViewCell() }
		incomCell.contentView.backgroundColor = UIColor(named: "paleGrey")
		incomCell.makeViewRounded()
		incomCell.countOfIncomplete.text = "(\(incompleteLength))"
		//incomCell.incomButton.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
		
		if mode == 1 {
			incomCell.roomNumberView.isHidden = true
		} else {
			incomCell.roomNumberView.isHidden = false
		}
		
		guard let comCell = tableView.dequeueReusableCell(withIdentifier: "CompleteTableViewCell") as? CompleteTableViewCell
		else { return UITableViewCell()}
		comCell.countOfComplete.text = "(\(completeLength))"
		comCell.contentView.backgroundColor = UIColor(named: "paleGrey")
		
		//row부분에 쓸 cell
		guard let emptyIncomCell = tableView.dequeueReusableCell(withIdentifier: "emptyIncomTableViewCell") as? EmptyIncomTableViewCell
		else { return UITableViewCell()}
		emptyIncomCell.contentView.backgroundColor = UIColor(named: "paleGrey")
		emptyIncomCell.makeButtonRounded()
		
		guard let emptyComCell = tableView.dequeueReusableCell(withIdentifier: "emptyComTableViewCell") as? EmptyComTableViewCell
		else { return UITableViewCell()}
		emptyComCell.contentView.backgroundColor = UIColor(named: "paleGrey")
		
		guard let contentCell = tableView.dequeueReusableCell(withIdentifier: "ContentTableViewCell") as? ContentTableViewCell
		else { return UITableViewCell() }
		
		contentCell.makeViewRounded()
		contentCell.contentView.backgroundColor = UIColor(named: "paleGrey")
		
		guard let emptyCell = tableView.dequeueReusableCell(withIdentifier: "RealEmptyTableViewCell") as? RealEmptyTableViewCell
		else { return UITableViewCell() }
		//let incomcell : IncompleteTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
		//let comcell : CompleteTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
		emptyCell.contentView.backgroundColor = UIColor(named: "paleGrey")
		
		if indexPath.row == 0 { //여기가 title 부분. // 완료된 것이 없을 때는 title이 뜨지 않도록 했음.
			if incompleteLength == 0 && completeLength == 0 {
				if indexPath.section == 0 {
					incomCell.roomNumberView.isHidden = true
					return incomCell
				}
				if indexPath.section == 1 {
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
		} else { //여기가 내부 cell 부분.
			if incompleteLength == 0 && completeLength == 0 {
				if indexPath.section == 0 {
					if mode == 0 {
						emptyIncomCell.emptyLabel.text = "자취생을 초대해 볼까요?" // 이거 왜 안되지? newline이 들어가면 안되네.. 왜지
						emptyIncomCell.inquiryButton.titleLabel?.text = "초대하기"
					} else {
						emptyIncomCell.emptyLabel.text = "집주인과 소통을 시작해볼까요?"
						emptyIncomCell.inquiryButton.titleLabel?.text = "문의하기"
					}
					
					return emptyIncomCell
				}
				if indexPath.section == 1 {
					return UITableViewCell()
				}
			}

			else if incompleteLength == 0 && completeLength > 0 {
				if indexPath.section == 0 {
						emptyIncomCell.emptyLabel.text = "모든 문의가 해결되었어요!" // 이거 왜 안되지? newline이 들어가면 안되네.. 왜지
						emptyIncomCell.inquiryButton.isHidden = true
					return emptyIncomCell
				}
				if indexPath.section == 1 {
					return contentCell
				}
			}
			else if incompleteLength > 0 && completeLength == 0 {
				if indexPath.section == 0 {
					contentCell.categoryLabel.text = tableViewData[indexPath.section].sectionData[indexPath.row-1].category
					contentCell.titleLabel.text = tableViewData[indexPath.section].sectionData[indexPath.row-1].issueTitle
					contentCell.contentLabel.text = tableViewData[indexPath.section].sectionData[indexPath.row-1].issueContents
					contentCell.statusLabel.text = determineProgress(progress: tableViewData[indexPath.section].sectionData[indexPath.row-1].progress)
					return contentCell
				}
				if indexPath.section == 1 {
					emptyComCell.emptyLabel.text = "아직 해결 완료된 문의가 없어요!"
					return emptyComCell
				}
			}
			else if incompleteLength > 0 && completeLength > 0 {
				if indexPath.section == 0 {
					contentCell.categoryLabel.text = tableViewData[indexPath.section].sectionData[indexPath.row-1].category
					contentCell.titleLabel.text = tableViewData[indexPath.section].sectionData[indexPath.row-1].issueTitle
					contentCell.contentLabel.text = tableViewData[indexPath.section].sectionData[indexPath.row-1].issueContents
					contentCell.statusLabel.text = determineProgress(progress: tableViewData[indexPath.section].sectionData[indexPath.row-1].progress)
					return contentCell
				}
				if indexPath.section == 1 {
					contentCell.categoryLabel.text = tableViewData[indexPath.section].sectionData[indexPath.row-1].category
					contentCell.titleLabel.text = tableViewData[indexPath.section].sectionData[indexPath.row-1].issueTitle
					contentCell.contentLabel.text = tableViewData[indexPath.section].sectionData[indexPath.row-1].issueContents
					contentCell.statusLabel.text = determineProgress(progress: tableViewData[indexPath.section].sectionData[indexPath.row-1].progress)
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
