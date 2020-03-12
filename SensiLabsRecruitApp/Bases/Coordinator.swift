//
//  Coordinator.swift
//  SensiLabsRecruitApp
//
//  Created by Jacek Stąporek on 10/03/2020.
//  Copyright © 2020 Jacek Stąporek. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

extension Coordinator {
    func goBack(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
    
    func removeFirstVC() {
        navigationController.viewControllers.remove(at: 0)
    }
}
