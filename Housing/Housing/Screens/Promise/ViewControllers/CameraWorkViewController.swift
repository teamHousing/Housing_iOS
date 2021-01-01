//
//  CameraWorkViewController.swift
//  Housing
//
//  Created by 김태훈 on 2021/01/01.
//

import UIKit
import AVFoundation
class CameraWorkViewController: UIViewController {
	
	let sessionn = AVCaptureSession()
	
	var camera : AVCaptureDevice?
	var cameraPreViewLayer : AVCaptureVideoPreviewLayer?
	var cameraCaptureOutput : AVCapturePhotoOutput?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initializeCapture()
		// Do any additional setup after loading the view.
	}
	func initializeCapture() {
		sessionn.sessionPreset = AVCaptureSession.Preset.high
		camera = AVCaptureDevice.default(for: .video)
		
		do {
			let cameraCaptureInput = try AVCaptureDeviceInput(device: camera!)
			cameraCaptureOutput = AVCapturePhotoOutput()
			sessionn.addInput(cameraCaptureInput)
			sessionn.addOutput(cameraCaptureOutput!)
		} catch {
			print(error.localizedDescription)
		}
		
		cameraPreViewLayer = AVCaptureVideoPreviewLayer(session: sessionn)
		cameraPreViewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
		cameraPreViewLayer?.frame = view.bounds
		cameraPreViewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
		
		view.layer.insertSublayer(cameraPreViewLayer!, at: 0)
		sessionn.startRunning()
	}
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destination.
	// Pass the selected object to the new view controller.
	}
	*/
	
}
