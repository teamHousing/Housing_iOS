//
//  UserService.swift
//  Housing
//
//  Created by 오준현 on 2021/01/11.
//

import Foundation

import Moya
import SwiftKeychainWrapper

enum CommunicationService {
	case home(unit: String)
	case homeRoomList
}

extension CommunicationService: TargetType {
	
	private var token: String {
		return KeychainWrapper.standard.string(forKey: KeychainStorage.accessToken) ?? ""
	}
	
	public var baseURL: URL {
		return URL(string: "http://3.34.74.249:3000")!
	}
	
	var path: String {
		switch self {
		case let .home(unit):
			return "/communication/\(unit)"
		case .homeRoomList:
			return "/houseInfo/unit"
		}
	}

	var method: Moya.Method {
		switch self {
		case .home,
				 .homeRoomList:
		return .get
		}
	}
	
	var sampleData: Data {
		return Data()
	}
	
	var task: Task {
		switch self {
		case .home(unit: let unit):
			return .requestCompositeParameters(bodyParameters: .init(),
																				 bodyEncoding: JSONEncoding.default,
																				 urlParameters: ["unit": unit])
		case .homeRoomList:
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
	
