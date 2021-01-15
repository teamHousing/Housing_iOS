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
	case validation(number: Int)
	case hostSignup(userName: String, age: Int, email: String,
									password: String, address: String, building: String)
	case guestSignup(number: Int, userName: String, age: Int, email: String, password: String)
}

extension UserService: TargetType {
	
	private var token: String {
		return KeychainWrapper.standard.string(forKey: KeychainStorage.accessToken) ?? ""
	}
	
	public var baseURL: URL {
		return URL(string: "http://3.34.74.249:3000")!
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
		case .hostSignup(userName: let userName, age: let age, email: let email,
										 password: let password, address: let address, building: let building):
			return .requestCompositeParameters(bodyParameters: ["user_name": userName, "age": age,
																													"email": email, "password": password,
																													"address": address, "building": building],
																				 bodyEncoding: JSONEncoding.default, urlParameters: .init())
		case .guestSignup(number: let number, userName: let userName, age: let age,
											email: let email, password: let password):
			return .requestCompositeParameters(bodyParameters: [
				"authentication_number": number,
				"user_name": userName,
				"age": age,
				"email": email,
				"password": password
			],
			bodyEncoding: JSONEncoding.default,
			urlParameters: .init())
		case .validation(number: let number):
			return .requestCompositeParameters(bodyParameters: ["authentication_number": number],
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
