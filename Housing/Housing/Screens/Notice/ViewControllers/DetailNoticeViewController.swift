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
	var id: Int?
	var noticeData = NoticeDetail(id: nil, noticeTitle: nil, noticeContents: nil,
																noticeYear: nil, noticeMonth: nil, noticeDay: nil,
																noticeTime: nil, houseInfoID: nil, option: nil)
	private let noticeProvider = MoyaProvider<NoticeService>(plugins: [NetworkLoggerPlugin(
																																			verbose: true)])
	var identifier: Int?
	
	//MARK:- Component(Outlet)
	@IBOutlet weak var detailTitle: UILabel!
	@IBOutlet weak var detailContext: UILabel!
	@IBOutlet weak var smallSquareView: UIView!
	@IBOutlet weak var blockView: UIView!
	
	//캘린더 추가 공지 컴포넌트를 담은 뷰
	@IBOutlet weak var entireComponents: UIView!
	@IBOutlet weak var circleView: UIView!
	@IBOutlet weak var addedNoticeView: UIView!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var timeLabel: UILabel!
	
	//날짜 시간 방법
	@IBOutlet weak var dateOfNotice: UILabel!
	@IBOutlet weak var timeOfNotice: UILabel!
	
	//캘린더에 추가된 공지인지
	@IBOutlet weak var isAddedToCalendar: UILabel!
	
	//MARK:- Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		initLayout()
		notice()
		
		navigationController?.interactivePopGestureRecognizer?.delegate = nil
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tabBarController?.tabBar.isHidden = true
		navigationController?.setNavigationBarHidden(false, animated: true)
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
						let data = try decoder.decode(ResponseType<NoticeDetail>.self,
																					from: response.data)
						guard let result = data.data else {
							return
						}
						self.detailTitle.text = result.noticeTitle
						self.detailContext.text = result.noticeContents
						self.dateLabel.text = result.option?[0]
						self.timeLabel.text = result.option?[1]
						
						if result.option?[1] == "null" {
							self.blockView.backgroundColor = .white
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
		
		navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(
																												systemName: "chevron.backward"),
																											 style: .plain,
																											 target: self,
																											 action: #selector(toNotice))
		navigationItem.leftBarButtonItem?.tintColor = .black
		
		circleView.cornerRadius = circleView.frame.height / 2
		
		addedNoticeView.layer.cornerRadius = 12
	}
	
	@objc
	func toNotice() {
		navigationController?.popViewController(animated: true)
	}
	
	@IBAction func editButton(_ sender: Any) {
		
		let optionMenu = UIAlertController(title: nil,
																			 message: "공지사항을 삭제하시겠습니까?",
																			 preferredStyle: .actionSheet)
		
		let deleteAction = UIAlertAction(title: "삭제", style: .destructive, handler: {
			(alert: UIAlertAction!) -> Void in
			guard let identifier = self.id else {
				return
			}
			self.noticeProvider.rx.request(.deleteNotice(id: identifier))
				.asObservable()
				.subscribe { (next) in
					if next.statusCode == 200 {
						self.navigationController?.popViewController(animated: true)
					}
				} onError: { (error) in
					print(error.localizedDescription)
				}.disposed(by: self.disposeBag)
		})
		
		let cancelAction = UIAlertAction(title: "닫기", style: .cancel, handler: {
			(alert: UIAlertAction!) -> Void in
		})
		
		optionMenu.addAction(deleteAction)
		optionMenu.addAction(cancelAction)
		
		self.present(optionMenu, animated: true, completion: nil)
	}
}
