//
//  CameraWorkViewController.swift
//  Housing
//
//  Created by 김태훈 on 2021/01/01.
//

import Photos
import UIKit
import Then
import SnapKit

import YPImagePicker

class CameraWorkViewController: UIViewController{
	// MARK: - Component

	var evidencePictures : [UIImage] = []
	var requestData = RequestDataModel.shared
	var config : YPImagePickerConfiguration {
		var temp = YPImagePickerConfiguration()
		temp.usesFrontCamera = false
		temp.screens = [.library, .photo]
		temp.library.maxNumberOfItems = 10
		temp.library.defaultMultipleSelection = true
		temp.showsPhotoFilters = false
		temp.onlySquareImagesFromCamera = false
		temp.hidesBottomBar = false
		temp.hidesCancelButton = false
		temp.library.skipSelectionsGallery = true
		return temp
	}
	private let mainLabel = UILabel().then {
		$0.numberOfLines = 2
		$0.text = """
							함께 보여주고 싶은
							사진이나 동영상이 있나요?
							"""
		$0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 26)
		$0.textColor = .black
		$0.textAlignment = .left
	}
	
	private let lineImage = UIView().then {
		$0.backgroundColor = UIColor.primaryBlack
		$0.tintColor = UIColor.primaryBlack
		}
	let photoSelectCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		$0.backgroundColor = .white
		$0.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
		$0.showsHorizontalScrollIndicator = false
		$0.showsVerticalScrollIndicator = false
		$0.collectionViewLayout = layout
	}
	private let nextStep = UIButton().then{
		$0.backgroundColor = .primaryOrange
		$0.setTitle("다음 단계", for: .normal)
		$0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
		$0.setRounded(radius: 25)
		$0.addTarget(self, action: #selector(nextButtonDidTapped), for: .touchUpInside)
	}
	private let page = UIPageControl().then{
		$0.numberOfPages = 4
		$0.currentPage = 1
		$0.currentPageIndicatorTintColor = .primaryOrange
		$0.tintColor = .gray01
		$0.pageIndicatorTintColor = .gray01
	}
	// MARK: - Helper
	@objc func nextButtonDidTapped() {
		let additionalRequestViewController = AdditionalRequestViewController()
		self.navigationController?.pushViewController(additionalRequestViewController, animated: true)
	}
	
	private func widthConstraintAmount(value : CGFloat) -> CGFloat {
		let superViewWidth = self.view.frame.width
		
		return (value / 375) * superViewWidth
	}
	private func heightConstraintAmount(value : CGFloat) -> CGFloat {
		let superViewHeight = self.view.frame.height
		
		return (value / 677) * superViewHeight
	}
	private func layout() {
		navigationController?.navigationBar.topItem?.title = ""
		if !requestData.isPromiseNeeded {
			page.numberOfPages = 3
		}
		self.navigationController?.navigationBar.backgroundColor = .white
		self.view.backgroundColor = .white
		self.view.adds([
		mainLabel,
		lineImage,
		photoSelectCollectionView,
		nextStep,
		page])
				
		mainLabel.snp.makeConstraints{
			
			$0.top.equalTo(view.safeAreaLayoutGuide).offset(6)
			$0.leading.equalTo(view).offset(widthConstraintAmount(value: 20))
			$0.trailing.equalTo(view).offset(widthConstraintAmount(value: 85))
		}
		lineImage.snp.makeConstraints{
			$0.top.equalTo(view.safeAreaLayoutGuide).offset(64)
			$0.trailing.equalTo(view.safeAreaLayoutGuide).offset(0)
			$0.leading.equalTo(mainLabel.snp.trailing).offset(8)
			$0.height.equalTo(1)
			$0.width.equalTo(widthConstraintAmount(value: 77))
		}
		photoSelectCollectionView.snp.makeConstraints{
			$0.left.right.equalToSuperview()
			$0.top.equalTo(mainLabel.snp.bottom).offset(64)
			$0.leading.equalTo(view.safeAreaLayoutGuide).offset(0)
			$0.trailing.equalTo(view.safeAreaLayoutGuide).offset(0)
			$0.height.equalTo(self.view.frame.height * (162/677))
		}
		nextStep.snp.makeConstraints{
			$0.centerX.equalTo(view)
			$0.width.equalTo(widthConstraintAmount(value: 255))
			$0.height.equalTo(48)
			$0.bottom.equalTo(view).offset(-110)
			
		}
		
		page.snp.makeConstraints{
			$0.top.equalTo(nextStep.snp.bottom).offset(24)
			$0.bottom.equalToSuperview()
			$0.height.equalTo(20)
			$0.centerX.equalToSuperview()
		}
	}
	
	func collectionViewConfig() {
		self.photoSelectCollectionView.register(photoCollectionViewCell.self, forCellWithReuseIdentifier: photoCollectionViewCell.registerId)
		self.photoSelectCollectionView.delegate = self
		self.photoSelectCollectionView.dataSource = self
	}
	
	
	func cameraWork() {
		let picker = YPImagePicker(configuration: self.config)
		picker.didFinishPicking{ [unowned picker] items, _ in
			if let photo = items.singlePhoto {
				print(photo.fromCamera)
				print(photo.image)
				self.evidencePictures.append(photo.image)
				self.requestData.images.append(photo.image)
			}
			self.photoSelectCollectionView.reloadData()
			picker.dismiss(animated: true, completion: nil)
			
		}
		present(picker, animated: true, completion: nil)
	}
	func photoLibraryWork() {
		let picker = YPImagePicker(configuration: config)
		picker.didFinishPicking{ [unowned picker] items, cancelled in
			for item in items {
				switch item {
				case .photo(let photo):
					print(photo.image)
					if !self.evidencePictures.contains(photo.image){
						self.evidencePictures.append(photo.image)
						self.requestData.images.append(photo.image)
					}
				case .video(v: _):
					print("비디오")
				}
			}
			self.photoSelectCollectionView.reloadData()
			picker.dismiss(animated: true, completion: nil)
		}
		present(picker, animated: true, completion: nil)
	}
	
	// MARK: - Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		print(requestData)
		layout()
		collectionViewConfig()
		requestData.images.removeAll()
		// Do any additional setup after loading the view.
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tabBarController?.tabBar.isHidden = true
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		tabBarController?.tabBar.isHidden = false
	}
}

// MARK: - CollectionView
extension CameraWorkViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if indexPath.row == 0 {
			photoLibraryWork()
		}
		else {
			let viewController = ImageViewController()
			viewController.modalPresentationStyle = .overCurrentContext
			viewController.imageViewArray = evidencePictures
			self.present(viewController, animated: true)
		}
	}
}
extension CameraWorkViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return evidencePictures.count + 1
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCollectionViewCell.registerId, for: indexPath) as? photoCollectionViewCell
		else {
			return UICollectionViewCell()
		}
		if evidencePictures.count == 0 {
			cell.cameraAsset()
			cell.cameraView.isHidden = false
			cell.evidenceImages.isHidden = true
			cell.addbuttonView.isHidden = true
			cell.evidenceImages.image = UIImage(named: "img3")
			cell.deleteBtn.isHidden = true
			cell.layer.applyShadow(color: .black, alpha: 0.10000000149011612, x: 0, y: 0, blur: 8)
			cell.clipsToBounds = false
		}
		else {
			if indexPath.row == 0 {
				cell.cameraView.isHidden = true
				cell.addFromCameraRoll()
				cell.deleteBtn.isHidden = true
				cell.evidenceImages.isHidden = true
				cell.addbuttonView.isHidden = false
				cell.layer.applyShadow(color: .black, alpha: 0.10000000149011612, x: 0, y: 0, blur: 8)
				cell.clipsToBounds = false
			}
			else {
				cell.bindConstraints()
				cell.cameraView.isHidden = true
				cell.evidenceImages.isHidden = false
				cell.addbuttonView.isHidden = true
				cell.evidenceImages.contentMode = .scaleAspectFit

				let uiimage = evidencePictures[indexPath.row - 1]
				
				cell.evidenceImages.image = uiimage.resizeImage(newSize: CGSize(width: self.view.frame.height * (162/677), height: self.view.frame.height * (162/677)))
				cell.deleteBtn.isHidden = false
				cell.deleteBtn.tag = indexPath.row - 1
				cell.deleteBtn.addTarget(self, action: #selector(deleteCell), for: .touchUpInside)
			}
			
		}
		return cell
	}
	@objc func deleteCell(sender:UIButton) {
		evidencePictures.remove(at: sender.tag)
		photoSelectCollectionView.reloadData()
		
	}
	
	
	
}
extension CameraWorkViewController : UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let cellWidth = self.view.frame.height * (162/677)
		let cellSize = CGSize(width:cellWidth, height: cellWidth)
		return cellSize
	}
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 8.0
	}
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
	}
}
