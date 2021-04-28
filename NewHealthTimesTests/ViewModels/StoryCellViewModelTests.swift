//
//  StoryCellViewModelTests.swift
//  NewHealthTimesTests
//
//  Created by Cary Zhou on 4/27/21.
//

import XCTest
@testable import NewHealthTimes

class StoryCellViewModelTests: XCTestCase {

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
        guard let firstResult = topStoriesRoot.results.first else {
            XCTFail("Unable to retrieve first story result")
            return
        }
        let viewModel = StoryCellViewModel(with: firstResult, delegate: nil)

        // Well I was hoping for something less morbid :(
        XCTAssertEqual(viewModel.title, "Hester Ford, Oldest American, Dies")
        XCTAssertEqual(viewModel.subtitle, "She was believed to be either 115 or 116. She experienced two pandemics and two world wars and lived under 21 presidents.")
        XCTAssertEqual(viewModel.byline, "By Amisha Padnani")
        XCTAssertEqual(viewModel.date, "Apr 26, 2021")
        XCTAssertEqual(viewModel.url, URL(string: "https://www.nytimes.com/2021/04/26/us/hester-ford-dead.html"))
        XCTAssertEqual(viewModel.imageUrl, "https://static01.nyt.com/images/2021/04/26/obituaries/26Ford1/26Ford1-superJumbo.jpg")
        XCTAssertEqual(viewModel.imageCopyright, "Diedra Laird/The Charlotte Observer, via Associated Press")
        XCTAssertNil(viewModel.delegate)
    }

    func testDelegate() {
        let expectation = XCTestExpectation(description: "Delegate.share(storyUrl) gets called")
        let mockStoryCellDelegate = MockStoryCellDelegate()

        mockStoryCellDelegate.completion = { storyUrl in
            XCTAssertEqual(storyUrl, "Hello there")
            XCTAssertNotNil(storyUrl)
            expectation.fulfill()
        }

        guard let firstResult = topStoriesRoot.results.first else {
            XCTFail("Unable to retrieve first story result")
            return
        }
        let viewModel = StoryCellViewModel(with: firstResult, delegate: mockStoryCellDelegate)
        viewModel.delegate?.share(storyUrl: "Hello there")
        wait(for: [expectation], timeout: 2.0)
    }

    class MockStoryCellDelegate: StoryCellDelegate {
        var completion: ((String) -> Void)?

        func share(storyUrl: String) {
            completion?(storyUrl)
        }
    }
}
