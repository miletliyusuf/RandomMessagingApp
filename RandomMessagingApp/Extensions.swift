//
//  Extensions.swift
//  RandomMessagingApp
//
//  Created by Yusuf Miletli on 7/27/17.
//  Copyright © 2017 Miletli. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    /// UINib and cell's class identifier name should match. Otherwise it won't work.
    ///
    /// - Parameter identifier: Cell and UINib identifier.
    func registerXib(name identifier:String) {
        self.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
}
