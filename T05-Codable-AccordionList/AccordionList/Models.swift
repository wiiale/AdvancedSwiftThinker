//
//  Models.swift
//  AccordionList
//
//  Created by lili on 2018/9/9.
//  Copyright © 2018年 fun. All rights reserved.
//

import Foundation

let dummy = """
{
    "users": [
        {
            "id": 1,
            "name": "Tom"
        },
        {
            "id": 2,
            "name": "Jerry"
        }
    ],
}
""".data(using: .utf8)!

struct Group {
    
}

struct User: Codable {
    let id: Int
    let name: String
}
