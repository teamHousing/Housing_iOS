//
//  UICollectionView+.swift
//  Housing
//
//  Created by 오준현 on 2020/12/29.
//

import UIKit

extension UICollectionView {
	func dequeueCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
		guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier,
																				 for: indexPath) as? T else {
			fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
		}
		return cell
	}
}
