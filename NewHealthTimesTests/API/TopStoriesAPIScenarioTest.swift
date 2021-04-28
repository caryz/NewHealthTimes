//
//  TopStoriesAPIScenarioTest.swift
//  NewHealthTimesTests
//
//  Created by Cary Zhou on 4/27/21.
//

import XCTest
@testable import NewHealthTimes

class TopStoriesAPIScenarioTest: XCTestCase {

    let api = TopStoriesAPI()

    func testTopStoriesAPI() {
        let expectation = XCTestExpectation(description: "API Call completion")

        api.get(section: "health") { (result :Result<TopStoriesRoot, APIError>) in
            switch result {
            case .success(let root):
                debugPrint("Success. Item Count: \(root.numResults) \n Items: \(root.results)")
            case .failure(let error):
                XCTFail("API Error: \(error)")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }
}
