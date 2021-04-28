//
//  HomeViewModel.swift
//  NewHealthTimes
//
//  Created by Cary Zhou on 4/26/21.
//

import Foundation

struct HomeViewModel {
    var storyModels = [TopStoriesResult]()
    var storyCellViewModels = [StoryCellViewModel]()
    var homeDelegate: StoryCellDelegate?

    init(with storyModels: [TopStoriesResult], homeDelegate: StoryCellDelegate?) {
        self.storyModels = storyModels
        self.homeDelegate = homeDelegate
        self.storyCellViewModels = getStoryCellViewModels(with: storyModels)
    }

    private func getStoryCellViewModels(with stories: [TopStoriesResult]) -> [StoryCellViewModel] {
        return stories.map { StoryCellViewModel(with: $0, delegate: homeDelegate) }
    }
}
