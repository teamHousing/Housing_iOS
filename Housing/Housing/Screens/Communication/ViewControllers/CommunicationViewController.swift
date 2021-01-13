//
//  CommunicationViewController.swift
//  Housing
//
//  Created by 김주은 on 2021/01/01.
//

import UIKit

import Alamofire
import Moya

struct cellData{
	var opened = Bool()
	var sectionData = [DetailData]()
}

struct DetailData {
	var id = Int()
	var issueTitle = String()
	var issueContents = String()
	var progress = Int()
	var category = Int()
}

final class CommunicationViewController: BaseViewController {
	
	//MARK: - Component
	
	@IBOutlet var communicationTableView: UITableView!
	@IBOutlet var headerView: UIView!
	lazy var shareButton = UIBarButtonItem(image: UIImage(named: "iconShare"),
																				 style: .done,
																				 target: self,
																				 action: #selector(settingButtonDidTap))
	
	//MARK: - Property
	var incompleteLength = 7
	var completeLength = 1
	var mode = 0// 집주인이 0, 자취생이 1
	private var tableViewData = [cellData]()
	private var incomDetailCellData: [DetailData] = []
		//DetailData(id: 0, issueTitle: "incom",issueContents: "incom", progress: 0, category: 0)
	
	private var comDetailCellData: [DetailData] = []
		//DetailData(id: 0, issueTitle: "com",issueContents: "com", progress: 0, category: 1)
	
	// MARK : - LifeCycle
	override func viewDidLoad() {
		networkForCommunication()
		//testArray()
		super.viewDidLoad()
		
		tableViewData = [cellData(opened: true,
															sectionData: incomDetailCellData), /// incomplete
										 cellData(opened: true,
															sectionData: comDetailCellData)] /// complete
		configHeaderView()
		
		layoutNavigationBar()
		configTableView()
	}
	
	private let userProvider = MoyaProvider<CommunicationService>(plugins: [NetworkLoggerPlugin(verbose: true)])
	
	enum cases { // case문으로 하면 좋을텐데
		case incom0com0
		case incom0com1
		case incom1com0
		case incom1com1
	}
	private func testArray() {
		var listdata = DetailData(id: 0, issueTitle: "0000", issueContents: "0000", progress: 0, category: 0)
		self.incomDetailCellData.append(listdata)
		listdata = DetailData(id: 1, issueTitle: "1111", issueContents: "1111", progress: 2, category: 2)
		self.incomDetailCellData.append(listdata)
		listdata = DetailData(id: 2, issueTitle: "2222", issueContents: "2222", progress: 2, category: 2)
		self.incomDetailCellData.append(listdata)
		listdata = DetailData(id: 3, issueTitle: "3333", issueContents: "3333", progress: 2, category: 4)
		self.incomDetailCellData.append(listdata)
		listdata = DetailData(id: 4, issueTitle: "4444", issueContents: "4444", progress: 2, category: 4)
		self.incomDetailCellData.append(listdata)
		listdata = DetailData(id: 5, issueTitle: "5555", issueContents: "5555", progress: 2, category: 4)
		self.incomDetailCellData.append(listdata)
		listdata = DetailData(id: 6, issueTitle: "6666", issueContents: "6666", progress: 2, category: 4)
		self.incomDetailCellData.append(listdata)
		listdata = DetailData(id: 7, issueTitle: "7777", issueContents: "7777", progress: 2, category: 4)
		self.comDetailCellData.append(listdata)
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
	
	private func makeCellGrey(cell : UITableViewCell) {
		cell.contentView.backgroundColor = UIColor(named: "paleGrey")
	}
	
	private func networkForCommunication() {
		//let semaphore = DispatchSemaphore.init(value: 0)
		print("통신시작")
		userProvider.rx.request(.home(unit: "-1"))
			.asObservable()
			.subscribe(onNext: { response in
				if response.statusCode == 200{
					do {
						let decoder = JSONDecoder()
						let data = try decoder.decode(ResponseType<Communication>.self,
																					from: response.data)
						guard let result = data.data else {return}
						self.completeLength = result.completeLength
						self.incompleteLength = result.incompleteLength
						print("incompleteLength: \(self.incompleteLength)")
						print("completeLength: \(self.completeLength)")
						
						
//						var listdata = DetailData(id: 0, issueTitle: "0000", issueContents: "0000", progress: 0, category: 0)
//						self.incomDetailCellData.append(listdata)
//						listdata = DetailData(id: 1, issueTitle: "1111", issueContents: "1111", progress: 2, category: 2)
//						self.incomDetailCellData.append(listdata)
//						listdata = DetailData(id: 2, issueTitle: "2222", issueContents: "2222", progress: 2, category: 2)
//						self.incomDetailCellData.append(listdata)
//						listdata = DetailData(id: 3, issueTitle: "3333", issueContents: "3333", progress: 2, category: 4)
//						self.incomDetailCellData.append(listdata)
//						listdata = DetailData(id: 4, issueTitle: "4444", issueContents: "4444", progress: 2, category: 4)
//						self.incomDetailCellData.append(listdata)
//						listdata = DetailData(id: 5, issueTitle: "5555", issueContents: "5555", progress: 2, category: 4)
//						self.incomDetailCellData.append(listdata)
//						listdata = DetailData(id: 6, issueTitle: "6666", issueContents: "6666", progress: 2, category: 4)
//						self.incomDetailCellData.append(listdata)
//
//						listdata = DetailData(id: 7, issueTitle: "7777", issueContents: "7777", progress: 2, category: 4)
//						self.comDetailCellData.append(listdata)
						//semaphore.signal()//네트워킹이 끝나면 신호보내기
						
						
						for index in 0..<result.incompleteList.count {
							let listdata = DetailData(id: result.incompleteList[index].id, issueTitle: result.incompleteList[index].issueTitle, issueContents: result.incompleteList[index].issueContents, progress: result.incompleteList[index].progress, category: result.incompleteList[index].category)
							self.incomDetailCellData.append(listdata)
						}

						for index in 0..<result.completeList.count {
							let listdata = DetailData(id: result.completeList[index].id, issueTitle: result.completeList[index].issueTitle, issueContents: result.completeList[index].issueContents, progress: result.completeList[index].progress, category: result.completeList[index].category)
							self.comDetailCellData.append(listdata)
						}
							print("여기 incomplete")
							print(self.incomDetailCellData)
							print("여기 complete")
							print(self.comDetailCellData)
						
						
						self.communicationTableView.reloadData()
						//semaphore.wait()
						
					} catch {
						print(error)
					}
				}
			}, onError: { error in
				print(error)
			}, onCompleted: {
				self.communicationTableView.reloadData()

				
			}).disposed(by: disposeBag)
		
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
		return tableViewData.count
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
		//print(#function)
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
				print("여기 들어왔었음")
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
					print("이건 섹션 \(indexPath.section)")
					print("이건 로우 \(indexPath.row)")
					print(tableViewData[indexPath.section])
					print("123123123",tableViewData)
					
					contentCell.contentData = tableViewData[indexPath.section].sectionData[indexPath.row-1]
					contentCell.filloutCell()
					
					return contentCell
				} else { ///cell중에서도 complete부분
					contentCell.contentData = tableViewData[indexPath.section].sectionData[indexPath.row-1]
					contentCell.filloutCell()
					print("이건 섹션 \(indexPath.section)")
					print("이건 로우 \(indexPath.row)")
					print(tableViewData[indexPath.section])
					
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

struct Communication: Codable {
	let unit: String
	let incompleteLength: Int
	let incompleteList: [Inquiry]
	let completeLength: Int
	let completeList: [Inquiry]
	
	enum CodingKeys: String, CodingKey {
		case unit
		case incompleteLength = "incomplete_length"
		case incompleteList = "incomplete_list"
		case completeLength = "complete_length"
		case completeList = "complete_list"
	}
}

// MARK: - CompleteList
struct Inquiry: Codable {
	let id: Int
	let issueTitle, issueContents: String
	let progress, category: Int
	
	enum CodingKeys: String, CodingKey {
		case id
		case issueTitle = "issue_title"
		case issueContents = "issue_contents"
		case progress, category
	}
}
