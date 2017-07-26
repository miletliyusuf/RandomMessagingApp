//
//  BaseResponse.swift
//  RandomMessagingApp
//
//  Created by Yusuf Miletli on 7/26/17.
//  Copyright © 2017 Miletli. All rights reserved.
//

import ObjectMapper

class BaseResponse: Mappable {
    
    func mapping(map: Map) {
        
    }
    
    required init?(map: Map) {
        
    }
    
    class func newInstance(_ jsonString: String)-> AnyObject? {
		
		let obj = Mapper<BaseResponse>().map(JSONString: jsonString)
        return obj
		
    }
}
