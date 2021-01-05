//
//  PromiseViewController.swift
//  Housing
//
//  Created by 김태훈 on 2021/01/01.
//

import UIKit

class PromiseViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .cyan
	}
  @IBAction func nextStep(_ sender: Any) {
    guard let cameraview : UIViewController =
            self.storyboard?.instantiateViewController(identifier: "cameraViewController")
            as? CameraWorkViewController
    else {
      return
    }
    let navigationController = UINavigationController(rootViewController: cameraview)
    self.navigationController?.pushViewController(cameraview, animated: true)
  }
}
