//
//  UserService.swift
//  Housing
//
//  Created by 오준현 on 2021/01/11.
//

import Foundation

import Moya
import SwiftKeychainWrapper

enum PromiseService {
	case homePromise(is_promise: Bool,
									 category: Int,
									 issue_title: String,
									 issue_contents: String,
									 requested_term: String)
	case homePromiseTimeList(id: Int)
	case homePromiseConfirm(id: Int, promise_option: [String])
	case homePromiseHostModify(id: Int)
	case homePromiseGuestModify(id: Int, promise_option: [String])
	case homePromiseComplete(id: Int)
}

extension PromiseService: TargetType {
	
	private var token: String {
		return KeychainWrapper.standard.string(forKey: KeychainStorage.accessToken) ?? ""
	}
	
	public var baseURL: URL {
		return URL(string: "http://3.34.74.249:3000")!
	}
	
	var path: String {
		switch self {
		case .homePromise:
			return "/communication"
		case let .homePromiseTimeList(id):
			return "/communication/\(id)/promise-option"
		case let .homePromiseConfirm(id, promise_option):
			return "/communication/\(id)/promise"
		case let .homePromiseHostModify(id):
			return "/communication/\(id)/request/promise-option"
		case let .homePromiseGuestModify(id):
			return "/communication/\(id)/request/promise-option"
		case .homePromiseComplete:
			return "/communication/"
		}
	}
	
	var method: Moya.Method {
		switch self {
		case .homePromise,
				 .homePromiseConfirm:
			return .post
		case .homePromiseTimeList,
				 .homePromiseHostModify,
				 .homePromiseComplete:
			return .get
		case .homePromiseGuestModify:
			return .put
		}
	}
	
	var sampleData: Data {
		return Data()
	}
	
	var task: Task {
		switch self {
		case .homePromise(is_promise: let is_promise, category: let category, issue_title: let issue_title, issue_contents: let issue_contents, requested_term: let requested_term):
			return .requestCompositeParameters(bodyParameters: ["is_promise": is_promise,
																													"category": category,
																													"issue_title": issue_title,
																													"issue_contents": issue_contents,
																													"requested_term": requested_term],
																				 bodyEncoding: JSONEncoding.default,
																				 urlParameters: .init())
		case .homePromiseTimeList(id: let id):
			return .requestPlain

		case .homePromiseConfirm(id: let id,
														 promise_option: let promise_option):
//			let dict = promise_option.map{["data" : $0.date, "time" : $0.time , "method" : $0.method]}

			return .requestCompositeParameters(bodyParameters: ["promise_option": promise_option],
																				 bodyEncoding: JSONEncoding.default,
																				 urlParameters: ["id": id])
		case .homePromiseHostModify(id: let id):
			return .requestPlain
			
		case .homePromiseGuestModify(id: let id, promise_option: let promise_option):
			
			return .requestCompositeParameters(bodyParameters: ["promise_option": promise_option],
																				 bodyEncoding: JSONEncoding.default,
																				 urlParameters: ["id": id])
		case .homePromiseComplete(id: let id):
			return .requestCompositeParameters(bodyParameters: .init(),
																				 bodyEncoding: JSONEncoding.default,
																				 urlParameters: ["id": id])
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
