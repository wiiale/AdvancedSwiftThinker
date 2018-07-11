//
//  BidirectionalIterator.swift
//  T02-Iterator-Bidirectional
//
//  Created by lili on 2017/12/29.
//  Copyright © 2017年 fun. All rights reserved.
//

import Foundation

struct BidirectionalIterator<Elements> where Elements: BidirectionalCollection {
    let _elements: Elements
    var _position: Elements.Index
    
    init(elements: Elements) {
        self._elements = elements
        self._position = elements.startIndex
    }
    
    mutating func next() -> Elements.Element? {
        if _position == _elements.endIndex { return nil }
        let element = _elements[_position]
        _elements.formIndex(after: &_position)
        return element
    }
    
    mutating func previous() -> Elements.Element? {
        if _position == _elements.startIndex { return nil }
        _elements.formIndex(before: &_position)
        let element = _elements[_position]
        return element
    }
}

extension BidirectionalCollection {
    func makeBidirectionalIterator() -> BidirectionalIterator<Self> {
        return BidirectionalIterator(elements: self)
    }
}
