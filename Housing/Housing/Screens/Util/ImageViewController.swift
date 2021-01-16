//
//  ImageViewController.swift
//  Housing
//
//  Created by 오준현 on 2021/01/16.
//

import UIKit

import SnapKit

class ImageViewController: UIViewController {
	
	private let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.minimumLineSpacing = 0
		layout.minimumInteritemSpacing = 0
		let collectionView = UICollectionView(frame: .zero,
																					collectionViewLayout: layout)
		collectionView.isPagingEnabled = true
		collectionView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
		return collectionView
	}()
	
	private let backButton = UIButton().then {
		$0.setImage(UIImage(named: "btnListDown"), for: .normal)
		$0.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
	}
	
	private let pageControl = UIPageControl().then {
		$0.tintColor = .primaryOrange
		$0.backgroundColor = .blue
	}
	
	var imageArray: [String]?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		layout()
	}
	
	private func layout() {
		view.add(collectionView) {
			$0.snp.makeConstraints {
				$0.edges.equalToSuperview()
			}
			$0.delegate = self
			$0.dataSource = self
			$0.register(ImageCollectionViewCell.self,
									forCellWithReuseIdentifier: ImageCollectionViewCell.reuseIdentifier)
		}
		view.add(backButton) {
			$0.snp.makeConstraints {
				$0.trailing.equalToSuperview().offset(-10)
				$0.top.equalTo(self.view.safeAreaLayoutGuide).offset(10)
				$0.width.height.equalTo(40)
			}
		}
		view.add(pageControl) {
			$0.snp.makeConstraints {
				$0.bottom.equalToSuperview().offset((self.view.frame.height - self.view.frame.width)/2 - 50)
				$0.centerX.equalToSuperview()
			}
			$0.numberOfPages = self.imageArray?.count ?? 0
			$0.currentPage = 0
		}
	}
	
	@objc
	private func backButtonDidTap() {
		dismiss(animated: true, completion: nil)
	}
	
}

extension ImageViewController: UICollectionViewDelegate {
	
}
extension ImageViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView,
											numberOfItemsInSection section: Int) -> Int {
		return imageArray?.count ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView,
											cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell: ImageCollectionViewCell = collectionView.dequeueCell(forIndexPath: indexPath)
		
		guard let imageURL = imageArray?[indexPath.row] else {
			return UICollectionViewCell()
		}
		
		cell.image(imageURL)
		
		return cell
	}
	
}
extension ImageViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView,
											layout collectionViewLayout: UICollectionViewLayout,
											sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: view.frame.width,
									height: view.frame.height)
	}
}
