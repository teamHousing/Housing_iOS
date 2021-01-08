//
//  UIDatePicker+.swift
//  Housing
//
//  Created by 김태훈 on 2021/01/07.
//

import Foundation
import UIKit

extension UIDatePicker {
	var textColor: UIColor? {
			set {
					setValue(newValue, forKeyPath: "textColor")
			}
			get {
					return value(forKeyPath: "textColor") as? UIColor
			}
		}
}
