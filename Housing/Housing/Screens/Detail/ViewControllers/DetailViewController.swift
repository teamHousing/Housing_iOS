//
//  DetailViewController.swift
//  Housing
//
//  Created by 노한솔 on 2021/01/01.
//

import UIKit

import SegementSlide
import Then
import SnapKit
import RxMoya
import Moya
import RxCocoa
import RxSwift
import SwiftyJSON

class DetailViewController: SegementSlideDefaultViewController {
	
	// MARK: - Property
	let detailHeaderView = UIView().then {
		$0.isUserInteractionEnabled = true
		$0.contentMode = .scaleAspectFill
	}
	let categoryLabel = UILabel()
	let statusLabel = UILabel()
	let titleLabel = UILabel()
	let categoryContainerView = UIView()
	let contextLabel = UILabel()
	let seperateLineView = UIView().then {
		$0.backgroundColor = .gray01
	}
	let disposeBag = DisposeBag()
	var idValue = promiseId.shared
	private let detailProvider = MoyaProvider<DetailService>(
		plugins: [NetworkLoggerPlugin(verbose: true)]
	)
	private let coverSafeAreaView = UIView().then {
		$0.backgroundColor = .white
	}
	lazy var optionButton = UIBarButtonItem(image: UIImage(named: "iconShare"),
																				 style: .done,
																				 target: self,
																				 action: #selector(optionButtonDidTap))
	var category: String = ""
	var status: String = ""
	var viewTitle: String = ""
	var context: String = ""
	var requestId: Int = 1
	var model = DetailModel(id: 0,
													issueImages: [],
													promiseOption: [["1","1","1"]],
													category: 0, issueTitle: "",
													issueContents: "",
													progress: 0,
													requestedTerm: "",
													promiseYear: 0,
													promiseMonth: 0,
													promiseDay: 0,
													promiseTime: "",
													solutionMethod: "",
													confirmedPromiseOption: []
	)
	var statusModel: [DetailStatus] = []
	var optionModel: [CommunicationMethod] = []
	var heightWithSafeArea: CGFloat {
		return 243+self.contextLabel.frame.size.height
	}

	override var titlesInSwitcher: [String] {
		return ["상세 정보","하우징 쪽지"]
	}
	override var switcherConfig: SegementSlideDefaultSwitcherConfig {
		var config = super.switcherConfig
		config.type = .tab
		config.indicatorColor = .primaryOrange
		config.indicatorWidth = (self.view.frame.width/2)-40
		config.indicatorHeight = 2
		return config
	}
	
	// MARK: - Helper
	private func contextHeight() -> Int {
		let myText = self.contextLabel.text! as NSString
		let rect = CGSize(width: self.contextLabel.bounds.width,
											height: CGFloat.greatestFiniteMagnitude
		)
		let labelSize = myText.boundingRect(with: rect,
																				options: .usesLineFragmentOrigin,
																				attributes: [NSAttributedString.Key.font:
																											self.contextLabel.font],
																				context: nil
		)
		return Int(ceil(CGFloat(labelSize.height) / self.contextLabel.font.lineHeight))
	}
		
	private func headerViewLayout() {
		self.detailHeaderView.add(self.categoryContainerView) {
			$0.backgroundColor = .primaryBlack
			$0.layer.cornerRadius = 13
		}
		self.detailHeaderView.add(categoryLabel) {
			switch (self.model.category) {
			case 0:
				$0.text = "고장/수리"
			case 1:
				$0.text = "계약관련"
			case 2:
				$0.text = "요금납부"
			case 3:
				$0.text = "소음관련"
			case 4:
				$0.text = "문의사항"
			case 5:
				$0.text = "그 외"
			default:
				$0.text = "오류"
			}
			$0.backgroundColor = UIColor.primaryBlack
			$0.textColor = UIColor.primaryWhite
			$0.textAlignment = .center
			$0.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
			$0.snp.makeConstraints {
				$0.top.equalTo(self.detailHeaderView).offset(16)
				$0.leading.equalTo(self.detailHeaderView).offset(20)
			}
		}
		self.categoryContainerView.snp.makeConstraints {
			$0.top.equalTo(self.categoryLabel.snp.top).offset(-6)
			$0.bottom.equalTo(self.categoryLabel.snp.bottom).offset(6)
			$0.leading.equalTo(self.categoryLabel.snp.leading).offset(-10)
			$0.trailing.equalTo(self.categoryLabel.snp.trailing).offset(10)
		}
		self.detailHeaderView.add(self.statusLabel) {
			switch (self.model.progress) {
			case 0:
				$0.text = "확인 전"
			case 1:
				$0.text = "확인 중"
			case 2:
				$0.text = "해결완료"
			default:
				$0.text = "오류"
			}
			$0.textColor = .primaryOrange
			$0.textAlignment = .left
			$0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
			$0.snp.makeConstraints {
				$0.centerY.equalTo(self.categoryLabel.snp.centerY)
				$0.trailing.equalTo(self.detailHeaderView.snp.trailing).offset(-20)
				$0.height.equalTo(17)
			}
		}
		self.detailHeaderView.add(self.titleLabel) {
			$0.text = self.model.issueTitle!
			$0.textAlignment = .left
			$0.font = UIFont.systemFont(ofSize: 21, weight: .bold)
			$0.snp.makeConstraints {
				$0.top.equalTo(self.categoryLabel.snp.bottom).offset(20)
				$0.leading.equalTo(self.detailHeaderView.snp.leading).offset(20)
				$0.trailing.equalTo(self.detailHeaderView.snp.trailing).offset(-20)
				$0.height.equalTo(25)
			}
		}
		self.detailHeaderView.add(self.contextLabel) {
			$0.text = self.model.issueContents!
			$0.textAlignment = .left
			$0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
			$0.numberOfLines = 0
			$0.snp.makeConstraints {
				$0.leading.equalTo(self.detailHeaderView.snp.leading).offset(20)
				$0.trailing.equalTo(self.detailHeaderView.snp.trailing).offset(-20)
				$0.top.equalTo(self.titleLabel.snp.bottom).offset(40)
				$0.height.equalTo(self.contextHeight()*22)
			}
		}
	}
	
	private func layout() {
		self.view.add(self.seperateLineView) {
			$0.snp.makeConstraints {
				$0.height.equalTo(1)
				$0.leading.trailing.equalTo(self.view)
				$0.bottom.equalTo(self.switcherView.snp.bottom)
			}
		}
	}
	
	private func loader() {
		detailProvider.rx.request(.homeDetail(id: requestId))
			.asObservable()
			.subscribe(onNext: { response in
				do{
					let json = JSON(response.data)
					let decoder = JSONDecoder()
					let data = try decoder.decode(ResponseType<Detail>.self,
																				from: response.data)
					
					let result = data.data
					self.statusModel.append(DetailStatus(
																		ownerStatus: json["data"]["Replies"][0]["owner_status"].arrayValue.map{$0.intValue},
																		userStatus: json["data"]["Replies"][0]["user_status"].arrayValue.map{$0.intValue},
																		id: json["data"]["Replies"][0]["id"].intValue
						)
					)
					self.detailDataBind(result!)
					let viewController = ContentViewController()
					viewController.model = self.model
					let statusViewController = MessageViewController()
					self.idValue.id = data.data?.id ?? 11

					statusViewController.model = self.model
					statusViewController.statusModel = self.statusModel
					viewController.tableView.reloadData()

					statusViewController.tableView.reloadData()
				} catch {
					print(error)
				}
				
			}, onError: { error in
				print(error.localizedDescription)
			}, onCompleted: {
				self.headerViewLayout()
				self.detailHeaderView.snp.makeConstraints{
					$0.height.equalTo(130+self.contextHeight()*22)
				}
				self.detailHeaderView.reloadInputViews()
			}).disposed(by: disposeBag)
	}
	
	private func detailDataBind(_ data: Detail) {
		let id = data.id
		let category = data.category
		guard let issueImages = data.issueImages,
					let promiseOption = data.promiseOption,
					let issueTitle = data.issueTitle,
					let issueContents = data.issueContents,
					let progress = data.progress,
					let requestedTerm = data.requestedTerm,
					let promiseYear = data.promiseYear,
					let promiseMonth = data.promiseMonth,
					let promiseDay = data.promiseDay,
					let promiseTime = data.promiseTime,
					let solutionMethod = data.solutionMethod,
					let confirmedPromiseOption = data.confirmedPromiseOption
		else {
			return
		}
		let model = DetailModel(id: id,
														issueImages: issueImages,
														promiseOption: promiseOption,
														category: category,
														issueTitle: issueTitle,
														issueContents: issueContents,
														progress: progress,
														requestedTerm: requestedTerm,
														promiseYear: promiseYear,
														promiseMonth: promiseMonth,
														promiseDay: promiseDay,
														promiseTime: promiseTime,
														solutionMethod: solutionMethod,
														confirmedPromiseOption: confirmedPromiseOption
		)
		self.model = model
		self.reloadData()
	}
		
	private func setSafeArea() {
		view.add(coverSafeAreaView) {
			$0.snp.makeConstraints {
				$0.top.equalToSuperview()
				$0.leading.equalToSuperview()
				$0.trailing.equalToSuperview()
				$0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.top)
			}
		}
	}

	@objc
	private func optionButtonDidTap() {
		let optionMenu = UIAlertController(title: nil,
																			 message: nil,
																			 preferredStyle: .actionSheet)
		
		//옵션 초기화
		let deleteAction = UIAlertAction(title: "Delete",
																		 style: .default,
																		 handler: {
				(alert: UIAlertAction!) -> Void in
		})
		let saveAction = UIAlertAction(title: "Save",
																	 style: .default,
																	 handler: {
				(alert: UIAlertAction!) -> Void in
		})
		
		let cancelAction = UIAlertAction(title: "Cancel",
																		 style: .cancel,
																		 handler: {
				(alert: UIAlertAction!) -> Void in
																		 })

	 //action sheet에 옵션 추가.
		optionMenu.addAction(deleteAction)
		optionMenu.addAction(saveAction)
		optionMenu.addAction(cancelAction)
		
	 //show
		self.present(optionMenu, animated: true, completion: nil)
	}

		
	override func segementSlideContentViewController(at index: Int)
	-> SegementSlideContentScrollViewDelegate? {
		let viewController = ContentViewController()
		let messageViewController = MessageViewController()
		if(contentView.selectedIndex == 0 ) {
			print("이거는!\(contentView.selectedIndex)")
			messageViewController.model = self.model
			messageViewController.statusModel = self.statusModel
			return messageViewController
		}
		else {
			viewController.model = self.model
			viewController.statusModel = self.statusModel
			return viewController
		}
	}
	
	override func segementSlideHeaderView() -> UIView? {
		return self.detailHeaderView
	}
		
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		loader()
		defaultSelectedIndex = 0
		layout()
		setSafeArea()
		reloadData()
		navigationItem.rightBarButtonItem = optionButton
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		navigationController?.navigationBar.topItem?.title = ""
		tabBarController?.tabBar.isHidden = true
		edgesForExtendedLayout = .bottom
		extendedLayoutIncludesOpaqueBars = true
		navigationController?.navigationBar.shadowImage = UIImage()
		navigationController?.navigationBar.isTranslucent = false
		navigationController?.navigationBar.tintColor = .black
		navigationController?.setNavigationBarHidden(false, animated: true)
		loader()
		self.contentView.defaultSelectedIndex = 0
		defaultSelectedIndex = 0
		
		layout()
		setSafeArea()
		reloadData()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(true)
		tabBarController?.tabBar.isHidden = false
		edgesForExtendedLayout = .top
		extendedLayoutIncludesOpaqueBars = false
	}
}
