//
//  DetailsViewController.swift
//  SensiLabsRecruitApp
//
//  Created by Jacek Stąporek on 10/03/2020.
//  Copyright © 2020 Jacek Stąporek. All rights reserved.
//

import UIKit
import TinyConstraints

class DetailsViewController: BaseViewController {
    
    private let viewModel = DetailsViewModel()
    lazy var tableView = UITableView()
    let cellId = "DetailsTableViewCell"
    lazy var characters: [String] = []
    var dataLoadingView: DataLoaderViewController?
    
    override func setupUI() {
        super.setupUI()
        title = "Character list"
        view.backgroundColor = .white
        viewModel.delegate = self
        dataLoadingView = coordinator?.showDataLoader()
        viewModel.getCharacters(characters: characters)
    }
    
    override func addSubviews() {
        super.addSubviews()
        view.addSubview(tableView)
    }
    
    override func constraintViews() {
        super.constraintViews()
        tableView.edgesToSuperview(usingSafeArea: true)
    }
    
    override func setupTableView() {
        super.setupTableView()
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.selectionStyle = .none
        let item = viewModel.characters[indexPath.row]
        cell.textLabel?.text = item.name
        return cell
    }
}

extension DetailsViewController: DetailsViewModelDelegate {
    func didFetchCharacters() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.dataLoadingView?.dismiss(animated: true)
        }
    }
}
