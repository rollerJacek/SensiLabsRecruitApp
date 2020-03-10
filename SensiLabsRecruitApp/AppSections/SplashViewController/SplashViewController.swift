//
//  SplashViewController.swift
//  SensiLabsRecruitApp
//
//  Created by Jacek Stąporek on 10/03/2020.
//  Copyright © 2020 Jacek Stąporek. All rights reserved.
//

import UIKit
import TinyConstraints

class SplashViewController: BaseViewController {
    
    let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    lazy var containerView: UIView = UIView()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("go to main", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()

    override func setupUI() {
        super.setupUI()
        view.backgroundColor = .white
        view.addSubview(activityView)
        activityView.center = self.view.center
        //activityView.startAnimating()
        
        view.addSubview(containerView)
        view.addSubview(button)
        
        containerView.edgesToSuperview()
        
        button.top(to: containerView)
        button.left(to: containerView)
        button.right(to: containerView)
        button.height(100)
    }
    
    @objc func buttonAction(sender: UIButton!) {
      print("Button tapped")
        coordinator?.goToMainVC()
        coordinator?.setAsTopVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}
