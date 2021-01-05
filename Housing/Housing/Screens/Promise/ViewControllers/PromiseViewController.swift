//
//  PromiseViewController.swift
//  Housing
//
//  Created by 김태훈 on 2021/01/01.
//

import UIKit

import Then
import SnapKit
class PromiseViewController: UIViewController {
	private let backButton = UIButton().then{
		$0.backgroundColor = .white
		$0.addTarget(self, action: #selector(backButtonDidTab), for: .touchUpInside)
	}
	private let backgroundLabel = UILabel().then{
		$0.text = "무슨 일이 생겼나요?"
		$0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 26)
		$0.textColor = .black
		$0.textAlignment = .left
	}
	private let lineImage = UIView().then {
		$0.backgroundColor = UIColor.primaryBlack
		$0.tintColor = UIColor.primaryBlack
		}
	private let solutionLabel = UILabel().then{
		$0.text = "해결을 위해서는"
		$0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
		$0.textColor = .black
		$0.textAlignment = .left
	}

	private let requestTypeLabel = UILabel().then{
		$0.text = "어떤 종류의 문제인가요?"
		$0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 26)
	}
	private let message = UILabel().then{
		$0.text = "집주인께 문의를 남겨주세요"
		$0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 26)
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
		self.navigationController?.navigationBar.backgroundColor = .white
		self.view.backgroundColor = .white
		self.view.adds([
		backgroundLabel,
		lineImage,
		solutionLabel])
		backgroundLabel.snp.makeConstraints{
			$0.top.equalTo(view.safeAreaLayoutGuide).offset(0)
			$0.leading.equalTo(view).offset(widthConstraintAmount(value: 20))
			$0.trailing.equalTo(view).offset(widthConstraintAmount(value: 152))
		}
		lineImage.snp.makeConstraints{
			$0.top.equalTo(view.safeAreaLayoutGuide).offset(66)
			$0.trailing.equalTo(view.safeAreaLayoutGuide).offset(0)
			$0.leading.equalTo(backgroundLabel.snp.trailing).offset(8)
			$0.height.equalTo(1)
			$0.width.equalTo(widthConstraintAmount(value: widthConstraintAmount(value: 144)))
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .cyan
		layout()
	}
//  @IBAction func nextStep(_ sender: Any) {
////    guard let cameraview : UIViewController =
////            self.storyboard?.instantiateViewController(identifier: "cameraViewController")
////            as? CameraWorkViewController
////    else {
////      return
////    }
//		let cameraView = CameraWorkViewController()
//    let navigationController = UINavigationController(rootViewController: cameraView)
//    self.navigationController?.pushViewController(cameraView, animated: true)
//  }
	@objc
	func backButtonDidTab() {
		self.dismiss(animated: true, completion: nil)
	}
}
