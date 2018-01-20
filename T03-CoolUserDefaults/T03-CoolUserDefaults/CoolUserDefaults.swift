//
//  CoolUserDefaults.swift
//  T03-CoolUserDefaults
//
//  Created by lili on 2018/1/20.
//  Copyright © 2018年 fun. All rights reserved.
//

import Foundation

public struct Listener<T>: Hashable {
    
    let key: String
    
    public typealias Action = (T) -> Void
    let action: Action
    
    public var hashValue: Int {
        return key.hashValue
    }
    
    public static func ==(lhs: Listener<T>, rhs: Listener<T>) -> Bool {
        return lhs.key == rhs.key
    }
}

final public class Box<T> {
    
    public var value: T {
        didSet {
            setterAction(value)
        }
    }
    
    public typealias SetterAction = (T) -> Void
    var setterAction: SetterAction
    
    public init(_ v: T, setterAction action: @escaping SetterAction) {
        value = v
        setterAction = action
    }
}

private let dataKey = "userData"

final public class CoolUserDefaults {
    
    static let defaults = UserDefaults(suiteName: "cool.user.defaults")!
    
    /// User Data
    public static var data: Box<String?> = {
        let data = defaults.string(forKey: dataKey)
        
        return Box<String?>(data) { data in
            defaults.set(data, forKey: dataKey)
        }
    }()
}
