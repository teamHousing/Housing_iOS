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
	
	//MARK: Property
	static var determineHeader = 175.0
	static var thecell = "cell"
	static var incompleteLength = 0
	static var completeLength = 2
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
										 cellData(opened: false, title: "fixed", sectionData: comDetailCellData)] // complete
		print(tableViewData)
		
		communicationTableView.dataSource = self
		communicationTableView.delegate = self
		
		self.navigationController?.isNavigationBarHidden = true
		//		communicationTableView.register(ContentTableViewCell.self, forCellReuseIdentifier: ContentTableViewCell.reuseIdentifier)
		//let nib = UINib(nibName: "ReContentTableViewCell", bundle: nil)
		//communicationTableView.register(nib, forCellReuseIdentifier: ReContentTableViewCell.reuseIdentifier)
		communicationTableView.headerView(forSection: 0)
	}
	
	
}

extension CommunicationViewController: UITableViewDelegate{
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let view = UIView()
		return view
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		if section == 0 {
			return 169
		} else {
			return 0
		}
	}
	
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
		}
		else if section == 1 {
			return CommunicationViewController.completeLength + 1
		}
	return 1
	}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
	//title부분에 쓸 cell
	guard let incomCell = tableView.dequeueReusableCell(withIdentifier: "IncompleteTableViewCell") as? IncompleteTableViewCell
	else { return UITableViewCell()}
	
	guard let comCell = tableView.dequeueReusableCell(withIdentifier: "CompleteTableViewCell") as? CompleteTableViewCell
	else { return UITableViewCell()}
	//row부분에 쓸 cell
	guard let emptyCell = tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell") as? EmptyTableViewCell
	else { return UITableViewCell()}
	
	guard let contentCell = tableView.dequeueReusableCell(withIdentifier: "ContentTableViewCell") as? ContentTableViewCell else { return UITableViewCell() }
	
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
				return emptyCell
			}
			if indexPath.section == 1{
				return UITableViewCell()
			}
		}
		else if CommunicationViewController.incompleteLength == 0 && CommunicationViewController.completeLength > 0{
			if indexPath.section == 0{
				return emptyCell
			}
			if indexPath.section == 1{
				contentCell.categoryLabel.text = tableViewData[indexPath.section].sectionData[indexPath.row-1].category
				contentCell.titleLabel.text = tableViewData[0].sectionData[indexPath.row-1].issueTitle
				contentCell.contentLabel.text = tableViewData[indexPath.section].sectionData[indexPath.row-1].issueContents
				contentCell.statusLabel.text = String(tableViewData[indexPath.section].sectionData[indexPath.row-1].progress)
				return contentCell
			}
		}
		else if CommunicationViewController.incompleteLength > 0 && CommunicationViewController.completeLength == 0{
			if indexPath.section == 0{
				contentCell.categoryLabel.text = tableViewData[indexPath.section].sectionData[indexPath.row-1].category
				contentCell.titleLabel.text = tableViewData[indexPath.section].sectionData[indexPath.row-1].issueTitle
				contentCell.contentLabel.text = tableViewData[indexPath.section].sectionData[indexPath.row-1].issueContents
				contentCell.statusLabel.text = String(tableViewData[indexPath.section].sectionData[indexPath.row-1].progress)
				return contentCell
			}
			if indexPath.section == 1{
				return emptyCell
			}
		}
		else if CommunicationViewController.incompleteLength > 0 && CommunicationViewController.completeLength > 0{
			if indexPath.section == 0{
				contentCell.categoryLabel.text = tableViewData[indexPath.section].sectionData[indexPath.row-1].category
				contentCell.titleLabel.text = tableViewData[indexPath.section].sectionData[indexPath.row-1].issueTitle
				contentCell.contentLabel.text = tableViewData[indexPath.section].sectionData[indexPath.row-1].issueContents
				contentCell.statusLabel.text = String(tableViewData[indexPath.section].sectionData[indexPath.row-1].progress)
				return contentCell
			}
			if indexPath.section == 1{
				print("hereheree", indexPath.row)
				contentCell.categoryLabel.text = tableViewData[indexPath.section].sectionData[indexPath.row-1].category
				contentCell.titleLabel.text = tableViewData[indexPath.section].sectionData[indexPath.row-1].issueTitle
				contentCell.contentLabel.text = tableViewData[indexPath.section].sectionData[indexPath.row-1].issueContents
				contentCell.statusLabel.text = String(tableViewData[indexPath.section].sectionData[indexPath.row-1].progress)
				return contentCell
			}
		}
	}
	return UITableViewCell()
}
}
