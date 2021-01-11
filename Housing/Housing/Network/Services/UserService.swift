//
//  UserService.swift
//  Housing
//
//  Created by 오준현 on 2021/01/11.
//

import Foundation

import Moya
import SwiftKeychainWrapper

enum UserService {
	case signin(email: String, password: String)
	case hostSignup
	case guestSignup
}

extension UserService: TargetType {
	
	private var token: String {
		return KeychainWrapper.standard.string(forKey: KeychainStorage.accessToken) ?? ""
	}
	
	public var baseURL: URL {
		return URL(string: "")!
	}
	
	var path: String {
		switch self {
		case .signin:
			return ""
		case .hostSignup:
			return ""
		case .guestSignup:
			return ""
		}
	}
	
	var method: Moya.Method {
		switch self {
		case .signin,
				 .hostSignup,
				 .guestSignup:
			return .post
		}
	}
	
	var sampleData: Data {
		return Data()
	}
	
	var task: Task {
		switch self {
//		case .goal:
//			return .requestPlain
//		case .saveGoal(targetDate: let targetDate, targetLevel: let targetLevel):
//			return .requestCompositeParameters(bodyParameters: [
//				"targetDate": targetDate,
//				"targetLevel": targetLevel
//			],
//			bodyEncoding: JSONEncoding.default,
//			urlParameters: .init())
//		case .fetchGoal(targetDate: let targetDate, targetLevel: let targetLevel):
//			return .requestCompositeParameters(bodyParameters: [
//				"targetDate": targetDate,
//				"targetLevel": targetLevel
//			],
//			bodyEncoding: JSONEncoding.default,
//			urlParameters: .init())
//		case .fetchQuestGoal(one: let one, two: let two, three: let three,
//												 four: let four, five: let five, six: let six):
//			return .requestCompositeParameters(bodyParameters: [
//				"partOne": one,
//				"partTwo": two,
//				"partThree": three,
//				"partFour": four,
//				"partFive": five,
//				"partSix": six
//			],
//			bodyEncoding: JSONEncoding.default,
//			urlParameters: .init())
		case .signin(email: let email, password: let password):
			return .requestCompositeParameters(bodyParameters: ["email": email, "password": password],
																				 bodyEncoding: JSONEncoding.default,
																				 urlParameters: .init())
		case .hostSignup:
			return .requestPlain
		case .guestSignup:
			return .requestPlain
		}
	}
	
	var headers: [String : String]? {
		switch self {
		default:
			return ["Content-Type": "application/json",
							"token": token]
		}
	}
}
