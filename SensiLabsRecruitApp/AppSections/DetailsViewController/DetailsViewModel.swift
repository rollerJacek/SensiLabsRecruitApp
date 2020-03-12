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
    
    private var characters: [CharacterModel] = []
    
    init(characters: [String]) {
        self.characterStrings = characters
    }
    
    weak var delegate: DetailsViewModelDelegate?
    private var characterStrings: [String]
    
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
