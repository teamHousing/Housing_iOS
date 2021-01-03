//
//  BaseViewController.swift
//  Housing
//
//  Created by 오준현 on 2021/01/01.
//

import UIKit

import RxSwift


class BaseViewController: UIViewController {

	let disposeBag = DisposeBag()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .white
	}
	
}
