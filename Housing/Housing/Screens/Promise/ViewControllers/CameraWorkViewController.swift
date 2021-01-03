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
		temp.hidesBottomBar = true
		return temp
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
			picker.dismiss(animated: true, completion: nil)
		}
		present(picker, animated: true, completion: nil)
	}
//MARK: Function - 사진 보관함 켜는 함수
	func photoLibraryWork() {
		var config : YPImagePickerConfiguration {
			var temp = self.config
			temp.library.maxNumberOfItems = 10
			temp.library.defaultMultipleSelection = true
			temp.startOnScreen = YPPickerScreen.library
			temp.library.preSelectItemOnMultipleSelection = false
			return temp
		}
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
			picker.dismiss(animated: true, completion: nil)
		}
		present(picker, animated: true, completion: nil)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
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
