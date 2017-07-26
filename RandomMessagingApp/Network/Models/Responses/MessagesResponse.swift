//
//  MessagesResponse.swift
//  RandomMessagingApp
//
//  Created by Yusuf Miletli on 26/07/2017.
//  Copyright © 2017 Miletli. All rights reserved.
//

import ObjectMapper

class MessagesResponse: BaseResponse {
	
	var messages:[MessageModel]?
	
	required init?(map: Map) {
		super.init(map: map)
	}
	
	override func mapping(map: Map) {
		messages <- map["messages"]
	}
	
	override class func newInstance(_ jsonString: String)-> AnyObject? {
		return Mapper<MessagesResponse>().map(JSONString: jsonString)
	}

	
}
