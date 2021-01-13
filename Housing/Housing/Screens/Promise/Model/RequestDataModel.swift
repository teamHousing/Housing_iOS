//
//  RequestDataModel.swift
//  Housing
//
//  Created by 김태훈 on 2021/01/02.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

//MARK: 데이터 모델
class RequestDataModel {
	static let shared = RequestDataModel()
	var isPromiseNeeded: Bool = true
	var images: [UIImage]? = []
	var cartegory: Int = 0
	var title: String = ""
	var discription: String = ""
	var editionalRequest: String = ""
	var solution: String = ""
	var date: BehaviorSubject<String> = BehaviorSubject(value: "")
	var startTime:  BehaviorSubject<String> = BehaviorSubject(value: "")
	var endTime:  BehaviorSubject<String> = BehaviorSubject(value: "")
	var availableTimeList : [VisitDate] = []
	private init() {}
}
struct VisitDate {
	var day: String = ""
	var date: String = ""
	var startTime: String = ""
	var endTime: String = ""
}
