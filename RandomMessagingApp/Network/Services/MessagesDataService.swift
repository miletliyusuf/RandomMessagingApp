//
//  MessagesDataService.swift
//  RandomMessagingApp
//
//  Created by Yusuf Miletli on 7/26/17.
//  Copyright © 2017 Miletli. All rights reserved.
//

import RxSwift

class MessagesDataService {
	
	
    /// Messages API request service
    ///
    /// - Parameter requestModel: Request model holds endpoint urls and request type
    /// - Returns: Observable value
    class func messages(requestModel:MessagesRequest) -> Observable<AnyObject?> {
        return requestModel.startRequest()
    }
    
}
