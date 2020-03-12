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
    private var viewModel = MainViewModel()
    private var dataLoadingView: DataLoaderViewController?
    
    override func setupUI() {
        super.setupUI()
        title = "Movies list"
        view.backgroundColor = .white
        dataLoadingView = coordinator?.showDataLoader()
        viewModel.delegate = self
    }
    
    override func setupData() {
        super.setupData()
        viewModel.getFilms()
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
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: TableCellIdentifiers.main)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countOfFilms()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.main, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        let item = viewModel.itemForFilm(index: indexPath.row)
        cell.setupCell(film: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let items = viewModel.charactersForFilm(index: indexPath.row)
        coordinator?.goToDetails(characterList: items)
    }
}

extension MainViewController: MainViewModelDelegate {
    func didFetchFilms() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.dataLoadingView?.dismiss(animated: true)
        }
    }
}
