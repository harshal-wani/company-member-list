//
//  ModelTest.swift
//  CompanyMembersListTests
//
//  Created by Harshal Wani on 24/07/20.
//  Copyright © 2020 Harshal Wani. All rights reserved.
//

import XCTest

@testable import CompanyMembersList

class ModelTest: XCTestCase {
    
    func test_CompanyModelDecode() throws {
        
        let json = """
        {
          "_id": "5c5bb5ce54a9c166bf1c5b82",
          "company": "GYNKO",
          "website": "www.gynko.co.uk",
          "logo": "http://placehold.it/32x32",
          "about": "About company",
          "members": []
        }
        """.data(using: .utf8)!
        
        XCTAssertNoThrow(try JSONDecoder().decode(Company.self, from: json))
    }
    
    func test_MemberModelDecode() throws {
        
        let json = """
        {
          "_id": "5c5bb5ce9ea1ae34c3d4f0c7",
          "age": 26,
          "name": {
            "first": "Heather",
            "last": "Russell"
          },
          "email": "heather.russell@undefined.info",
          "phone": "+1 (827) 549-3643"
        }
        """.data(using: .utf8)!
        
        XCTAssertNoThrow(try JSONDecoder().decode(Member.self, from: json))
    }
    
    func test_MemberCellModel() {
        
        let member = Member(name: Name(first: "Harshal", last: "Wani"),
                            memberId: "1234",
                            age: 30,
                            email: "harsh.w2@gmail.com",
                            phone: "012345678")
        
        let memberCellModel = MemberCellModel(member: member)
        let fullName = "Harshal Wani"
        
        XCTAssertEqual(memberCellModel.name, fullName)
        XCTAssertEqual(memberCellModel.age, 30)
    }
    
    func test_CompanyCellModel() {
        
        let member = Member(name: Name(first: "Harshal", last: "Wani"),
                            memberId: "1234",
                            age: 30,
                            email: "harsh.w2@gmail.com",
                            phone: "012345678")
        
        let company = Company(name: "Spectrum", companyId: "123", website: "Spectrum.com", logo: "", about: "", members: [member])
        let companyCellModel = CompanyCellModel(company: company)
        let name = "Spectrum"
        
        XCTAssertEqual(companyCellModel.name, name)
    }
}
