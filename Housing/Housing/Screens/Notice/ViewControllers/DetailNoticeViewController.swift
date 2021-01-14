//
//  DetailNoticeViewController.swift
//  Housing
//
//  Created by 곽기곤's Mac on 2021/01/08.
//

import UIKit

import Moya
import RxMoya

class DetailNoticeViewController: BaseViewController {
	
	//MARK:- Property
	var titleData: String?
	var contextData: String?
	var id: Int?
	
	private let noticeProvider = MoyaProvider<NoticeService>(plugins: [NetworkLoggerPlugin(verbose: true)])
	
	//MARK:- Component(Outlet)
	@IBOutlet weak var detailTitle: UILabel!
	@IBOutlet weak var detailContext: UILabel!
	
	//캘린더 추가 공지 컴포넌트를 담은 뷰
	@IBOutlet weak var entireComponents: UIView!
	@IBOutlet weak var circleView: UIView!
	@IBOutlet weak var addedNoticeView: UIView!
	
	//날짜 시간 방법
	@IBOutlet weak var dateOfNotice: UILabel!
	@IBOutlet weak var timeOfNotice: UILabel!
	@IBOutlet weak var wayOfNotice: UILabel!
	
	//캘린더에 추가된 공지인지
	@IBOutlet weak var isAddedToCalendar: UILabel!
	
	//MARK:- Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		initLayout()
		initData()
		notice()
		
		navigationController?.interactivePopGestureRecognizer?.delegate = nil
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tabBarController?.tabBar.isHidden = true
	}
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		tabBarController?.tabBar.isHidden = false
	}
	
	//MARK:- Helper
	func notice() {
		guard let id = id
		else {
			return
		}
		
		noticeProvider.rx.request(.profileNoticeDetail(id: id)).asObservable()
			.subscribe(onNext: { response in
				if response.statusCode == 200 {
					do{
						let decoder = JSONDecoder()
						let data = try decoder.decode(ResponseType<MyInfo>.self,
																					from: response.data)
						guard let result = data.data else {
							
							return
						}
						print(result)
					} catch {
						print(error)
					}
				}
			}, onError: { error in
				print(error)
			}, onCompleted: {
			}, onDisposed: {
			}).disposed(by: disposeBag)
	}
	
	func initLayout() {
		navigationController?.navigationBar.topItem?.title = ""
		navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
		navigationController?.navigationBar.shadowImage = UIImage()
		
		navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(toNotice))
		navigationItem.leftBarButtonItem?.tintColor = .black
		
		circleView.cornerRadius = circleView.frame.height / 2
		
		addedNoticeView.layer.cornerRadius = 12
	}
	
	func initData() {
		detailTitle.text = titleData
		detailContext.text = contextData
	}
	
	@objc func toNotice() {
		navigationController?.popViewController(animated: true)
	}
}
