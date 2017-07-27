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

class UserModel:BaseResponse,NSCoding {
    var avatarUrl:String?
    var id:Int?
    var nickname:String?
	
	required init?(map: Map) {
		super.init(map: map)
	}
	
	override func mapping(map: Map) {
        super.mapping(map: map)
		avatarUrl <- map["avatarUrl"]
		id        <- map["id"]
		nickname  <- map["nickname"]
	}
    
    init(avatarUrl:String,id:Int,nickname:String) {
        super.init()
        self.avatarUrl = avatarUrl
        self.id = id
        self.nickname = nickname
    }
	
	required convenience init(coder aDecoder: NSCoder) {
		let avatarUrl = aDecoder.decodeObject(forKey: "avatarUrl") as! String
		let id:Int = aDecoder.decodeObject(forKey: "id") as! Int
		let nickname = aDecoder.decodeObject(forKey: "nickname") as! String
		
		self.init(avatarUrl: avatarUrl, id: id, nickname: nickname)
	}
	
	func encode(with aCoder: NSCoder) {
		aCoder.encode(avatarUrl, forKey: "avatarUrl")
		aCoder.encode(id, forKey: "id")
		aCoder.encode(nickname, forKey: "nickname")
	}
}
