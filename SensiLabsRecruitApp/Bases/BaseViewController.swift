//
//  BaseViewController.swift
//  SensiLabsRecruitApp
//
//  Created by Jacek Stąporek on 10/03/2020.
//  Copyright © 2020 Jacek Stąporek. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addSubviews()
        constraintViews()
        setupTableView()
    }
    
    func setupUI() {}
    func addSubviews() {}
    func constraintViews() {}
    func setupTableView() {}
}
