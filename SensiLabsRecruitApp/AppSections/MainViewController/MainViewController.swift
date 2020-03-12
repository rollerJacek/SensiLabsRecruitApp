//
//  MainViewController.swift
//  SensiLabsRecruitApp
//
//  Created by Jacek Stąporek on 10/03/2020.
//  Copyright © 2020 Jacek Stąporek. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {
    
    lazy var tableView: UITableView = UITableView()
    private lazy var viewModel = MainViewModel()
    let cellId = "MainTableViewCell"
    var dataLoadingView: DataLoaderViewController?
    
    override func setupUI() {
        super.setupUI()
        title = "Movies list"
        view.backgroundColor = .white
        dataLoadingView = coordinator?.showDataLoader()        
        viewModel.getFilms()
        viewModel.delegate = self
    }
    
    override func addSubviews() {
        super.addSubviews()
        view.addSubview(tableView)
    }
    
    override func constraintViews() {
        super.constraintViews()
        tableView.edgesToSuperview(usingSafeArea: true)
        tableView.separatorStyle = .none
    }
    
    override func setupTableView() {
        super.setupTableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: cellId)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        let item = viewModel.films[indexPath.row]
        cell.titleLabel.text = item.title
        cell.descriptionLabel.text = item.director
        cell.contentView.layer.masksToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let items = viewModel.films[indexPath.row].characters
        coordinator?.goToDetails(characterList: items)
    }
}

extension MainViewController: MainViewModelDelegate {
    func didFetchFilms() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.dataLoadingView?.dismiss(animated: true)
        }
    }
}
