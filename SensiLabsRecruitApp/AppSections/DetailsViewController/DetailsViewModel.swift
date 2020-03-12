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
    
    private var characterStrings: [String]
    
    init(characters: [String]) {
        self.characterStrings = characters
    }
    
    weak var delegate: DetailsViewModelDelegate?
        private var characters: [CharacterModel] = []
    
    func getCharacters() {
        ConnectionService.getAllCharacters(characterList: self.characterStrings) { [weak self] result in
            self?.characters = result
            self?.delegate?.didFetchCharacters()
        }
    }
    
    func itemForCharacter(index: Int) -> CharacterModel {
        characters[index]
    }
    
    func charactersCount() -> Int {
        characters.count
    }
    
}
