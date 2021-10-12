//
//  CodeCoverageExampleTests.swift
//  CodeCoverageExampleTests
//
//  Created by Michael Dube on 2021/09/21.
//

import XCTest
@testable import CodeCoverage

class CodeCoverageExampleTests: XCTestCase {

    func testDummy() {
        XCTAssertEqual(1, 1)
    }
    
    func testVersionComparisons() {
        XCTAssert(OverAppVersion(version: "1.0.0") == OverAppVersion(version: "1.0.0"))
        XCTAssert(OverAppVersion(version: "1.1.1") > OverAppVersion(version: "1.0.1"))
        XCTAssert(OverAppVersion(version: "1.2.3") < OverAppVersion(version: "2.0.1"))
        XCTAssert(OverAppVersion(version: "1.11.0") > OverAppVersion(version: "1.2.0"))
        XCTAssert(OverAppVersion(version: "1.11.0-dev") == OverAppVersion(version: "1.11.0"))
    }

    func testCanUseVersionWithAVersionInThePrereleaseComponent() {
        // Previously a version number like this would just cause a crash
        // as a result of an assert
        _ = OverAppVersion(version: "3.5.3-3.5.3")
    }

}
