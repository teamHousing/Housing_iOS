//
//  Calendar.swift
//  Housing
//
//  Created by 오준현 on 2021/01/12.
//

import Foundation

struct Calendar: Codable {
		let id: Int
		let noticeYear, noticeMonth, noticeDay: Int?
		let noticeTitle, noticeTime: String?
		let userID, category: Int?
		let solutionMethod: String?
		let promiseYear, promiseMonth, promiseDay: Int?
		let issueTitle, issueContents, promiseTime: String?

		enum CodingKeys: String, CodingKey {
				case id
				case noticeYear = "notice_year"
				case noticeMonth = "notice_month"
				case noticeDay = "notice_day"
				case noticeTitle = "notice_title"
				case noticeTime = "notice_time"
				case userID = "user_id"
				case category
				case solutionMethod = "solution_method"
				case promiseYear = "promise_year"
				case promiseMonth = "promise_month"
				case promiseDay = "promise_day"
				case issueTitle = "issue_title"
				case issueContents = "issue_contents"
				case promiseTime = "promise_time"
		}
}

struct NoticeCalendar: Codable {
		let id, noticeYear, noticeMonth, noticeDay: Int
		let noticeTitle, noticeTime: String

		enum CodingKeys: String, CodingKey {
				case id
				case noticeYear = "notice_year"
				case noticeMonth = "notice_month"
				case noticeDay = "notice_day"
				case noticeTitle = "notice_title"
				case noticeTime = "notice_time"
		}
}

struct PromiseCalendar: Codable {
		let id, userID, category: Int
		let solutionMethod: String
		let promiseYear, promiseMonth, promiseDay: Int
		let issueTitle, issueContents, promiseTime: String

		enum CodingKeys: String, CodingKey {
				case id
				case userID = "user_id"
				case category
				case solutionMethod = "solution_method"
				case promiseYear = "promise_year"
				case promiseMonth = "promise_month"
				case promiseDay = "promise_day"
				case issueTitle = "issue_title"
				case issueContents = "issue_contents"
				case promiseTime = "promise_time"
		}
}

struct ModelFSCalendar: Codable {
		let id: Int
		let noticeTitle, noticeTime: String?
		let userID, category: Int?
		let solutionMethod: String?
		let issueTitle, issueContents, promiseTime: String?

		enum CodingKeys: String, CodingKey {
				case id
				case noticeTitle = "notice_title"
				case noticeTime = "notice_time"
				case userID = "user_id"
				case category
				case solutionMethod = "solution_method"
				case issueTitle = "issue_title"
				case issueContents = "issue_contents"
				case promiseTime = "promise_time"
		}
}

