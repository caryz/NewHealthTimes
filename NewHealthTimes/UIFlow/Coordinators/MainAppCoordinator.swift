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
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
}

