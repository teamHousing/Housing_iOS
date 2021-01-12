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
	case validation
	case hostSignup
	case guestSignup
}

extension UserService: TargetType {
	
	private var token: String {
		return KeychainWrapper.standard.string(forKey: KeychainStorage.accessToken) ?? ""
	}
	
	public var baseURL: URL {
		return URL(string: "3.34.74.249:3000")!
	}
	
	var path: String {
		switch self {
		case .signin:
			return "/user/login"
		case .hostSignup:
			return "/user/registration/0"
		case .guestSignup:
			return "/user/registration/1"
		case .validation:
			return "/authentication/confirm"
		}
	}
	
	var method: Moya.Method {
		switch self {
		case .signin,
				 .hostSignup,
				 .guestSignup,
				 .validation:
			return .post
		}
	}
	
	var sampleData: Data {
		return Data()
	}
	
	var task: Task {
		switch self {
		
		case .signin(email: let email, password: let password):
			return .requestCompositeParameters(bodyParameters: ["email": email, "password": password],
																				 bodyEncoding: JSONEncoding.default,
																				 urlParameters: .init())
		case .hostSignup:
			return .requestPlain
		case .guestSignup:
			return .requestPlain
		case .validation:
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
