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

class DetailViewController: SegementSlideDefaultViewController {
	
	var category: String = "고장/수리"
	var status: String = "확인 전"
	var viewTitle: String = "수도꼭지가 고장났어요ㅠ 집이 물바다"
	var context: String = "저희 집 화장실 세면대에 수도꼭지가 고장나서 물이 계속 새고 있는데 이러다 수도세가 너무 많이 나올 것 같아요ㅠ \n\n글 확인하시면 최대한 빠르게 수리 부탁드립니다..!!\n\n저희 집 화장실 세면대에 수도꼭지가 고장나서 물이 계속 새고 있는데 이러다 수도세가 너무 많이 나올 것 같아요ㅠ \n\n글 확인하시면 최대한 빠르게 수리 부탁드립니다..!!\n"
	var requestId: Int = 1
	var model = DetailModel(id: 0, issueImages: [], promiseOption: [[]], category: 0, issueTitle: "", issueContents: "", progress: 0, requestedTerm: "", promiseYear: 0, promiseMonth: 0, promiseDay: 0, promiseTime: "", solutionMethod: "", confirmedPromiseOption: [])
	var statusModel: [DetailStatus] = []
	
	let detailHeaderView = UIView().then{
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
	
	private let detailProvider = MoyaProvider<DetailService>(plugins:
																														[NetworkLoggerPlugin(verbose: true)])
	
	private let coverSafeAreaView = UIView().then {
		$0.backgroundColor = .white
	}
	
	func contextHeight() -> Int {
		let myText = self.contextLabel.text! as NSString
		let rect = CGSize(width: self.contextLabel.bounds.width, height: CGFloat.greatestFiniteMagnitude)
		let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: self.contextLabel.font], context: nil)
		return Int(ceil(CGFloat(labelSize.height) / self.contextLabel.font.lineHeight))
	}
	
	var heightWithSafeArea: CGFloat {
		return 243+self.contextLabel.frame.size.height
	}
	
	
	func headerViewLayout() {
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
			$0.snp.makeConstraints{
				$0.top.equalTo(self.detailHeaderView).offset(16)
				$0.leading.equalTo(self.detailHeaderView).offset(20)
			}
		}
		self.categoryContainerView.snp.makeConstraints{
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
			$0.snp.makeConstraints{
				$0.centerY.equalTo(self.categoryLabel.snp.centerY)
				$0.trailing.equalTo(self.detailHeaderView.snp.trailing).offset(-20)
				$0.height.equalTo(17)
			}
		}
		self.detailHeaderView.add(self.titleLabel) {
			$0.text = self.model.issueTitle!
			$0.textAlignment = .left
			$0.font = UIFont.systemFont(ofSize: 21, weight: .bold)
			$0.snp.makeConstraints{
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
			$0.snp.makeConstraints{
				$0.leading.equalTo(self.detailHeaderView.snp.leading).offset(20)
				$0.trailing.equalTo(self.detailHeaderView.snp.trailing).offset(-20)
				$0.top.equalTo(self.titleLabel.snp.bottom).offset(40)
				$0.height.equalTo(self.contextHeight()*22)
			}
		}
	}
	
	func layout() {
		self.view.add(self.seperateLineView) {
			$0.snp.makeConstraints {
				$0.height.equalTo(1)
				$0.leading.trailing.equalTo(self.view)
				$0.bottom.equalTo(self.switcherView.snp.bottom)
			}
		}
	}
	
	func loader() {
		
		detailProvider.rx.request(.homeDetail(id: requestId))
			.asObservable()
			.subscribe(onNext: { response in
				do{
					let decoder = JSONDecoder()
					let data = try decoder.decode(ResponseType<Detail>.self,
																				from: response.data)
					let result = data.data
					
//					print(result)
					self.detailDataBind(result!)
					
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
				let viewController = ContentViewController()
				viewController.model = self.model
				print(viewController.model.requestedTerm)
				viewController.statusModel = self.statusModel
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
					let confirmedPromiseOption = data.confirmedPromiseOption,
					let replies = data.replies
		else {
			return
		}
		let model = DetailModel(id: id, issueImages: issueImages, promiseOption: promiseOption, category: category, issueTitle: issueTitle, issueContents: issueContents, progress: progress, requestedTerm: requestedTerm, promiseYear: promiseYear, promiseMonth: promiseMonth, promiseDay: promiseDay, promiseTime: promiseTime, solutionMethod: solutionMethod, confirmedPromiseOption: confirmedPromiseOption)
		self.model = model
		self.statusModel.append(DetailStatus(ownerStatus: replies[0].ownerStatus, id: replies[0].id))
//		print(self.statusModel)
	}
	
	
	private func setSafeArea() {
		view.add(coverSafeAreaView){
			$0.snp.makeConstraints {
				$0.top.equalToSuperview()
				$0.leading.equalToSuperview()
				$0.trailing.equalToSuperview()
				$0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.top)
			}
		}
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
	
	override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
		loader()
		let viewController = ContentViewController()
		let messageViewController = MessageViewController()
		if(contentView.selectedIndex == 0 ) {
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
		defaultSelectedIndex = 0
		layout()
		setSafeArea()
		reloadData()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		tabBarController?.tabBar.isHidden = true
		edgesForExtendedLayout = .bottom
		extendedLayoutIncludesOpaqueBars = true
		navigationController?.navigationBar.shadowImage = UIImage()
		navigationController?.navigationBar.isTranslucent = false
		navigationController?.navigationBar.tintColor = .black
		navigationController?.setNavigationBarHidden(false, animated: true)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(true)
		tabBarController?.tabBar.isHidden = false
		edgesForExtendedLayout = .top
		extendedLayoutIncludesOpaqueBars = false
	}
	
}


