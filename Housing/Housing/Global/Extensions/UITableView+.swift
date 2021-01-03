//
//  UITableView+.swift
//  Housing
//
//  Created by 오준현 on 2020/12/29.
//

import UIKit

extension UITableView {
	func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
		guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier,
																				 for: indexPath) as? T else {
			fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
		}
		
		return cell
	}
}
