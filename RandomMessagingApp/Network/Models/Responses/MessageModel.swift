//
//  MessageModel.swift
//  RandomMessagingApp
//
//  Created by Yusuf Miletli on 7/26/17.
//  Copyright © 2017 Miletli. All rights reserved.
//

//{
//    "id":1,
//    "text":"Good luck!",
//    "timestamp":1485245768,
//    "user":{}
//}

import ObjectMapper

class MessageModel:BaseResponse {
    var id:Int?
    var text:String?
    var timestamp:Int?
    var user:UserModel?
	
	required init?(map: Map) {
		super.init(map: map)
	}
	
	override func mapping(map: Map) {
		id <- map["id"]
		text <- map["text"]
		timestamp <- map["timestamp"]
		user <- map["user"]
	}
	
	override class func newInstance(_ jsonString: String)-> AnyObject? {
		return Mapper<MessageModel>().map(JSONString: jsonString)
	}
}
