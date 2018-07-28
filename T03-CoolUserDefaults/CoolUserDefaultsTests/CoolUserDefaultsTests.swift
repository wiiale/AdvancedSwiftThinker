//
//  Created by lili on 2018/7/11.
//
//  Copyright © 2018年 fun. All rights reserved.
//

import XCTest
@testable import CoolUserDefaults

class CoolUserDefaultsTests: XCTestCase {
    
    var previous: String?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        previous = CoolUserDefaults.data.value
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        CoolUserDefaults.data.value = previous
    }
    
    func testExample() {
        CoolUserDefaults.data.value = nil
        XCTAssertNil(CoolUserDefaults.data.value)
        CoolUserDefaults.data.value = "1"
        XCTAssertEqual(CoolUserDefaults.data.value, "1")
        CoolUserDefaults.data.value = "🐸"
        XCTAssertEqual(CoolUserDefaults.data.value, "🐸")
        CoolUserDefaults.data.value = nil
        XCTAssertNil(CoolUserDefaults.data.value)
    }
}
