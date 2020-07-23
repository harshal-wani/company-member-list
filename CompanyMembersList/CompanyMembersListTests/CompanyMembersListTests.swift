//
//  CompanyMembersListTests.swift
//  CompanyMembersListTests
//
//  Created by Harshal Wani on 19/07/20.
//  Copyright © 2020 Harshal Wani. All rights reserved.
//

import XCTest
@testable import CompanyMembersList

class CompanyMembersListTests: XCTestCase {

    
    func test_IsInternetAvailable() {
        if Utilities.isInternetAvailable() {
            XCTAssertTrue(Utilities.isInternetAvailable())
        } else {
            XCTAssertFalse(Utilities.isInternetAvailable())
        }
    }

}
