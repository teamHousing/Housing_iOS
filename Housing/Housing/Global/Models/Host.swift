//
//  Host.swift
//  Housing
//
//  Created by 곽기곤's Mac on 2021/01/13.
//

import Foundation

struct Host: Codable {
		let userName: String?
		let age: Int?
		let email, password, address, building: String?

		enum CodingKeys: String, CodingKey {
				case userName = "user_name"
				case age, email, password, address, building
		}
}
