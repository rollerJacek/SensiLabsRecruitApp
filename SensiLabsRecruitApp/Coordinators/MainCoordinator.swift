//
//  MainCoordinator.swift
//  SensiLabsRecruitApp
//
//  Created by Jacek Stąporek on 10/03/2020.
//  Copyright © 2020 Jacek Stąporek. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = MainViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showDataLoader() -> DataLoaderViewController {
        let vc = DataLoaderViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        navigationController.present(vc, animated: true)
        return vc
    }
    
    func goToMainVC() {
        let vc = MainViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToDetails(characterList: [String]) {
        let vc = DetailsViewController()
        vc.coordinator = self
        vc.characters = characterList
        navigationController.pushViewController(vc, animated: true)
    }
}
