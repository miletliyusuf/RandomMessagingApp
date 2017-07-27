//
//  UserDefaultsHelper.swift
//  RandomMessagingApp
//
//  Created by Yusuf Miletli on 27/07/2017.
//  Copyright © 2017 Miletli. All rights reserved.
//

import Foundation

class UserDefaultsHelper {
	
	private static let userKey = "user"
	
	static var user:UserModel? {
		get {
			if UserDefaults.standard.object(forKey: userKey) != nil {
				let decoded  = UserDefaults.standard.object(forKey: userKey) as! Data
				let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserModel
				return decodedUser
			}
			else {
				return nil
			}
		}
		set(newValue) {
			let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: newValue!)
			UserDefaults.standard.set(encodedData, forKey: userKey)
			UserDefaults.standard.synchronize()
		}
	}
}
