//
//  HomeViewController.swift
//  NewHealthTimes
//
//  Created by Cary Zhou on 4/26/21.
//

import UIKit
import Alamofire
import WebKit

class HomeViewController: UIViewController, Storyboarded {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    weak var coordinatorDelegate: MainCoordinatorDelegate?

    var homeViewModel: HomeViewModel? {
        didSet {
            tableView.reloadSections([0], with: .automatic)
        }
    }

    class func viewController(delegate: MainCoordinatorDelegate?) -> HomeViewController {
        let viewController = HomeViewController.instantiate()
        viewController.coordinatorDelegate = delegate
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New Health Times"
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }

    func loadingAnimation(_ animating: Bool = true) {
        animating
            ? activityIndicator.startAnimating()
            : activityIndicator.stopAnimating()
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel?.storyCellViewModels.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StoryCell.identifier,
                                                       for: indexPath) as? StoryCell,
              let viewModel = homeViewModel?.storyCellViewModels[indexPath.row] else {
            return UITableViewCell()
        }

        cell.configure(with: viewModel)
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let storyModel = homeViewModel?.storyModels[indexPath.row] else { return }

        let viewModel = WebViewContainerViewModel(with:storyModel, delegate: self)
        let webViewContainer = WebViewContainerViewController.viewController(with: viewModel)

        navigationController?.pushViewController(webViewContainer, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

/// Brings user back to HomeViewController (rootVC) when an error occurs in loading the WebView
extension HomeViewController: WebViewContainerDelegate {
    func exitWebViewContainer() {
        navigationController?.popToRootViewController(animated: true)
    }
}

/// Shows UIActivityController when user taps on the share button
extension HomeViewController: StoryCellDelegate {
    func share(storyUrl: String) {
        guard let url = URL(string: storyUrl) else { return }
        let ac = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        navigationController?.present(ac, animated: true)
    }
}
