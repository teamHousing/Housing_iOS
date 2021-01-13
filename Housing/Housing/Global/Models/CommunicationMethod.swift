//
//  CommunicationMethod.swift
//  Housing
//
//  Created by 노한솔 on 2021/01/05.
//

import Foundation

struct CommunicationMethod : Codable {
	var date: String
	var time: String
	var method: String
	private enum CodingKeys : String, CodingKey {
		case date = "date"
		case time = "time"
		case method = "method"
	}
	init(date: String, time: String, method: String){
		self.date = date
		self.time = time
		self.method = method
	}
}
