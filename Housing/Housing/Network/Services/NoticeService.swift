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
													notice_content: String,
													notice_option: [noticeOption])
	case profileAuthorization(building: String, unit: Int)
}

struct noticeOption {
	var date, day, time: String
}

extension NoticeService: TargetType {
	
	private var token: String {
		return KeychainWrapper.standard.string(forKey: KeychainStorage.accessToken) ?? ""
	}
	
	public var baseURL: URL {
		return URL(string: "3.34.74.249:3000")!
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
			return "/athentication/number"
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
														 notice_content: let notice_content,
														 notice_option: let notice_option):
			return .requestCompositeParameters(bodyParameters: ["notice_title": notice_title,
																													"notice_content": notice_content,
																													"notice_option": notice_option],
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
							"user_token": token]
		}
	}
}
