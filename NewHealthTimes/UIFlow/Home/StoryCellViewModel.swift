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
//    let image: UIImage

    init(with story: TopStoriesResult) {
        title = story.title
        subtitle = story.abstract
        byline = story.byline
        date = story.publishedDate // date format
        url = URL(string: story.url)
    }
}
