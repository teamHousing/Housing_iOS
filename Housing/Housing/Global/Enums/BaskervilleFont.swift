//
//  BaskervileFont.swift
//  Housing
//
//  Created by 오준현 on 2021/01/03.
//

import UIKit

enum BaskervilleFont: String {
	
	case bold = "Baskerville Bold"
	
	func of(size: CGFloat) -> UIFont {
		
		guard let font = UIFont(name: self.rawValue, size: size) else {
			return .systemFont(ofSize: size)
		}
		
		return font
	}
}
