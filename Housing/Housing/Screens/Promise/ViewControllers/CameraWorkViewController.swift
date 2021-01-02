//
//  CameraWorkViewController.swift
//  Housing
//
//  Created by 김태훈 on 2021/01/01.
//

import AVFoundation
import Photos
import UIKit

import YPImagePicker

class CameraWorkViewController: UIViewController{
	var thumbnailPictures : [UIImage] = []
	
	var config : YPImagePickerConfiguration {
		var realconfig = YPImagePickerConfiguration()
		realconfig.usesFrontCamera = false
		realconfig.screens = [.library, .photo]
		realconfig.library.maxNumberOfItems = 10
		realconfig.library.defaultMultipleSelection = true
		realconfig.showsPhotoFilters = false
		realconfig.onlySquareImagesFromCamera = false
		realconfig.hidesBottomBar = true
		return realconfig
	}
	
	func cameraWork() {
		let picker = YPImagePicker(configuration: self.config)
		picker.didFinishPicking{ [unowned picker] items, _ in
			if let photo = items.singlePhoto {
				print(photo.fromCamera)
				print(photo.image)
				self.thumbnailPictures.append(photo.image)
			}
			picker.dismiss(animated: true, completion: nil)
		}
		present(picker, animated: true, completion: nil)
	}
	
	func photoLibraryWork() {
		var config : YPImagePickerConfiguration {
			var realconfig = self.config
			realconfig.library.maxNumberOfItems = 10
			realconfig.library.defaultMultipleSelection = true
			realconfig.startOnScreen = YPPickerScreen.library
			realconfig.library.preSelectItemOnMultipleSelection = false
			return realconfig
		}
		let picker = YPImagePicker(configuration: config)
		picker.didFinishPicking{ [unowned picker] items, cancelled in
			for item in items {
				switch item {
				case .photo(let photo):
					print(photo.image)
					self.thumbnailPictures.append(photo.image)
				default:
					print("비디오")
				}
			}
			picker.dismiss(animated: true, completion: nil)
		}
		present(picker, animated: true, completion: nil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		print(thumbnailPictures)
		// Do any additional setup after loading the view.
	}
	
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
}
