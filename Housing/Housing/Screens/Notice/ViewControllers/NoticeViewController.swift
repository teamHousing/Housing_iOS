//
//  NoticeViewController.swift
//  Housing
//
//  Created by 곽기곤's Mac on 2021/01/08.
//

import UIKit

import RxMoya
import Moya
import SwiftKeychainWrapper

final class NoticeViewController: BaseViewController {
	//MARK:- Component(Outlet)
	@IBOutlet weak var noticeCollectionView: UICollectionView!
    
	//MARK:- Property
	var houseData: HouseInfo?
	var noticeData: [Notice] = []
	
	// MARK: - Service
	private let noticeProvider = MoyaProvider<NoticeService>(plugins: [NetworkLoggerPlugin(verbose: true)])
	
	//MARK:- Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		initLayout()
		ownerProfile()
//		notice()
		pullToRefresh(collectionview: noticeCollectionView)
		noticeCollectionView.delegate = self
		noticeCollectionView.dataSource = self
	}
	override func viewWillAppear(_ animated: Bool) {
		pullToRefresh(collectionview: noticeCollectionView)
		ownerProfile()

	}

	//MARK:- Helper
	func ownerProfile() {
		noticeProvider.rx.request(.profile).asObservable().subscribe(onNext: { response in
			if response.statusCode == 200 {
				do{
					let decoder = JSONDecoder()
					let data = try decoder.decode(ResponseType<MyInfo>.self,
																				from: response.data)
					guard let result = data.data else {
						return
					}
					self.houseData = result.houseInfo
					self.noticeData = result.notice
					self.noticeCollectionView.reloadData()
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
	
	private func initLayout() {
		self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
		self.navigationController?.navigationBar.shadowImage = UIImage()
	}
	
	//MARK:- Component(Action)
	@IBAction func writeButtonDidTap(_ sender: Any) {
		let viewController = AddNoticeViewController()
		
		navigationController?.pushViewController(viewController, animated: true)
	}
	@IBAction func makeVerifyCode(_ sender: Any) {
		print(#function)
		let viewController = VerifyNumberViewController()
		navigationController?.pushViewController(viewController, animated: true)
	}
}

extension NoticeViewController: UIScrollViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		if scrollView.contentOffset.y > 10 {
			noticeCollectionView.backgroundColor = .primaryGray
		} else {
			noticeCollectionView.backgroundColor = .white
		}
	}
}

//MARK:- CollectionView
extension NoticeViewController: UICollectionViewDataSource {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView,
											numberOfItemsInSection section: Int) -> Int {
		return noticeData.count
	}
	
	func collectionView(_ collectionView: UICollectionView,
											cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
						withReuseIdentifier: "NoticeInformationCollectionViewCell",
						for: indexPath) as? NoticeInformationCollectionViewCell
		else {
			return UICollectionViewCell()
		}
		cell.noticeInfo = noticeData[indexPath.row]
		cell.fetchData()
		
		cell.backgroundColor = .primaryGray
		cell.containerView.layer.cornerRadius = 16 / 2
		
		cell.containerView.layer.applyCardShadow()
		cell.contentView.backgroundColor = UIColor.primaryGray
		
		return cell
	}
}

extension NoticeViewController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView,
											layout collectionViewLayout: UICollectionViewLayout,
											sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		return CGSize(width: view.frame.width, height: 116)
	}
	
	func collectionView(_ collectionView: UICollectionView,
											layout collectionViewLayout: UICollectionViewLayout,
											insetForSectionAt section: Int) -> UIEdgeInsets {
		
		return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
	}
}

extension NoticeViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView,
											viewForSupplementaryElementOfKind kind: String,
											at indexPath: IndexPath) -> UICollectionReusableView {
		switch kind {
		case UICollectionView.elementKindSectionHeader:
			if let headerView = collectionView.dequeueReusableSupplementaryView(
					ofKind: kind,
					withReuseIdentifier: "NoticeHeaderCollectionViewCell",
					for: indexPath) as? NoticeHeaderCollectionViewCell {
				headerView.layer.applyShadow(color: .black, alpha: 0.10000000149011612, x: 0, y: 0, blur: 16)
				
				headerView.headerBackgroundView.clipsToBounds = true
				headerView.headerBackgroundView.layer.cornerRadius = 16
				headerView.headerBackgroundView.layer.maskedCorners = [
					.layerMaxXMaxYCorner,
					.layerMinXMaxYCorner
				]
				headerView.info = houseData
				headerView.houseInfo()
				headerView.headerlayout()
                headerView.noticeLabel.text = "( \(String(noticeData.count)) )"
				
				return headerView
			}
		case UICollectionView.elementKindSectionFooter:
			if let footerView = collectionView.dequeueReusableSupplementaryView(
					ofKind: kind,
					withReuseIdentifier: "NoticeFooterCollectionViewCell",
					for: indexPath) as? NoticeFooterCollectionViewCell {
				
				return footerView
			}
		default:
			return UICollectionReusableView()
		}
		return UICollectionReusableView()
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let storyboard = UIStoryboard(name: "Notice", bundle: nil)
		guard let viewController = storyboard.instantiateViewController(
						withIdentifier: "DetailNoticeViewController") as? DetailNoticeViewController else {
			return
		}
		viewController.id = noticeData[indexPath.row].id
		
		navigationController?.pushViewController(viewController, animated: true)
	}
}
