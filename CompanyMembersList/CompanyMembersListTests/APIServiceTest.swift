//
//  APIServiceTest.swift
//  CompanyMembersListTests
//
//  Created by Harshal Wani on 23/07/20.
//  Copyright © 2020 Harshal Wani. All rights reserved.
//

import XCTest
import OHHTTPStubs

@testable import CompanyMembersList

class APIServiceTest: XCTestCase {
    
    var aPIService: APIService?
    
    override func setUp() {
        super.setUp()
        aPIService = APIService()
    }
    
    override func tearDown() {
        aPIService = nil
        HTTPStubs.removeAllStubs()
        super.tearDown()
    }
    
    func test_PageNotFound() {
        
        // Setup network stubs
        let testHost = BaseUrl.host
        stub(condition: isHost(testHost)) { _ in
            return HTTPStubsResponse(jsonObject: [:], statusCode: 404, headers: nil)
        }
        
        // 1.Given
        let aPIService = self.aPIService!
        let errorExpectation = expectation(description: "Failure response with page not found")
        
        var errorResponse: APIError?
        
        // 2.When
        aPIService.fetch(.clubDataList()) { (result) in
            switch result {
            case .success:
                XCTFail("Should be failed!")
            case .failure(let err):
                errorResponse = err
            }
            errorExpectation.fulfill()
        }
        waitForExpectations(timeout: 3.0) { (_) in
            // 3.Then
            XCTAssertNotNil(errorResponse)
            XCTAssertEqual("Requested page not found!", errorResponse?.rawValue)
            
        }
    }
    
    func test_CompanyDataCount() {
        
        // Setup network stubs
        let testHost = BaseUrl.host
        stub(condition: isHost(testHost)) { _ in
            let url = Bundle.main.url(forResource: "compList", withExtension: "json")!
            return HTTPStubsResponse(fileURL: url, statusCode: 200, headers: nil)
        }
        
        // Given
        let aPIService = self.aPIService!
        
        // When
        let expect = XCTestExpectation(description: "API call and runs the callback closure")
        
        aPIService.fetch(.clubDataList()) { (result) in
            expect.fulfill()
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode([Company].self, from: data)
                    XCTAssertTrue(!response.isEmpty)
                } catch {
                    XCTFail("Decode error")
                }
            case .failure(let err):
                XCTFail("error occured: \(err))")
            }
        }
        wait(for: [expect], timeout: 10.0)
    }
    
    func test_CompanyDataContent() {
        
        // Setup network stubs
        let testHost = BaseUrl.host
        stub(condition: isHost(testHost)) { _ in
            let url = Bundle.main.url(forResource: "compList", withExtension: "json")!
            return HTTPStubsResponse(fileURL: url, statusCode: 200, headers: nil)
        }
        
        // Given
        let aPIService = self.aPIService!
        
        // When
        let expect = XCTestExpectation(description: "Response companies and filteredClubdata should be equal.")
        
        let url = Bundle.main.url(forResource: "compList", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let response = try! JSONDecoder().decode([Company].self, from: data)
        
        let viewModel = ListViewModel(apiService: aPIService)
        viewModel.getCompanies()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            expect.fulfill()
            XCTAssertEqual(viewModel.filteredClubdata.value?.companies.count, response.count)
            
        }
        wait(for: [expect], timeout: 10.0)
    }
}
