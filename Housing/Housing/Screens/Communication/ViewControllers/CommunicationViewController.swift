//
//  CommunicationViewController.swift
//  Housing
//
//  Created by 김주은 on 2021/01/01.
//

import UIKit

import Alamofire
import Moya
import SwiftKeychainWrapper

struct cellData {
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
	lazy var naviButton = UIBarButtonItem(image: UIImage(named: determineButtonImage(mode: mode)),
																				 style: .done,
																				 target: self,
																				 action: #selector(settingButtonDidTap))

	//MARK: - Property
	
	var incompleteLength = 0
	var completeLength = 0
	var mode = 3
	let isHost = KeychainWrapper.standard.integer(forKey: KeychainStorage.isHost) ?? 0
	private var tableViewData = [cellData]()
	private var incomDetailCellData: [DetailData] = []
	private var comDetailCellData: [DetailData] = []
	private let userProvider = MoyaProvider<CommunicationService>(plugins: [NetworkLoggerPlugin(verbose: true)])

	//MARK: - LifeCycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		determineType(isHost: isHost)
		networkForCommunication()
		layoutNavigationBar()
		configHeaderView()
		configTableView()
		pullToRefresh(tableview: communicationTableView)
		print(KeychainWrapper.standard.string(forKey: KeychainStorage.accessToken)!)
	}

	func dataSetup() {
		tableViewData = [cellData(opened: true,
															sectionData: incomDetailCellData), /// incomplete
										 cellData(opened: true,
															sectionData: comDetailCellData)] /// complete
	}

	private func determineButtonImage(mode: Int)-> String {
		if mode == 0 {
			return "2003"
		}else {
			return "icWrite"
		}
	}

	private func determineType(isHost: Int) {
		if isHost == 0 {
			mode = 0
		}else {
			mode = 1
		}
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
		navigationItem.rightBarButtonItem = naviButton
		navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
		navigationController?.navigationBar.shadowImage = UIImage()
		navigationController?.navigationBar.isTranslucent = false

	private func makeCellGrey(cell: UITableViewCell) {
		cell.contentView.backgroundColor = UIColor(named: "paleGrey")
	}

	private func networkForCommunication() {
		userProvider.rx.request(.home(unit: "-1"))
			.asObservable()
			.subscribe(onNext: { response in
				if response.statusCode == 200 {
					do {
						let decoder = JSONDecoder()
						let data = try decoder.decode(ResponseType<Communication>.self,
																					from: response.data)
						guard let result = data.data else {return}
						self.completeLength = result.completeLength
						self.incompleteLength = result.incompleteLength
						
						var listdata: [DetailData] = []
						for index in 0..<result.incompleteList.count {
							listdata.append(DetailData(id: result.incompleteList[index].id, issueTitle: result.incompleteList[index].issueTitle, issueContents: result.incompleteList[index].issueContents, progress: result.incompleteList[index].progress, category: result.incompleteList[index].category))
						}
						self.incomDetailCellData = listdata
						
						var listdata2: [DetailData] = []
						for index in 0..<result.completeList.count {
							listdata2.append(DetailData(id: result.completeList[index].id, issueTitle: result.completeList[index].issueTitle, issueContents: result.completeList[index].issueContents, progress: result.completeList[index].progress, category: result.completeList[index].category))
						}
						self.comDetailCellData = listdata2
						self.reloadInputViews()
						self.dataSetup()
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

	@objc
	private func settingButtonDidTap() {
		let view = PromiseViewController()
		navigationController?.pushViewController(view, animated: true)

	}
}

// MARK: - UITableView

extension CommunicationViewController: UITableViewDelegate { /// 이게 cell이 아니라 button에 반응하도록 해야함.
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.row == 0 {
			if tableViewData[indexPath.section].opened == true {
				tableViewData[indexPath.section].opened = false
				communicationTableView.backgroundColor = .primaryGray
				let sections = IndexSet(integer: indexPath.section)
				tableView.reloadSections(sections, with: .none) ///animaion
			} else {
				tableViewData[indexPath.section].opened = true
				communicationTableView.backgroundColor = .primaryGray
				let sections = IndexSet(integer: indexPath.section)
				tableView.reloadSections(sections, with: .none) ///animaion
			}
			communicationTableView.reloadData()
		} else {
			let viewController = DetailViewController()
			if tableViewData[indexPath.section].sectionData.count == 0 { } else {
				viewController.requestId = tableViewData[indexPath.section].sectionData[indexPath.row-1].id
				navigationController?.pushViewController(viewController, animated: true)
			}
		}
	}
}

extension CommunicationViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return tableViewData.count
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.row == 0 { /// title의 높이 지정.
			if indexPath.section == 0 {
				if mode == 0 {
					return 80 ///호수 선택하는 버튼 들어가야됨.
				} else if mode == 1 {
					return 70
				}
			} else if indexPath.section == 1 {
				return 70
			}
		} else if indexPath.row > 0 { ///cell의 높이 지정
			if incompleteLength == 0 && completeLength == 0 { ///incom에만 empty
				if indexPath.section == 0 {
					return 250 //with button
				} else {
					return 0
				}
			} else if incompleteLength == 0 && completeLength > 0 {
				if indexPath.section == 0 {
					return 230 // without button
				} else {
					return 180 //contentcell의 높이
				}
			} else if incompleteLength > 0 && completeLength == 0 {
				if indexPath.section == 0 {
					return 180 //contentcell의 높이
				} else {
					return 230 // emptycomcell의 높이
				}
			} else if incompleteLength > 0 && completeLength > 0 {
				return 180 //contentcell의 높이
			}
		}
		return 180
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
								 cellForRowAt indexPath: IndexPath) -> UITableViewCell { ///title부분에 쓸 cell
		guard let incomCell = tableView.dequeueReusableCell(withIdentifier: "IncompleteTableViewCell")
						as? IncompleteTableViewCell
		else {
			return UITableViewCell()
		}
		incomCell.contentView.backgroundColor = UIColor(named: "paleGrey")
		incomCell.countOfIncomplete.text = "(\(incompleteLength))"

		incomCell.roomNumberButton.isHidden = true ///앱잼에서 호수별 필터링을 구현하지 않기에 넣은 코드입니다.
		
		///여기로부터 5개의 줄 주석 삭제하지마세요.
//		if mode == 1 {
//			incomCell.roomNumberButton.isHidden = true
//		} else {
//			incomCell.roomNumberButton.isHidden = false
//		}
		guard let comCell = tableView.dequeueReusableCell(withIdentifier: "CompleteTableViewCell")
						as? CompleteTableViewCell
		else { return UITableViewCell()}
		comCell.countOfComplete.text = "(\(completeLength))"
		makeCellGrey(cell: comCell)

		func determineTitleButtonImage() {
			if tableViewData[0].opened {
				incomCell.incomToggle.image = UIImage(named: "btnListDown")
			}
			if !tableViewData[0].opened {
				incomCell.incomToggle.image = UIImage(named: "btnListUp")
			}
			if tableViewData[1].opened {
				comCell.comToggle.image = UIImage(named: "btnListDown")
			}
			if !tableViewData[1].opened {
				comCell.comToggle.image = UIImage(named: "btnListUp")
			}
		}
		determineTitleButtonImage()
		
		///cell부분에 쓸 cell
		guard let emptyIncomCell = tableView.dequeueReusableCell(withIdentifier: "emptyIncomTableViewCell")
						as? EmptyIncomTableViewCell
		else { return UITableViewCell()}
		emptyIncomCell.emptyLabel.numberOfLines = 2
		makeCellGrey(cell: emptyIncomCell)
		emptyIncomCell.emptyLabel.textAlignment = .center
		emptyIncomCell.makeButtonRounded()
		emptyIncomCell.rootViewController = self

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
		makeCellGrey(cell: emptyCell)

		if indexPath.row == 0 { ///여기가 title 부분. /// 완료된 것이 없을 때는 title이 뜨지 않도록 했음.
			if incompleteLength == 0 && completeLength == 0 {
				if indexPath.section == 0 {
					incomCell.incomToggle.isHidden = true
					return incomCell
				}
				if indexPath.section == 1{
					return emptyCell
				}
			}
			if indexPath.section == 0 {
				if incompleteLength == 0 {
					incomCell.incomToggle.isHidden = true
					return incomCell
			} else {
				return incomCell
			}
			} else if indexPath.section == 1 {
					if completeLength == 0 {
						comCell.comToggle.isHidden = true
						return comCell
					} else { return comCell}
				}
		}
		else {  ///여기가 내부 cell 부분.
			if incompleteLength == 0 && completeLength == 0 {
				if indexPath.section == 0 { ///cell중에서도 incomplete부분.
					if mode == 0 {
						emptyIncomCell.emptyLabel.text = "등록된 문의 사항이 없어요!\n자취생을 초대해 볼까요?"
						emptyIncomCell.inquiryButton.setTitle("초대하기", for: .normal)
					} else {
						emptyIncomCell.emptyLabel.text = "등록된 문의 사항이 없어요!\n집주인과 소통을 시작해볼까요?"
						emptyIncomCell.inquiryButton.setTitle("문의하기", for: .normal)
					}
					return emptyIncomCell
				} else { ///cell중에서도 complete부분
					return emptyCell
				}
			} else if incompleteLength == 0 && completeLength > 0 {
				if indexPath.section == 0 { ///cell중에서도 incomplete부분.
					emptyIncomCell.inquiryButton.isHidden = true
					emptyIncomCell.emptyLabel.text = "모든 문의가 해결되었어요!"
					return emptyIncomCell
				} else { ///cell중에서도 complete부분
					contentCell.contentData = tableViewData[indexPath.section].sectionData[indexPath.row-1]
					contentCell.awakeFromNib()
					return contentCell
				}
			} else if incompleteLength > 0 && completeLength == 0{
				if indexPath.section == 0 { ///cell중에서도 incomplete부분.
					contentCell.contentData = tableViewData[indexPath.section].sectionData[indexPath.row-1]
					contentCell.filloutCell()
					return contentCell
				} else { ///cell중에서도 complete부분
					return emptyComCell
				}
			} else if incompleteLength > 0 && completeLength > 0 {
				if indexPath.section == 0 {
					contentCell.contentData = tableViewData[indexPath.section].sectionData[indexPath.row-1]
					contentCell.filloutCell()
					return contentCell
				} else {
					contentCell.contentData = tableViewData[indexPath.section].sectionData[indexPath.row-1]
					contentCell.filloutCell()
					return contentCell
				}
			}
		}
		return UITableViewCell()
	}
}

extension CommunicationViewController: UIScrollViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		
		if scrollView.contentOffset.y < -1 {
			communicationTableView.backgroundColor = .white
		} else if scrollView.contentOffset.y >= -1 {
			communicationTableView.backgroundColor = .primaryGray }
	}
}

struct Communication: Codable {
	let unit: String?
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
