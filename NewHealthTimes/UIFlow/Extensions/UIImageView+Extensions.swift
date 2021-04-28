//
//  UIImageView+Extensions.swift
//  NewHealthTimes
//
//  Created by Cary Zhou on 4/27/21.
//

import UIKit
import Kingfisher

// For Async Image downloads
extension UIImageView {
    func setKingfisherImage(from link: String?, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let link = link, let url = URL(string: link) else { return }
        self.contentMode = mode

        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .transition(.fade(1)),
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}
