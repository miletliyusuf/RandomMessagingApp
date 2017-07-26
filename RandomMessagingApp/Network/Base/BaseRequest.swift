//
//  BaseRequest.swift
//  RandomMessagingApp
//
//  Created by Yusuf Miletli on 7/26/17.
//  Copyright © 2017 Miletli. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire
import RxSwift

let APP_SRV = "https://jsonblob.com/api/"

let baseHeader: [String:String] = [
    "Content-Type": "application/json",
    "Accept": "application/json",
    "lang": "EN"
]

class BaseRequest: Mappable {
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
    }
    
    func responseModel() -> BaseResponse.Type {
        return BaseResponse.self
    }
    
    func reqEndPointAndType() -> (String, HTTPMethod) {
        return ("",.get)
    }
    
    func requestJson()->[String : Any]{
        return toJSON()
    }
    
    func newInstance(_ jsonString: String) -> AnyObject? {
        let obj = Mapper<BaseRequest>().map(JSONString: jsonString)
        return obj
    }
    
    func startRequest() -> Observable<AnyObject?> {
        
        return Observable.create({ observer in
            let url:URL = URL(string: "\(APP_SRV)\(self.reqEndPointAndType().0)")!
            let method:HTTPMethod = self.reqEndPointAndType().1
            let params:Parameters = self.requestJson()
            
            var req = URLRequest(url: url)
            req.httpMethod = method.rawValue
            req.allHTTPHeaderFields = baseHeader
            
            if params.count > 0 {
                req.httpBody = try! JSONSerialization.data(withJSONObject: params)
            }
            
            let r = Alamofire.request(req).validate(statusCode: 200..<300).responseData{response in
                switch response.result {
                    case .success:
                        let utf8Text: String = String(data: response.data!, encoding: .utf8)!
                        let responseClass:BaseResponse.Type = self.responseModel()
                        let obj = responseClass.newInstance(utf8Text)
                        
                        observer.onNext(obj)
                        observer.onCompleted()
                    case .failure:
                        observer.onNext(nil)
                        observer.onCompleted()
                }
            }
            
            return Disposables.create(with: { r.cancel() })
        })
        
    }
}
