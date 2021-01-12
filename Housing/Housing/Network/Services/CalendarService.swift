//
//  UserService.swift
//  Housing
//
//  Created by 오준현 on 2021/01/11.
//

import Foundation

import Moya
import SwiftKeychainWrapper

enum CalendarService {
	case calendar(select_year: Int, select_month: Int)
	case calendarNoticeDetail(notice_id: Int)
	case calendarIssueDetail(issue_id: Int)
}

extension CalendarService: TargetType {
	
	private var token: String {
//		return KeychainWrapper.standard.string(forKey: KeychainStorage.accessToken) ?? ""
		return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidHlwZSI6MCwiaWF0IjoxNjEwMzg1Mzc5LCJleHAiOjE2MTA0NzE3NzksImlzcyI6ImN5aCJ9.EVYa22pT-LClvr8NKid6ARXEIumn2BKa6mOyCLQJAqg"
	}
	
	public var baseURL: URL {
		return URL(string: "http://3.34.74.249:3000")!
	}
	
	var path: String {
		switch self {
		case .calendar:
			return "/calendar/month"
		case .calendarNoticeDetail:
			return "/calendar/notice-detail"
		case .calendarIssueDetail:
			return "/calendar/issue-detail"
		}
	}
	
	var method: Moya.Method {
		switch self {
		case .calendar,
				 .calendarNoticeDetail,
				 .calendarIssueDetail:
			return .post
		}
	}
	
	var sampleData: Data {
		return Data()
	}
	
	var task: Task {
		switch self {
		case .calendar(select_year: let select_year, select_month: let select_month):
			return .requestCompositeParameters(bodyParameters: ["select_year": select_year,
																													"select_month": select_month],
																				 bodyEncoding: JSONEncoding.default,
																				 urlParameters: .init())
		case .calendarNoticeDetail(notice_id: let notice_id):
			return .requestCompositeParameters(bodyParameters: ["notice_id": notice_id],
																				 bodyEncoding: JSONEncoding.default,
																				 urlParameters: .init())
		case .calendarIssueDetail(issue_id: let issue_id):
			return .requestCompositeParameters(bodyParameters: ["issue_id": issue_id],
																				 bodyEncoding: JSONEncoding.default,
																				 urlParameters: .init())
		}
	}
	
	var headers: [String : String]? {
		switch self {
		default:
			return ["Content-Type": "application/json",
							"jwt": token]
		}
	}
}
