//
//  CoolUserDefaults.swift
//  T03-CoolUserDefaults
//
//  Created by lili on 2018/1/20.
//  Copyright © 2018年 fun. All rights reserved.
//

import Foundation

final public class UserDefaultsBox<T> {
    
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

final public class CoolUserDefaults {
    
    static let defaults = UserDefaults(suiteName: "group.cool.user.defaults")!
    
    /// User Data
    public static var data: UserDefaultsBox<String?> = {
        let data = defaults.string(forKey: #function)
        
        return UserDefaultsBox<String?>(data) { data in
            defaults.set(data, forKey: #function)
        }
    }()
    
    public class func cleanAllUserDefaults() {
        
        do {
            data.value = nil
            // others...
        }
        
        // reset suite
        
        let dict = defaults.dictionaryRepresentation()
        dict.keys.forEach({
            defaults.removeObject(forKey: $0)
        })
        defaults.synchronize()
        
        // reset standardUserDefaults
        
        let standardUserDefaults = UserDefaults.standard
        standardUserDefaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        standardUserDefaults.synchronize()
    }
}
