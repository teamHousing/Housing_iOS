//
//  Notice.swift
//  Housing
//
//  Created by 곽기곤's Mac on 2021/01/14.
//

import Foundation

//struct NoticeDetail: Codable {
//		let id: Int?
//		let noticeTitle, noticeContents: String?
//		let noticeYear, noticeMonth, noticeDay: Int?
//		let noticeTime: String?
//		let houseInfoID: Int?
//
//		enum CodingKeys: String, CodingKey {
//				case id
//				case noticeTitle = "notice_title"
//				case noticeContents = "notice_contents"
//				case noticeYear = "notice_year"
//				case noticeMonth = "notice_month"
//				case noticeDay = "notice_day"
//				case noticeTime = "notice_time"
//				case houseInfoID = "house_info_id"
//		}
//}

struct NoticeDetail: Codable {
		let id: Int?
		let noticeTitle, noticeContents: String?
		let noticeYear, noticeMonth, noticeDay: Int?
		let noticeTime: String?
		let houseInfoID: Int?
		let option: [String]?

		enum CodingKeys: String, CodingKey {
				case id
				case noticeTitle = "notice_title"
				case noticeContents = "notice_contents"
				case noticeYear = "notice_year"
				case noticeMonth = "notice_month"
				case noticeDay = "notice_day"
				case noticeTime = "notice_time"
				case houseInfoID = "house_info_id"
				case option
		}
}
