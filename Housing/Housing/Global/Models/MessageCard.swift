//
//  MessageCard.swift
//  Housing
//
//  Created by 노한솔 on 2021/01/07.
//

import Foundation

struct MessageCard {
	var title: String
	var context: String
	var buttonTitle: String
	
	init(title: String, context: String, buttonTitle: String){
		self.title = title
		self.context = context
		self.buttonTitle = buttonTitle
	}
}
