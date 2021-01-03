//
//  ReusableView.swift
//  Housing
//
//  Created by 오준현 on 2020/12/29.
//

import UIKit

protocol ReusableView: class {}

extension ReusableView where Self: UIView {
	static var reuseIdentifier: String {
		return String(describing: self)
	}
}
