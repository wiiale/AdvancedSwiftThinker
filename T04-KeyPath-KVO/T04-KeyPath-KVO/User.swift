//
//  User.swift
//  T04-KeyPath-KVO
//
//  Created by lili on 2018/4/29.
//  Copyright © 2018年 fun. All rights reserved.
//

import Foundation

class User: NSObject {
    
    // KVO-enabled properties must be @objc dynamic
    @objc dynamic var name: String
    
    init(name: String) {
        self.name = name
    }
}

extension User {
    override var description: String {
        return "name: \(name)"
    }
}
