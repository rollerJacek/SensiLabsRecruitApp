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
    
    private lazy var viewModel = DetailsViewModel(characters: characters)
    private var dataLoadingView: DataLoaderViewController?
    lazy var tableView = UITableView()
    lazy var characters: [String] = []
    
    override func setupUI() {
        super.setupUI()
        title = "Character list"
        view.backgroundColor = .white
        viewModel.delegate = self
        dataLoadingView = coordinator?.showDataLoader()
    }
    
    override func setupData() {
        super.setupData()
        viewModel.getCharacters()
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: TableCellIdentifiers.desc)
    }
}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.desc, for: indexPath)
        let item = viewModel.characters[indexPath.row]
        cell.selectionStyle = .none
        cell.textLabel?.text = item.name
        return cell
    }
}

extension DetailsViewController: DetailsViewModelDelegate {
    func didFetchCharacters() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.dataLoadingView?.dismiss(animated: true)
        }
    }
}
