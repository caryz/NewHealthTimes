//
//  WebContainerViewModelTests.swift
//  NewHealthTimesTests
//
//  Created by Cary Zhou on 4/27/21.
//

import XCTest
@testable import NewHealthTimes

class WebContainerViewModelTests: XCTestCase {

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
        let viewModel = WebViewContainerViewModel(with: firstResult, delegate: nil)
        XCTAssertEqual(viewModel.urlString, firstResult.url)
        XCTAssertEqual(viewModel.title, firstResult.title)
        XCTAssertNil(viewModel.delegate)
    }

    func testDelegate() {
        let expectation = XCTestExpectation(description: "Delegate.share(storyUrl) gets called")
        let mockWebContainerDelegate = MockWebContainerDelegate()

        mockWebContainerDelegate.completion = {
            expectation.fulfill()
        }

        guard let firstResult = topStoriesRoot.results.first else {
            XCTFail("Unable to retrieve first story result")
            return
        }
        let viewModel = WebViewContainerViewModel(with: firstResult, delegate: mockWebContainerDelegate)
        viewModel.delegate?.exitWebViewContainer()
        wait(for: [expectation], timeout: 2.0)
    }

    class MockWebContainerDelegate: WebViewContainerDelegate {
        var completion: (() -> Void)?

        func exitWebViewContainer() {
            completion?()
        }
    }
}
