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
	case profileAuthorization(unit: Int)
	case deleteNotice(id: Int)
}

struct MyInfo: Codable {
		let houseInfo: HouseInfo
		let notice: [Notice]
}

struct HouseInfo: Codable {
	let hopeTime: [String]
	let id: Int
	let ownerName, profileMessage: String
	let profileImg: String
	let responseTime: String
	
	enum CodingKeys: String, CodingKey {
		case hopeTime = "hope_time"
		case id
		case ownerName = "owner_name"
		case profileMessage = "profile_message"
		case profileImg = "profile_img"
		case responseTime = "response_time"
	}
}

// MARK: - Notice
struct Notice: Codable {
	let id: Int
	let noticeTitle, noticeContents: String
	
	enum CodingKeys: String, CodingKey {
		case id
		case noticeTitle = "notice_title"
		case noticeContents = "notice_contents"
	}
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
		case let .profileNoticeAdmit(house_info_id,_,_,_):
			return "/houseInfo/\(house_info_id)/notice"
		case .profileAuthorization:
			return "/authentication/number"
		case let .deleteNotice(id):
			return "/houseInfo/notice/\(id)"
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
		case .deleteNotice:
			return .delete
		}
	}
	
	var sampleData: Data {
		return Data()
	}
	
	var task: Task {
		switch self {
		case .profile:
			return .requestPlain
		case .profileNoticeDetail(id: _):
			return .requestPlain
		case .profileNoticeAdmit(house_info_id: let house_info_id,
														 notice_title: let notice_title,
														 notice_contents: let notice_contents,
														 notice_option: let notice_option):
			let dict = notice_option.map{["date" : $0.date, "day" : $0.day , "time" : $0.time]}

			return .requestCompositeParameters(bodyParameters: ["notice_title": notice_title,
																													"notice_contents": notice_contents,
																													"notice_option": dict],
																				 bodyEncoding: JSONEncoding.default,
																				 urlParameters: ["house_info_id": house_info_id])
		case .profileAuthorization(unit: let unit):
			return .requestCompositeParameters(bodyParameters: ["unit": unit],
																				 bodyEncoding: JSONEncoding.default,
																				 urlParameters: .init())
		case .deleteNotice(id: _):
			return .requestPlain
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
