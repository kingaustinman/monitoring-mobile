//
//  Tests_iOS.swift
//  Tests iOS
//
//  Created by Austin Daga on 5/25/22.
//
@testable import monitoring
import XCTest

class monitoring_Tests: XCTestCase {
    
    
    var sut: Calc?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = Calc()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_addFive() {
        let answer = sut?.addFive(5)
        XCTAssertEqual(answer, 10)
    }

    
}
