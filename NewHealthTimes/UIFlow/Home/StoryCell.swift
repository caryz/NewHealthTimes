//
//  StoryCell.swift
//  NewHealthTimes
//
//  Created by Cary Zhou on 4/26/21.
//

import UIKit

protocol StoryCellDelegate: class {
    func share(storyUrl: String)
}

class StoryCell: UITableViewCell, IdentifiableView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var bylineLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var copyrightLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!

    weak var delegate: StoryCellDelegate?
    var viewModel: StoryCellViewModel?

    func configure(with viewModel: StoryCellViewModel) {
        self.viewModel = viewModel
        delegate = viewModel.delegate
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        bylineLabel.text = viewModel.byline
        dateLabel.text = viewModel.date
        copyrightLabel.text = viewModel.imageCopyright
        thumbnailImage.setKingfisherImage(from: viewModel.imageUrl, contentMode: .scaleAspectFill)
    }

    @IBAction func shareButtonTapped(_ sender: UIButton) {
        guard let url = viewModel?.url else { return }
        delegate?.share(storyUrl: url.absoluteString)
    }

}
