//
//  BannerItem.swift
//  Gurita
//
//  Created by lili on 2017/8/3.
//  Copyright © 2017年 handarui. All rights reserved.
//

import Foundation


/// Banner 类型
///
/// - book: 小说
/// - link: 链接
enum BannerType {
    case book(novelId: Int64)
    case web(link: String)
}

struct BannerItem {
    /// id
    let id: Int64
    
    /// 标题
    let name: String
    
    /// 类型，0:小说，1：跳转链接
    let type: BannerType
}

extension BannerItem: Decodable {
    private enum CodingKeys: CodingKey {
        case id
        case name
        case type
        case novelId
        case link
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int64.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        
        let typeRaw = try container.decode(Int.self, forKey: .type)
        switch typeRaw {
        case 0:
            let novelId = try container.decode(Int64.self, forKey: .novelId)
            self.type = .book(novelId: novelId)
        case 1:
            let link = try container.decode(String.self, forKey: .link)
            self.type = .web(link: link)
        default:
            let context = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "[BannerItem] typeRow cannot decode.")
            throw DecodingError.dataCorrupted(context)
        }
    }
}




