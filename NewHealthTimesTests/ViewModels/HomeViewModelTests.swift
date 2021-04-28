//
//  HomeViewModelTests.swift
//  NewHealthTimesTests
//
//  Created by Cary Zhou on 4/27/21.
//

import XCTest
@testable import NewHealthTimes

class HomeViewModelTests: XCTestCase {

    var topStoriesRoot: TopStoriesRoot!

    override func setUp() {
        super.setUp()
        guard let data = readLocalFile(forName: "TopStories") else {
            XCTFail("Invalid JSON File")
            return
        }
        do {
            topStoriesRoot = try JSONDecoder().decode(TopStoriesRoot.self, from: data)
        } catch {
            XCTFail("Unable to decode JSON Object")
        }
    }

    func testInit() {
        let viewModel = HomeViewModel(with: topStoriesRoot.results, homeDelegate: nil)
        XCTAssertEqual(viewModel.storyModels.count, viewModel.storyCellViewModels.count)
    }

    func testDelegate() {
        let expectation = XCTestExpectation(description: "Delegate.share(storyUrl) gets called")
        let mockHomeDelegate = MockHomeDelegate()

        mockHomeDelegate.completion = { storyUrl in
            XCTAssertEqual(storyUrl, "Hello there")
            XCTAssertNotNil(storyUrl)
            expectation.fulfill()
        }

        let viewModel = HomeViewModel(with: topStoriesRoot.results, homeDelegate: mockHomeDelegate)
        viewModel.homeDelegate?.share(storyUrl: "Hello there")
        wait(for: [expectation], timeout: 2.0)
    }

    class MockHomeDelegate: StoryCellDelegate {
        var completion: ((String) -> Void)?

        func share(storyUrl: String) {
            completion?(storyUrl)
        }
    }
}
