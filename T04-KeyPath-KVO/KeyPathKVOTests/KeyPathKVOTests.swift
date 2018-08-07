//
//  Created by lili on 2018/7/11.
//
//  Copyright © 2018年 fun. All rights reserved.
//

import XCTest
@testable import KeyPathKVO

class KeyPathKVOTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        let user = User(name: "Gua Li")
        let test = TestObj()
        
        XCTAssertNotEqual(user.name, test.text)
        
        let observation = user.observe(\User.name, writeTo: test, \TestObj.text)
        user.name = "1"
        XCTAssertEqual(test.text, "1")
        
        observation.invalidate()
    }
}

class TestObj: NSObject {
    var text: String = ""
}
