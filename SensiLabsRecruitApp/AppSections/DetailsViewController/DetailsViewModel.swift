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
    weak var delegate: DetailsViewModelDelegate?
    
    func getCharacters(characters: [String]) {
        ConnectionService.getAllCharacters(characterList: characters) { result in
            self.characters = result
            self.delegate?.didFetchCharacters()
        }
    }
}
