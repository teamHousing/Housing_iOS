//
//  Calendar.swift
//  Housing
//
//  Created by 오준현 on 2021/01/12.
//

struct CalendarData: Codable {
		let notice, issue: [Calendar]
}

struct Calendar: Codable {
	let isNotice, id, category: Int
	let solutionMethod: String
	let year, month, day: Int
	let time, title, contents: String
	
	enum CodingKeys: String, CodingKey {
		case isNotice, id, category
		case solutionMethod = "solution_method"
		case year, month, day, time, title, contents
	}
	
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		isNotice = (try? values.decode(Int.self, forKey: .isNotice)) ?? 0
		id = (try? values.decode(Int.self, forKey: .id)) ?? 0
		category = (try? values.decode(Int.self, forKey: .category)) ?? 0
		solutionMethod = (try? values.decode(String.self, forKey: .solutionMethod)) ?? ""
		year = (try? values.decode(Int.self, forKey: .year)) ?? 0
		month = (try? values.decode(Int.self, forKey: .month)) ?? 0
		day = (try? values.decode(Int.self, forKey: .day)) ?? 0
		time = (try? values.decode(String.self, forKey: .time)) ?? ""
		title = (try? values.decode(String.self, forKey: .title)) ?? ""
		contents = (try? values.decode(String.self, forKey: .contents)) ?? ""
	}
}

struct FSCalendarModel: Codable {
	let isNotice, id, category: Int
	let solutionMethod: String
	let time, title, contents: String
}
