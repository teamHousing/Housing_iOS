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
	
	func dequeueHeaderView<T: UICollectionReusableView>(forIndexPath indexPath: IndexPath) -> T {
		guard let view = dequeueReusableSupplementaryView(
			ofKind: UICollectionView.elementKindSectionHeader,
			withReuseIdentifier: T.reuseIdentifier,
			for: indexPath
		) as? T else {
			fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
		}
		return view
	}
	
	func dequeueFooterView<T: UICollectionReusableView>(forIndexPath indexPath: IndexPath) -> T {
		guard let view = dequeueReusableSupplementaryView(
			ofKind: UICollectionView.elementKindSectionFooter,
			withReuseIdentifier: T.reuseIdentifier,
			for: indexPath
		) as? T else {
			fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
		}
		return view
	}
}
