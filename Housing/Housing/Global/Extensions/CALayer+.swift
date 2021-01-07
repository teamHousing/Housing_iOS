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
	
	func applyCardShadow(
		color: UIColor = .black,
		alpha: Float = 0.1,
		x: CGFloat = 0,
		y: CGFloat = 0,
		blur: CGFloat = 8
	) {
		shadowColor = color.cgColor
		shadowOpacity = alpha
		shadowOffset = CGSize(width: x, height: y)
		shadowRadius = blur / 1.0
	}
}
