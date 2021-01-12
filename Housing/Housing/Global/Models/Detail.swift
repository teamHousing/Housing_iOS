//
//  Detail.swift
//  Housing
//
//  Created by 노한솔 on 2021/01/12.
//

import Foundation

struct Detail: Codable {
	let id: Int
	let issueImages: [String]?
	let promiseOption: [[String]]?
	let category: Int?
	let issueTitle, issueContents: String?
	let progress: Int?
	let requestedTerm: String?
	let promiseYear, promiseMonth, promiseDay: Int?
	let promiseTime, solutionMethod: String?
	let confirmedPromiseOption: [String]?
	let replies : [DetailStatus]?
	
	enum CodingKeys: String, CodingKey {
		case id
		case issueImages = "issue_img"
		case promiseOption = "promise_option"
		case category
		case issueTitle = "issue_title"
		case issueContents = "issue_contents"
		case progress
		case requestedTerm = "requested_term"
		case promiseYear = "promise_year"
		case promiseMonth = "promise_month"
		case promiseDay = "promise_day"
		case promiseTime = "promise_time"
		case solutionMethod = "solution_method"
		case confirmedPromiseOption = "confirmation_promise_option"
		case replies = "Replies"
	}
	
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = (try? values.decode(Int.self, forKey: .id)) ?? 0
		issueImages = (try? values.decode([String].self, forKey: .issueImages)) ?? [""]
		promiseOption = (try? values.decode([[String]].self, forKey: .promiseOption)) ?? [[""]]
		category = (try? values.decode(Int.self, forKey: .category)) ?? 0
		issueTitle = (try? values.decode(String.self, forKey: .issueTitle)) ?? ""
		issueContents = (try? values.decode(String.self, forKey: .issueContents)) ?? ""
		progress = (try? values.decode(Int.self, forKey: .progress)) ?? 0
		requestedTerm = (try? values.decode(String.self, forKey: .requestedTerm)) ?? ""
		promiseYear = (try? values.decode(Int.self, forKey: .promiseYear)) ?? 0
		promiseMonth = (try? values.decode(Int.self, forKey: .promiseMonth)) ?? 0
		promiseDay = (try? values.decode(Int.self, forKey: .promiseDay)) ?? 0
		promiseTime = (try? values.decode(String.self, forKey: .promiseTime)) ?? ""
		solutionMethod = (try? values.decode(String.self, forKey: .solutionMethod)) ?? ""
		confirmedPromiseOption = (try? values.decode([String].self, forKey: .confirmedPromiseOption)) ?? [""]
		replies = (try? values.decode([DetailStatus].self, forKey: .replies)) ?? [DetailStatus.init(ownerStatus: [0], id: 0)]
	}
}

struct DetailStatus: Codable {
	let ownerStatus: [Int]?
	let id: Int
	
	enum CodinKeys: String, CodingKey {
		case ownerStatus = "owner_status"
		case id
	}
}

struct DetailModel: Codable {
	let id: Int
	let issueImages: [String]?
	let promiseOption: [[String]]?
	let category: Int?
	let issueTitle, issueContents: String?
	let progress: Int?
	let requestedTerm: String?
	let promiseYear, promiseMonth, promiseDay: Int?
	let promiseTime, solutionMethod: String?
	let confirmedPromiseOption: [String]?
	
	enum CodingKeys: String, CodingKey {
		case id
		case issueImages = "issue_img"
		case promiseOption = "promise_option"
		case category
		case issueTitle = "issue_title"
		case issueContents = "issue_contents"
		case progress
		case requestedTerm = "requested_term"
		case promiseYear = "promise_year"
		case promiseMonth = "promise_month"
		case promiseDay = "promise_day"
		case promiseTime = "promise_time"
		case solutionMethod = "solution_method"
		case confirmedPromiseOption = "confirmation_promise_option"
	}
}
