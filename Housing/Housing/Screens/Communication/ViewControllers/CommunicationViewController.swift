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

class CommunicationViewController: UIViewController {
	
	//MARK: COMPONENT
	@IBOutlet var communicationTableView: UITableView!
	@IBOutlet var headerView: UIView!
	

	//MARK: Property
	static var determineHeader = 175.0
	static var thecell = "cell"
	static var incompleteLength = 3
	static var completeLength = 0
	var tableViewData = [cellData]()
	var incomDetailCellData = [
		DetailData(category: "고장/수리1", issueTitle: "incom111", progress: 1, issueContents: "집도 좋고 늘 빠르게 소통해주셔서 2년간 굉장히 만족하면서 생활했어요. 계약 만료 기간이 끝나 가는데 다시 재계..."),
		DetailData(category: "고장/수리2", issueTitle: "incom222", progress: 0, issueContents: "집도 좋고 늘 빠르게 소통해주셔서 2년간 굉장히 만족하면서 생활했어요. 계약 만료 기간이 끝나 가는데 다시 재계..."),
		DetailData(category: "고장/수리3 ", issueTitle: "incom333", progress: 1, issueContents: "집도 좋고 늘 빠르게 소통해주셔서 2년간 굉장히 만족하면서 생활했어요. 계약 만료 기간이 끝나 가는데 다시 재계...")]
	var comDetailCellData = [
		DetailData(category: "고장/수리1", issueTitle: "com111", progress: 2, issueContents: "집도 좋고 늘 빠르게 소통해주셔서 2년간 굉장히 만족하면서 생활했어요. 계약 만료 기간이 끝나 가는데 다시 재계..."),
		DetailData(category: "고장/수리2", issueTitle: "com222", progress: 2, issueContents: "집도 좋고 늘 빠르게 소통해주셔서 2년간 굉장히 만족하면서 생활했어요. 계약 만료 기간이 끝나 가는데 다시 재계..."),
		DetailData(category: "고장/수리3 ", issueTitle: "com333", progress: 2, issueContents: "집도 좋고 늘 빠르게 소통해주셔서 2년간 굉장히 만족하면서 생활했어요. 계약 만료 기간이 끝나 가는데 다시 재계...")]
	
	//detailCellData.count
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableViewData = [cellData(opened: true, title: "fixing", sectionData: incomDetailCellData), // incomplete
										 cellData(opened: true, title: "fixed", sectionData: comDetailCellData)] // complete
		print(tableViewData)
		
		communicationTableView.dataSource = self
		communicationTableView.delegate = self
		headerView.setRounded(radius: 15)
		headerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
		self.navigationController?.isNavigationBarHidden = true
		
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
	
	func determineProgress(progress : Int) -> String {
		if progress == 0{
			return "확인전"
		}
		else if progress == 1{
			return "확인중"
		}
		else if progress == 2{
			return "확인완료"
		}
		return String()
	}
	
}
extension CommunicationViewController: UITableViewDelegate{ // 이게 cell이 아니라 button에 반응하도록 해야함.
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		//let selectedIndexPath = tableView.indexPathForSelectedRow
		if indexPath.row == 0 {
			if tableViewData[indexPath.section].opened == true{
				tableViewData[indexPath.section].opened = false
				let sections = IndexSet.init(integer: indexPath.section)
				tableView.reloadSections(sections, with: .none) //animaion
			}else {
				tableViewData[indexPath.section].opened = true
				let sections = IndexSet.init(integer: indexPath.section)
				tableView.reloadSections(sections, with: .none) //animaion
			}
		}
	}
}

extension CommunicationViewController: UITableViewDataSource{
	
	func numberOfSections(in tableView: UITableView) -> Int {
		tableViewData.count
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.row == 0{ // title의 높이 지정.
			return 70
		}
		else { //cell의 높이 지정
			if CommunicationViewController.incompleteLength == 0 && indexPath.section == 0{
				return 250 // 수리중 emptyCell의 높이 지정.
			}
			else if CommunicationViewController.incompleteLength != 0 && indexPath.section == 0 || CommunicationViewController.completeLength != 0 && indexPath.section == 1{
				return 169 // 수리중 contentCell의 높이 지정.
			}
			else if CommunicationViewController.completeLength == 0 && indexPath.section == 1{
				return 200 // 수리완료 emptyCell의 높이 지정.
			}
			return 150
		}
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if tableViewData[section].opened == true {
			if section == 0 { //글의 수만큼 보여주기.
				if CommunicationViewController.incompleteLength == 0 { //incomplete부분은 아무것도 없으면 Empty보여줘야됨.
					return 2
				}
				return CommunicationViewController.incompleteLength + 1  }
			else if section == 1 {
				if CommunicationViewController.incompleteLength > 0 && CommunicationViewController.completeLength == 0 {
					return 2 // income은 있는데, com이 없는 경우에도 com부분에 empty보여줘야됨.
				}
				return CommunicationViewController.completeLength + 1
			}
		}
		return 1
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { //title부분에 쓸 cell
		guard let incomCell = tableView.dequeueReusableCell(withIdentifier: "IncompleteTableViewCell") as? IncompleteTableViewCell
		else { return UITableViewCell()}
		incomCell.countOfIncomplete.text = "(" + String(CommunicationViewController.incompleteLength) + ")"
		//incomCell.incomButton.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
		
		guard let comCell = tableView.dequeueReusableCell(withIdentifier: "CompleteTableViewCell") as? CompleteTableViewCell
		else { return UITableViewCell()}
		comCell.countOfComplete.text = "(" + String(CommunicationViewController.completeLength) + ")"
		
		//row부분에 쓸 cell
		guard let emptyIncomCell = tableView.dequeueReusableCell(withIdentifier: "emptyIncomTableViewCell") as? emptyIncomTableViewCell
		else { return UITableViewCell()}
		emptyIncomCell.makeButtonRounded()
		
		guard let emptyComCell = tableView.dequeueReusableCell(withIdentifier: "emptyComTableViewCell") as? emptyComTableViewCell
		else { return UITableViewCell()}
		
		guard let contentCell = tableView.dequeueReusableCell(withIdentifier: "ContentTableViewCell") as? ContentTableViewCell else { return UITableViewCell() }
		contentCell.makeViewRounded()
		
		//let incomcell : IncompleteTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
		//let comcell : CompleteTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
		
		if indexPath.row == 0 { //여기가 title 부분. // 완료된 것이 없을 때는 title이 뜨지 않도록 했음.
			if CommunicationViewController.incompleteLength == 0 && CommunicationViewController.completeLength == 0{
				if indexPath.section == 0{
					return incomCell
				}
				if indexPath.section == 1{
					return UITableViewCell()
				}
			}
			else {
				if indexPath.section == 0{
					return incomCell
				}
				if indexPath.section == 1{
					return comCell
				}
			}
		}
		else { //여기가 내부 cell 부분.
			if CommunicationViewController.incompleteLength == 0 && CommunicationViewController.completeLength == 0{
				if indexPath.section == 0{
					return emptyIncomCell
				}
				if indexPath.section == 1{
					return UITableViewCell()
				}
			}
			else if CommunicationViewController.incompleteLength == 0 && CommunicationViewController.completeLength > 0{
				if indexPath.section == 0{
					return emptyIncomCell
				}
				if indexPath.section == 1{
					
					return contentCell
				}
			}
			else if CommunicationViewController.incompleteLength > 0 && CommunicationViewController.completeLength == 0{
				if indexPath.section == 0{
					contentCell.categoryLabel.text = tableViewData[indexPath.section].sectionData[indexPath.row-1].category
					contentCell.titleLabel.text = tableViewData[indexPath.section].sectionData[indexPath.row-1].issueTitle
					contentCell.contentLabel.text = tableViewData[indexPath.section].sectionData[indexPath.row-1].issueContents
					contentCell.statusLabel.text = determineProgress(progress: tableViewData[indexPath.section].sectionData[indexPath.row-1].progress)
					return contentCell
				}
				if indexPath.section == 1{
					return emptyComCell
				}
			}
			else if CommunicationViewController.incompleteLength > 0 && CommunicationViewController.completeLength > 0{
				if indexPath.section == 0{
					contentCell.categoryLabel.text = tableViewData[indexPath.section].sectionData[indexPath.row-1].category
					contentCell.titleLabel.text = tableViewData[indexPath.section].sectionData[indexPath.row-1].issueTitle
					contentCell.contentLabel.text = tableViewData[indexPath.section].sectionData[indexPath.row-1].issueContents
					contentCell.statusLabel.text = determineProgress(progress: tableViewData[indexPath.section].sectionData[indexPath.row-1].progress)
					return contentCell
				}
				if indexPath.section == 1{
					print("hereheree", indexPath.row)
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

