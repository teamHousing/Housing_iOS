//
//  UserService.swift
//  Housing
//
//  Created by 오준현 on 2021/01/11.
//

import Foundation
import UIKit
import Moya
import SwiftKeychainWrapper

enum PromiseService {
	case homePromise(id: Int,
									 is_promise: Bool,
									 category: Int,
									 issue_title: String,
									 issue_contents: String,
									 requested_term: String)
	case homePromiseTimeList(id : Int)
	case homePromiseConfirm(id: Int, promise_option: [String])
	case homePromiseHostModify(id: Int)
	case homePromiseGuestModify(id: Int, promise_option: [[String]])
	case homePromiseComplete(id: Int)
	case homePromiseImageUpload(issue_img : [UIImage])
	case homePromiseGuestRegister(id : Int, promise_option:[[String]])
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
		case .homePromiseComplete:
			return "/communication/"
		case let .homePromise(id,_,_,_,_,_):
			return "/communication/\(id)"
		case let .homePromiseTimeList(id):
			return "/communication/\(id)/promise-option"
		case let .homePromiseConfirm(id, _):
			return "/communication/\(id)/promise"
		case let .homePromiseHostModify(id):
			return "/communication/\(id)/request/promise-option"
		case let .homePromiseGuestModify(id, _):
			return "/communication/\(id)/promise-option"
		case .homePromiseImageUpload(_) :
			return "/communication/image"
		case let .homePromiseGuestRegister(id, _) :
			return "/communication/\(id)/promise-option"
		}
	}
	
	var method: Moya.Method {
		switch self {
		case .homePromise,
				 .homePromiseImageUpload,
				 .homePromiseConfirm,
				 .homePromiseGuestRegister:
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
		case .homePromise(id: let id,
											is_promise: let is_promise,
											category: let category,
											issue_title: let issue_title,
											issue_contents: let issue_contents,
											requested_term: let requested_term):
			return .requestCompositeParameters(bodyParameters: ["is_promise": is_promise,
																													"category": category,
																													"issue_title": issue_title,
																													"issue_contents": issue_contents,
																													"requested_term": requested_term],
																				 bodyEncoding: JSONEncoding.default,
																				 urlParameters: ["id": id])
		case .homePromiseTimeList:
			return .requestPlain

		case .homePromiseConfirm(id: let id,
														 promise_option: let promise_option):
//			let dict = promise_option.map{["data" : $0.date, "time" : $0.time , "method" : $0.method]}

			return .requestCompositeParameters(bodyParameters: ["promise_option": promise_option],
																				 bodyEncoding: JSONEncoding.default,
																				 urlParameters: ["id": id])
		case .homePromiseHostModify:
			return .requestPlain
			
		case .homePromiseGuestModify(id: let id, promise_option: let promise_option):
			
			return .requestCompositeParameters(bodyParameters: ["promise_option": promise_option],
																				 bodyEncoding: JSONEncoding.default,
																				 urlParameters: ["id": id])
		case .homePromiseComplete(id: let id):
			return .requestCompositeParameters(bodyParameters: .init(),
																				 bodyEncoding: JSONEncoding.default,
																				 urlParameters: ["id": id])
		case .homePromiseImageUpload(issue_img : let issue_img) :
			if issue_img.count != 0 {
				let data: [Data] = issue_img.map{ $0.jpegData(compressionQuality: 0.3)! }
				let multipart : [MultipartFormData] = data.map { element in
					return MultipartFormData(provider: .data(element),
																	 name: "issue_img",
																	 fileName: "file.jpeg",
																	 mimeType: "image/jpeg")
				}
				return .uploadMultipart(multipart)
			} else {
				let multipart = MultipartFormData(provider: .data(Data()),
																					name: "issue_img")
				return .uploadMultipart([multipart])
			}
			
		case .homePromiseGuestRegister(id: let id, promise_option: let promise_option):
			return .requestCompositeParameters(bodyParameters: ["promise_option": promise_option],
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
