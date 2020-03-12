//
//  DetailsViewModel.swift
//  SensiLabsRecruitApp
//
//  Created by Jacek Stąporek on 11/03/2020.
//  Copyright © 2020 Jacek Stąporek. All rights reserved.
//

import Foundation

protocol DetailsViewModelDelegate: class {
    func didFetchCharacters()
}

class DetailsViewModel {
    
    var characters: [CharacterModel] = []
    var characterStrings: [String] = []
    weak var delegate: DetailsViewModelDelegate?
    
    init(characters: [String]) {
        self.characterStrings = characters
    }
    
    func getCharacters() {
        ConnectionService.getAllCharacters(characterList: self.characterStrings) { [weak self] result in
            self?.characters = result
            self?.delegate?.didFetchCharacters()
        }
    }
}
