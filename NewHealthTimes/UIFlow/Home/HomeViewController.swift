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
    var navBarButton: UIBarButtonItem!

    weak var coordinator: MainAppCoordinator? // make sample delegate or remove this
    var homeViewModel: HomeViewModel? {
        didSet {
            tableView.reloadSections([0], with: .automatic)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }

    private func configureNavBar() {
        title = "New Health Times"
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StoryCell.identifier, for: indexPath) as? StoryCell,
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

extension HomeViewController: WebViewContainerDelegate {
    func exitWebViewContainer() {
        navigationController?.popToRootViewController(animated: true)
    }
}
