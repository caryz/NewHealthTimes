//
//  WebViewContainerViewModel.swift
//  NewHealthTimes
//
//  Created by Cary Zhou on 4/27/21.
//

import Foundation

struct WebViewContainerViewModel {
    let urlString: String
    let title: String
    let delegate: WebViewContainerDelegate?

    init(with story: TopStoriesResult, delegate: WebViewContainerDelegate) {
        self.urlString = story.url
        self.title = story.title
        self.delegate = delegate
    }
}
