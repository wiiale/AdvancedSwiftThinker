//
//  Created by lili on 2018/7/11.
//
//  Copyright © 2018年 fun. All rights reserved.
//

import XCTest
@testable import Bidirectional

class BidirectionalTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let numbers = [0, 1, 2, 3]
        var numIterator = numbers.makeBidirectionalIterator()
        
        XCTAssertEqual(0, numIterator.next())
        XCTAssertEqual(1, numIterator.next())
        XCTAssertEqual(2, numIterator.next())
        XCTAssertEqual(3, numIterator.next())
        XCTAssertNil(numIterator.next())
        XCTAssertNil(numIterator.next())
        
        XCTAssertEqual(3, numIterator.previous())
        XCTAssertEqual(2, numIterator.previous())
        XCTAssertEqual(1, numIterator.previous())
        XCTAssertEqual(0, numIterator.previous())
        XCTAssertNil(numIterator.previous())
        XCTAssertNil(numIterator.previous())
    }
}
