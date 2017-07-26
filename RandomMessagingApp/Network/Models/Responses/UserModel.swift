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

struct UserModel {
    var avatarUrl:String?
    var id:Int?
    var nickname:String?
}

extension UserModel:Mappable {
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        avatarUrl <- map["avatarUrl"]
        id        <- map["id"]
        nickname  <- map["nickname"]
    }
    
}
