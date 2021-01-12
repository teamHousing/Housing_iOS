//
//  UserService.swift
//  Housing
//
//  Created by 오준현 on 2021/01/11.
//

import Foundation

import Moya
import SwiftKeychainWrapper

enum NoticeService {
	case profile
	case profileNoticeDetail(id: Int)
	case profileNoticeAdmit(house_info_id: Int,
													notice_title: String,
													notice_contents: String,
													notice_option: [noticeOption])
	case profileAuthorization(building: String, unit: Int)
}

struct noticeOption : Codable {
	private enum CodingKeys : String, CodingKey {
		case date = "date"
		case day = "day"
		case time = "time"
	}
	let date, day, time: String?
}


extension NoticeService: TargetType {
	
	private var token: String {
		return KeychainWrapper.standard.string(forKey: KeychainStorage.accessToken) ?? ""
	}
	
	public var baseURL: URL {
		return URL(string: "http://3.34.74.249:3000")!
	}
	
	var path: String {
		switch self {
		case .profile:
			return "/houseInfo"
		case let .profileNoticeDetail(id):
			return "/houseInfo/\(id)/notice"
		case let .profileNoticeAdmit(house_info_id):
			return "/houseInfo/\(house_info_id)/notice"
		case .profileAuthorization:
			return "/authentication/number"
		}
	}
	
	var method: Moya.Method {
		switch self {
		case .profileNoticeAdmit,
				 .profileAuthorization:
			return .post
		case .profile,
				 .profileNoticeDetail:
		return .get
		}
	}
	
	var sampleData: Data {
		return Data()
	}
	
	var task: Task {
		switch self {
		case .profile:
			return .requestPlain
		case .profileNoticeDetail(id: let id):
			return .requestCompositeParameters(bodyParameters: .init(),
																				 bodyEncoding: JSONEncoding.default,
																				 urlParameters: ["id": id])
		case .profileNoticeAdmit(house_info_id: let house_info_id,
														 notice_title: let notice_title,
														 notice_contents: let notice_contents,
														 notice_option: let notice_option):
			return .requestCompositeParameters(bodyParameters: ["notice_title": notice_title,
																													"notice_contents": notice_contents,
																													"notice_option": [[
																														"date " : notice_option.first?.date,
																														"day" :  notice_option.first?.day,
																														"time" :  notice_option.first?.time
																										]]],
																				 bodyEncoding: JSONEncoding.default,
																				 urlParameters: ["house_info_id": house_info_id])
		case .profileAuthorization(building: let building, unit: let unit):
			return .requestCompositeParameters(bodyParameters: ["building": building, "unit": unit],
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
