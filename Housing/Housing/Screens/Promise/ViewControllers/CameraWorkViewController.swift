//
//  CameraWorkViewController.swift
//  Housing
//
//  Created by 김태훈 on 2021/01/01.
//

import UIKit
import Photos
import AVFoundation
class CameraWorkViewController: UIViewController{
	
	let sessionn = AVCaptureSession()
	var camera : AVCaptureDevice?
	var cameraPreViewLayer : AVCaptureVideoPreviewLayer?
	var cameraCaptureOutput : AVCapturePhotoOutput?
	
	
	let imagePickerController = UIImagePickerController()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		imagePickerController.delegate = self

		print(evidencePictures)
		// Do any additional setup after loading the view.
	}
  @IBAction func addPictureFromCamera(_ sender: Any) {
    self.imagePickerController.sourceType = .camera
    self.present(self.imagePickerController, animated: true, completion: nil)
  }
  @IBAction func addPictureFromLibrary(_ sender: Any) {
    self.imagePickerController.sourceType = .photoLibrary
    self.present(imagePickerController, animated: true, completion: nil)
  }
  
	var evidencePictures : [UIImage] = []
	
}
extension CameraWorkViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		//사진 정보
    print(picker.sourceType)
		if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
			print("이미지받아왔ㅆ음")
			evidencePictures.append(image)
		}
    print(evidencePictures)
		dismiss(animated: true, completion: nil)
	}
}
