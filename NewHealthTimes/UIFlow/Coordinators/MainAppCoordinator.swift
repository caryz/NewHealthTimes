//
//  MainAppCoordinator.swift
//  NewHealthTimes
//
//  Created by Cary Zhou on 4/26/21.
//

import UIKit

protocol MainCoordinatorDelegate: class {
    func userDidFavorite(id: String)
    func userDidUnfavorite(id: String)
}

class MainAppCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navController: UINavigationController) {
        self.navigationController = navController
    }

    func start() {
        let homeViewController = HomeViewController.viewController(delegate: self)

        TopStoriesAPI().get { (result) in
            homeViewController.loadingAnimation(false)
            switch result {
            case .success(let root):
                homeViewController.homeViewModel = HomeViewModel(with: root.results,
                                                                 homeDelegate: homeViewController)
            case .failure:
                homeViewController.showSomethingWentWrongAlert()
            }
        }

        navigationController.pushViewController(homeViewController, animated: false)
    }
}

/// This illustrates how we can relay events from HomeViewController to the coordinator if needed
extension MainAppCoordinator: MainCoordinatorDelegate {

    func userDidFavorite(id: String) { } // No Impl

    func userDidUnfavorite(id: String) { } // No Impl

}
