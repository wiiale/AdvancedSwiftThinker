//
//  City.swift
//  T01-Hashable-Footprint
//
//  Created by lili on 2017/12/11.
//  Copyright © 2017年 fun. All rights reserved.
//

import Foundation

struct City {
    let name: String
    let province: String
}

extension City: Hashable {
    var hashValue: Int {
        get {
            // Warning 1
            return "\(name)\(province)".hashValue
        }
    }
    
    static func ==(lhs: City, rhs: City) -> Bool {
        return lhs.name == rhs.name
    }
}

let dummy = [
    City(name: "Hangzhou", province: "Zhejiang"),
    City(name: "Shanghai", province: "Shanghai"),
    City(name: "HongKong", province: "HongKong"),
    City(name: "Shenzhen", province: "Guangdong"),
]

struct CityStore {
    static let shared = CityStore()
    func getCities(completionHandler: (([City]) -> Void)?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completionHandler?(dummy)
        }
    }
}

/*
class CityObj: NSObject {
    let name: String
    let province: String
    
    init(name: String, province: String) {
        self.name = name
        self.province = province
    }
}

// Warning 2
extension CityObj {
    override var hashValue: Int {
        get {
            return "\(name)\(province)".hashValue
        }
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        return name == (object as? CityObj)?.name
    }
}
*/

