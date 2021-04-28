//
//  StoryCell.swift
//  NewHealthTimes
//
//  Created by Cary Zhou on 4/26/21.
//

import UIKit

class StoryCell: UITableViewCell {
    static let identifier = "StoryCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var bylineLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var copyrightLabel: UILabel!

    func configure(with viewModel: StoryCellViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        bylineLabel.text = viewModel.byline
        dateLabel.text = viewModel.date
        copyrightLabel.text = viewModel.imageCopyright
        thumbnailImage.setKingfisherImage(from: viewModel.imageUrl, contentMode: .scaleAspectFill)
    }
}
