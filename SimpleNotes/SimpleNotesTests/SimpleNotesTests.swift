//
//  SimpleNotesTests.swift
//  SimpleNotesTests
//
//  Created by Nameet Bhave on 4/8/18.
//  Copyright © 2018 Nameet. All rights reserved.
//

import XCTest
@testable import SimpleNotes

class SimpleNotesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testNoteValidation() {
        let title = "My note 1"
        let noteText = "This is a note."
        Validations.validateNote(title: title, noteText: noteText) { (isValid, errorMsg) in
            XCTAssertTrue(isValid)
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
