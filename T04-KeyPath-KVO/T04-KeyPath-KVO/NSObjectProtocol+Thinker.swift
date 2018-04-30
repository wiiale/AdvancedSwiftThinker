//
//  NSObjectProtocol+Thinker.swift
//  T04-KeyPath-KVO
//
//  Created by lili on 2018/4/29.
//  Copyright © 2018年 fun. All rights reserved.
//

import Foundation

extension NSObjectProtocol where Self: NSObject {
    func observe<A, Other>(_ keyPath: KeyPath<Self, A>, writeTo other: Other, _ otherKeyPath: ReferenceWritableKeyPath<Other, A>)
        -> NSKeyValueObservation where A: Equatable, Other: NSObjectProtocol
    {
        return observe(keyPath, options: .new) { _, change in
            guard let newValue = change.newValue, other[keyPath: otherKeyPath] != newValue else {
                return
            }
            other[keyPath: otherKeyPath] = newValue
        }
    }
}
