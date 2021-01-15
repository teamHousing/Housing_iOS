//
//  promiseId.swift
//  Housing
//
//  Created by 김태훈 on 2021/01/14.
//

import Foundation
import UIKit
class promiseId {
	static let shared = promiseId()
	var id = 1
	var unit : String = ""
	private init() {}
}
