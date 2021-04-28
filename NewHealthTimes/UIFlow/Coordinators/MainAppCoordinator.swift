//
//  MainAppCoordinator.swift
//  NewHealthTimes
//
//  Created by Cary Zhou on 4/26/21.
//

import UIKit

class MainAppCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navController: UINavigationController) {
        self.navigationController = navController
    }

    func start() {
        let vc = HomeViewController.instantiate()
        vc.coordinator = self // should be delegate or nothing

        TopStoriesAPI().get { (result) in
            vc.loadingAnimation(false)
            switch result {
            case .success(let root):
                vc.homeViewModel = HomeViewModel(with: root.results)
            case .failure:
                vc.showSomethingWentWrongAlert()
            }
        }

        navigationController.pushViewController(vc, animated: false)
    }
}

