//
//  timeOptions.swift
//  Housing
//
//  Created by 김태훈 on 2021/01/14.
//

import Foundation
struct noticeOption : Codable {
	private enum CodingKeys : String, CodingKey {
		case date = "date"
		case day = "day"
		case time = "time"
	}
	let date, day, time: String?
}
