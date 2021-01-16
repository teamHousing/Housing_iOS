//
//  AddedImageTableViewCell.swift
//  Housing
//
//  Created by 노한솔 on 2021/01/05.
//

import UIKit

import Moya
import Kingfisher
import RxCocoa
import RxMoya
import RxSwift
import SnapKit
import Then

class AddedImageTableViewCell: UITableViewCell {
	
	// MARK: - Property
	var imageURL: [String] = []
	var id = promiseId.shared.id
	var rootViewController: UIViewController?
	
	private let detailProvider = MoyaProvider<DetailService>()
	let disposeBag = DisposeBag()
	let addedImageCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.isScrollEnabled = false
		//		collectionView.isPagingEnabled = true
		collectionView.isUserInteractionEnabled = true
		
		return collectionView
	}()
	let titleLabel = UILabel().then() {
		$0.text = "첨부파일"
		$0.font = UIFont.systemFont(ofSize: 15, weight: .bold)
		$0.textColor = .primaryBlack
		$0.textAlignment = .left
	}
	let cancelButton = UIButton().then() {
		$0.backgroundColor = .none
		$0.setBorder(borderColor: .primaryOrange, borderWidth: 1)
		$0.layer.cornerRadius = 24
		$0.setTitle("요청 취소", for: .normal)
		$0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
		$0.titleLabel?.textAlignment = .center
		$0.titleLabel?.textColor = .primaryBlack
		$0.setTitleColor(.primaryBlack, for: .normal)
	}
	
	
	// MARK: - Helper
	static func estimatedRowHeight() -> CGFloat {
		return 600
	}
	
	private func layout() {
		self.contentView.add(self.titleLabel) {
			$0.snp.makeConstraints {
				$0.top.equalTo(self.contentView.snp.top).offset(56)
				$0.leading.equalTo(self.contentView.snp.leading).offset(20)
			}
		}
		self.contentView.add(self.addedImageCollectionView) {
			$0.clipsToBounds = false
			$0.backgroundColor = .none
			$0.contentMode = .scaleAspectFit
			$0.snp.makeConstraints {
				$0.top.equalTo(self.titleLabel.snp.bottom).offset(16)
				$0.leading.equalTo(self.titleLabel.snp.leading)
				$0.height.equalTo((self.contentView.frame.width)/3)
				$0.width.equalTo(self.contentView.frame.width)
			}
		}
		self.contentView.add(self.cancelButton) {
			$0.snp.makeConstraints {
				$0.top.equalTo(self.addedImageCollectionView.snp.bottom).offset(72)
				$0.leading.equalTo(self.contentView.snp.leading).offset(60)
				$0.trailing.equalTo(self.contentView.snp.trailing).offset(-60)
				$0.height.equalTo(48)
				$0.bottom.equalTo(self.contentView.snp.bottom).offset(-100)
			}
		}
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		self.addedImageCollectionView.collectionViewLayout = layout
		self.cancelButton.addTarget(self, action: #selector(didTapCancelButton(_:)), for: .touchUpInside)
	}
	
	private func registerCell() {
		addedImageCollectionView.register(AddedImageCollectionViewCell.self,
																			forCellWithReuseIdentifier:
																				AddedImageCollectionViewCell.reuseIdentifier)
	}
	
	@objc func didTapCancelButton(_ sender: UIButton) {
		print(#function)
		detailProvider.rx.request(.deleteDetail(id: self.id))
			.asObservable()
			.subscribe { (next) in
				if next.statusCode == 200 {
					self.cancelButton.setTitle("취소 완료", for: .normal)
					self.cancelButton.setBorder(borderColor: .gray01, borderWidth: 1)
					self.cancelButton.isEnabled = false
				}
			} onError: { (error) in
				print(error.localizedDescription)
			}.disposed(by: disposeBag)
	}
	
	// MARK: - Lifecycle
	override func awakeFromNib() {
		super.awakeFromNib()
		layout()
		registerCell()
		self.addedImageCollectionView.delegate = self
		self.addedImageCollectionView.dataSource = self
		self.addedImageCollectionView.reloadData()
	}
}

// MARK: - UICollectionView DelegateFlowLayout
extension AddedImageTableViewCell: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
												UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: (self.contentView.frame.width-56)/3,
									height: (self.contentView.frame.width-56)/3)
	}
	func collectionView(_ collectionView: UICollectionView,
											layout collectionViewLayout: UICollectionViewLayout,
											minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 8
	}
	func collectionView(_ collectionView: UICollectionView,
											layout collectionViewLayout: UICollectionViewLayout,
											minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
	func collectionView(_ collectionView: UICollectionView,
											layout collectionViewLayout: UICollectionViewLayout,
											insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
	}
}

// MARK: - UICollectionView DataSource
extension AddedImageTableViewCell: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView,
											didSelectItemAt indexPath: IndexPath) {
		let viewController = ImageViewController()
		viewController.modalPresentationStyle = .overCurrentContext
		viewController.imageArray = imageURL
		self.rootViewController?.present(viewController, animated: true)
	}
	
	func collectionView(_ collectionView: UICollectionView,
											numberOfItemsInSection section: Int) -> Int {
		if imageURL.count > 3 {
			return 3
		}
		else {
			return imageURL.count
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell: AddedImageCollectionViewCell = collectionView.dequeueCell(forIndexPath: indexPath)
		cell.addedImageView.imageFromUrl(
			self.imageURL[indexPath.row],
			defaultImgPath: "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMDExMjhfMjA1%2FMDAxNjA2NTczNjQ2NDM1.fM7rkGKrlK8X2RVymtLXyWGW5RNmAgU8yKsXzK9_oXMg.N3Y8IO5aKEF68xQQvQNj0S1f73o9yGpB8-gOH_S9738g.JPEG.eduvil%2F20201128%25A3%25DF180344.jpg&type=a340"
		)
		cell.addedImageView.layer.masksToBounds = true
		cell.addedImageView.layer.cornerRadius = 16
		cell.awakeFromNib()
		if indexPath.row == 2 {
			if self.imageURL.count > 3 {
				cell.blurView.isHidden = false
				cell.circleView.isHidden = false
				cell.plusLabel.text = "+\(self.imageURL.count-3)"
				cell.plusLabel.isHidden = false
			}
		}
		return cell
	}
}



