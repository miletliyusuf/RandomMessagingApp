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

struct MessageModel {
    var id:Int?
    var text:String?
    var timestamp:Int?
    var user:UserModel?
}

extension MessageModel:Mappable {
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        text <- map["text"]
        timestamp <- map["timestamp"]
        user <- map["user"]
    }
    
}
