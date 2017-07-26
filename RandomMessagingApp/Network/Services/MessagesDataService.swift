//
//  MessagesDataService.swift
//  RandomMessagingApp
//
//  Created by Yusuf Miletli on 7/26/17.
//  Copyright © 2017 Miletli. All rights reserved.
//

import RxSwift

class MessagesDataService {
    
    class func messages(requestModel:MessagesRequest) -> Observable<AnyObject?> {
        return requestModel.startRequest()
    }
    
}
