//
//  LocalizedString.swift
//  LocalizedString
//
//  Created by wiiale on 2020/3/1.
//  Copyright © 2020 wiiale. All rights reserved.
//

import Foundation

@propertyWrapper
struct LocalizedString {
    let wrappedValue: String
    init(_ key: String) {
        wrappedValue = NSLocalizedString(key, comment: "")
    }
}
