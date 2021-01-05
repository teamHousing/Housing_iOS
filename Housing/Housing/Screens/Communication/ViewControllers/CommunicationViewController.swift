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
	var title = String()
	var status = String()
	var content = String()
}

class CommunicationViewController: UIViewController {
	
	//MARK: COMPONENT
	@IBOutlet var communicationTableView: UITableView!
	
	//MARK: Property
	static var thecell = "cell"
	static var content = 1 //이거 서버에서 받아서 count쓸거임! 그냥 더미이니 신경쓰지 말 것!
	var tableViewData = [cellData]()
	var detailCellData = [DetailData(category: "고장/수리1", title: "1111111111111111111111", status: "확인중", content: "집도 좋고 늘 빠르게 소통해주셔서 2년간 굉장히 만족하면서 생활했어요. 계약 만료 기간이 끝나 가는데 다시 재계..."),DetailData(category: "고장/수리2", title: "22222222222222222", status: "확인중", content: "집도 좋고 늘 빠르게 소통해주셔서 2년간 굉장히 만족하면서 생활했어요. 계약 만료 기간이 끝나 가는데 다시 재계..."),DetailData(category: "고장/수리3 ", title: "3333333333333333333", status: "확인중", content: "집도 좋고 늘 빠르게 소통해주셔서 2년간 굉장히 만족하면서 생활했어요. 계약 만료 기간이 끝나 가는데 다시 재계...")]
	//detailCellData.count
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableViewData = [cellData(opened: true, title: "fixing", sectionData: detailCellData),
										 cellData(opened: false, title: "fixed", sectionData: detailCellData)]
		print(tableViewData)
		

		communicationTableView.delegate = self
		communicationTableView.dataSource = self
		self.navigationController?.isNavigationBarHidden = true
		communicationTableView.register(ContentTableViewCell.self, forCellReuseIdentifier: ContentTableViewCell.reuseIdentifier)
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
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 70
	}
}


extension CommunicationViewController: UITableViewDataSource{
	func numberOfSections(in tableView: UITableView) -> Int {
		tableViewData.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if tableViewData[section].opened == true {
			return tableViewData[section].sectionData.count + 1
		} else{
			return 1
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.row == 0{
			guard let cell = tableView.dequeueReusableCell(withIdentifier: "fixingCell")//TitleTableViewCell.reuseIdentifier
			else { return UITableViewCell()}
			print(tableViewData)
			if tableViewData[indexPath.section].title == "fixing"{
				cell.textLabel?.text = "고치는 중"
			}
			if tableViewData[indexPath.section].title == "fixed" {
				cell.textLabel?.text = "수리완료"
			}
			
			
			return cell
		}
		else {
			
			if CommunicationViewController.content == 0 {
				guard let cell = tableView.dequeueReusableCell(withIdentifier: "emptyCell")//EmptyTableViewCell.reuseIdentifier
				else { return UITableViewCell()}
				return cell
			}
			
			else {
				guard let cell = tableView.dequeueReusableCell(withIdentifier: "contentCell")as? ContentTableViewCell //EmptyTableViewCell.reuseIdentifier
				else {return UITableViewCell()}
				//let cell:ContentTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
				
				print("여기로우", indexPath.row)
				print("여기섹션", indexPath.section)
				cell.cellData = detailCellData[indexPath.row-1]
				cell.makeCell()
				return cell
				
			}
		}
	}
}


