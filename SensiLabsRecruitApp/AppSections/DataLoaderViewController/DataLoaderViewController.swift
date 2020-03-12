//
//  DataLoaderViewController.swift
//  SensiLabsRecruitApp
//
//  Created by Jacek Stąporek on 10/03/2020.
//  Copyright © 2020 Jacek Stąporek. All rights reserved.
//

import UIKit

class DataLoaderViewController: BaseViewController {
    
    let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)

    override func setupUI() {
        super.setupUI()
        view.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 0.5)
        view.addSubview(activityView)
        activityView.center = self.view.center
        activityView.startAnimating()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        activityView.stopAnimating()
    }
}
