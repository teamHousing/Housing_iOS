//
//  CALayer+.swift
//  Housing
//
//  Created by 오준현 on 2020/12/29.
//

import UIKit

extension CALayer {
	func applyShadow(
		color: UIColor = .black,
		alpha: Float = 0.5,
		x: CGFloat = 0,
		y: CGFloat = 10,
		blur: CGFloat = 4
	) {
		shadowColor = color.cgColor
		shadowOpacity = alpha
		shadowOffset = CGSize(width: x, height: y)
		shadowRadius = blur / 1.0
	}
}
