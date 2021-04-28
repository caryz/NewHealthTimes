//
//  StoryCellViewModel.swift
//  NewHealthTimes
//
//  Created by Cary Zhou on 4/27/21.
//

import UIKit

struct StoryCellViewModel {
    let title: String
    let subtitle: String
    let byline: String
    let date: String
    let url: URL?
    let imageUrl: String?
    let imageCopyright: String?

    init(with story: TopStoriesResult) {
        title = story.title
        subtitle = story.abstract
        byline = story.byline
        date = story.publishedDate.iso8601Date?.monthDayYear ?? ""
        url = URL(string: story.url)

        let media = story.multimedia.filter { $0.format == .superJumbo }.first
        imageUrl = media?.url
        imageCopyright = media?.copyright
    }
}
