//
//  CameraWorkViewController.swift
//  Housing
//
//  Created by 김태훈 on 2021/01/01.
//

import Photos
import UIKit

import YPImagePicker

class CameraWorkViewController: UIViewController{
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
	
	
	@IBOutlet weak var photoSelectCollectionView: UICollectionView!
  
	func collectionViewConfig() {
		self.photoSelectCollectionView.delegate = self
		self.photoSelectCollectionView.dataSource = self
	}
	

	//MARK: Function - 카메라 켜는 함수
	func cameraWork() {
		let picker = YPImagePicker(configuration: self.config)
		picker.didFinishPicking{ [unowned picker] items, _ in
			if let photo = items.singlePhoto {
				print(photo.fromCamera)
				print(photo.image)
				self.evidencePictures.append(photo.image)
			}
			self.photoSelectCollectionView.reloadData()
			picker.dismiss(animated: true, completion: nil)
			
		}
		present(picker, animated: true, completion: nil)
	}
	//MARK: Function - 사진 보관함 켜는 함수
	func photoLibraryWork() {
		let picker = YPImagePicker(configuration: config)
		picker.didFinishPicking{ [unowned picker] items, cancelled in
			for item in items {
				switch item {
				case .photo(let photo):
					print(photo.image)
					if !self.evidencePictures.contains(photo.image){
						self.evidencePictures.append(photo.image)
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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		collectionViewConfig()
		// Do any additional setup after loading the view.
	}
	//MARK: IBAction - 사진 찍기
	@IBAction func addPictureFromCamera(_ sender: Any) {
		switch PHPhotoLibrary.authorizationStatus() {
		case .denied:
			break
		case .restricted:
			break
		case .authorized:
			self.cameraWork()
		case .notDetermined:
			PHPhotoLibrary.requestAuthorization{
				state in
				if state == .authorized {
					self.cameraWork()
				}
				else {
					self.dismiss(animated: true, completion: nil)
				}
			}
		default:
			break
		}
	}
	//MARK: IBAction - 사진 선택하기
	@IBAction func addPictureFromLibrary(_ sender: Any) {
		switch PHPhotoLibrary.authorizationStatus() {
		case .denied:
			break
		case .restricted:
			break
		case .authorized:
			self.photoLibraryWork()
		case .notDetermined:
			PHPhotoLibrary.requestAuthorization{
				state in
				if state == .authorized {
					self.photoLibraryWork()
				}
				else {
					self.dismiss(animated: true, completion: nil)
				}
			}
		default:
			break
		}
	}
	//MARK: IBAction - 다음 버튼
	@IBAction func submitPictures(_ sender: Any) {
		print(self.evidencePictures)
		self.requestData.images = self.evidencePictures
		dump(self.requestData)
	}
}

extension CameraWorkViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if indexPath.row == 0 {
			photoLibraryWork()
		}
	}
}
extension CameraWorkViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return evidencePictures.count + 1
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCollectionViewCell.identifier, for: indexPath) as? photoCollectionViewCell
		else {
			return UICollectionViewCell()
		}
		
		cell.layout()
		print(cell.frame.size)
		cell.evidenceImages.contentMode = .scaleAspectFit
		if evidencePictures.count == 0 {
			cell.evidenceImages.image = UIImage(systemName: "camera.fill")
			cell.deleteBtn.isHidden = true
		}
		else {
			if indexPath.row == 0 {
				cell.evidenceImages.image = UIImage(systemName: "plus.app.fill")
				cell.deleteBtn.isHidden = true
			}
			else {
				cell.evidenceImages.image = evidencePictures[indexPath.row - 1]
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
    return 10.0
  }
}
