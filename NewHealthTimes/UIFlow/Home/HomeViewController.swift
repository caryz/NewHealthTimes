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

    var coordinator: MainAppCoordinator?
    var storyModels = [TopStoriesResult]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.dataSource = self
        tableView.delegate = self

        // TODO: Add Loading Spinner
        TopStoriesAPI().get { (result) in
            switch result {
            case .success(let root):
                self.storyModels = root.results
                self.tableView.reloadSections([0], with: .automatic)
            case .failure(let error):
                print("Something went wrong: \(error.localizedDescription)")
            }
        }
    }

    private func configureNavBar() {
        title = "New Health Times"
    }

}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storyModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StoryCell.identifier, for: indexPath) as? StoryCell else {
            return UITableViewCell()
        }

        let cellViewModel = StoryCellViewModel(with: storyModels[indexPath.row])
        cell.configure(with: cellViewModel)
        return cell
    }


}

extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = WebViewContainerViewModel(with: storyModels[indexPath.row], delegate: self)
        let webViewContainer = WebViewContainerViewController.viewController(with: viewModel)

        navigationController?.pushViewController(webViewContainer, animated: true)
    }
}

extension HomeViewController: WebViewContainerDelegate {
    func exitWebViewContainer() {
        navigationController?.popToRootViewController(animated: true)
    }
}
