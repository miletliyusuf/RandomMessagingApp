//
//  UserModel.swift
//  RandomMessagingApp
//
//  Created by Yusuf Miletli on 7/26/17.
//  Copyright © 2017 Miletli. All rights reserved.
//

//{
//    "avatarUrl":"https://randomuser.me/api/portraits/med/men/83.jpg",
//    "id":0,
//    "nickname":"Mark"
//}

import ObjectMapper

class UserModel {
    var avatarUrl:String?
    var id:Int?
    var nickname:String?
	
	required init?(map: Map) {
		
	}
	
	func mapping(map: Map) {
		avatarUrl <- map["avatarUrl"]
		id        <- map["id"]
		nickname  <- map["nickname"]
	}
    
    init(avatarUrl:String,id:Int,nickname:String) {
        self.avatarUrl = avatarUrl
        self.id = id
        self.nickname = nickname
    }
}
