//
//  RequestDataModel.swift
//  Housing
//
//  Created by 김태훈 on 2021/01/02.
//

import Foundation
import UIKit

//MARK: 데이터 모델
class RequestDataModel {
	static let shared = RequestDataModel()
	var isPromiseNeeded: Bool = true
	var images: [UIImage]? = []
	var cartegory: RequestCartegory = .repair
	var title: String = ""
	var discription: String = ""
	var editionalRequest: String = ""
	var solution: String = ""
	var availableTimeList : [VisitDate] = []
	private init() {}
}
enum RequestCartegory {
	case repair
	case contract
	case rent
	case noise
	case question
	case etc
}
struct VisitDate {
	var date: String = ""
	var time: String = ""
}
