//
//  UserService.swift
//  Housing
//
//  Created by 오준현 on 2021/01/11.
//

import Foundation

import Moya
import SwiftKeychainWrapper

enum DetailService {
	case homeDetail(id: Int)
}

extension DetailService: TargetType {
	
	private var token: String {
		return KeychainWrapper.standard.string(forKey: KeychainStorage.accessToken) ?? ""
	}
	
	public var baseURL: URL {
		return URL(string: "3.34.74.249:3000")!
	}
	
	var path: String {
		switch self {
		case let .homeDetail(id):
			return "/communication/detail/\(id)"
		}
	}
	
	var method: Moya.Method {
		switch self {
		case .homeDetail:
		return .get
		}
	}
	
	var sampleData: Data {
		return Data()
	}
	
	var task: Task {
		switch self {
		case .homeDetail(id: let id):
			return .requestPlain
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
