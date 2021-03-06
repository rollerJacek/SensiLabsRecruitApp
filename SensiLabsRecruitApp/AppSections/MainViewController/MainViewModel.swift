//
//  MainViewModel.swift
//  SensiLabsRecruitApp
//
//  Created by Jacek Stąporek on 11/03/2020.
//  Copyright © 2020 Jacek Stąporek. All rights reserved.
//

import UIKit

protocol MainViewModelDelegate: class {
    func didFetchFilms()
}

class MainViewModel {
    
    private var films: [FilmsModel] = []
    weak var delegate: MainViewModelDelegate?
    
    func getFilms() {
        ConnectionService.getAllFilms() { [weak self] result in
            self?.films = result
            self?.delegate?.didFetchFilms()
        }
    }
    
    func itemForFilm(index: Int) -> FilmsModel {
        films[index]
    }
    
    func countOfFilms() -> Int {
        films.count
    }
    
    func charactersForFilm(index: Int) -> [String] {
        films[index].characters
    }
}
