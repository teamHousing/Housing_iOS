//
//  ResponseType.swift
//  Housing
//
//  Created by 오준현 on 2021/01/12.
//

import Foundation

struct ResponseArrayType<T: Codable>: Codable {
		var status: Int?
		var success: Bool?
		var message: String?
		var data: [T]?
}

struct ResponseType<T: Codable>: Codable {
		var status: Int?
		var success: Bool?
		var message: String?
		var data: T?
}

struct Response: Codable {
		var status: Int?
		var success: Bool?
		var message: String?
}
