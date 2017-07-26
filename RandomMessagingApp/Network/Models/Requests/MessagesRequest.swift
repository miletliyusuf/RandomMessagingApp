//
//  MessagesRequest.swift
//  RandomMessagingApp
//
//  Created by Yusuf Miletli on 7/26/17.
//  Copyright © 2017 Miletli. All rights reserved.
//

import ObjectMapper
import Alamofire

class MessagesRequest: BaseRequest {
    
    override func reqEndPointAndType() -> (String, HTTPMethod) {
        return ("jsonBlob/3cf871b2-f7cd-11e6-95c2-115605632e53",.get)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
    }
	
	override func responseModel() -> BaseResponse.Type {
		return MessagesResponse.self
	}
}
