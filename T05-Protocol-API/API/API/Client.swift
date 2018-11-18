//
//  Client.swift
//  API
//
//  Created by lili on 2018/11/18.
//  Copyright © 2018 fun. All rights reserved.
//

import Foundation

protocol Client {
    var host: String { get }
}

extension Client {
    var host: String {
        #if DEBUG
        return "http://192.168.1.1:8080"
        #else
        return "http://192.168.1.1:8080"
        #endif
    }
}
