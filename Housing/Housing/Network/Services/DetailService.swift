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
	case confirmDetail(id: Int)
	case deleteDetail(id: Int)
}

extension DetailService: TargetType {
	
	private var token: String {
		return KeychainWrapper.standard.string(forKey: KeychainStorage.accessToken) ?? ""
	}
	
	public var baseURL: URL {
		return URL(string: "http://3.34.74.249:3000")!
	}
	
	var path: String {
		switch self {
		case let .homeDetail(id):
			return "/communication/detail/\(id)"
		case let .confirmDetail(id):
			return "/communication/\(id)/complete/promise"
		case let .deleteDetail(id):
			return "/communication/promise/\(id)"
		}
	}
	
	var method: Moya.Method {
		switch self {
		case .homeDetail:
			return .get
		case .confirmDetail:
			return .get
		case .deleteDetail:
			return .delete
		}
	}
	
	var sampleData: Data {
		return Data()
	}
	
	var task: Task {
		switch self {
		case .homeDetail(id: let id):
			return .requestPlain
		case .confirmDetail(id: let id):
			return .requestPlain
		case .deleteDetail(id: let id):
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
