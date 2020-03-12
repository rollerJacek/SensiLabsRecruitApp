//
//  Connection+Requests.swift
//  SensiLabsRecruitApp
//
//  Created by Jacek Stąporek on 11/03/2020.
//  Copyright © 2020 Jacek Stąporek. All rights reserved.
//

import Foundation

class ConnectionService {
    static func getAllFilms(completion: @escaping ([FilmsModel]) -> ()) {
        guard let url: URL = URL(string: ApiUrl.films) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return
            }
            do{
                guard let films = try? JSONDecoder().decode(FilmsResponse.self, from: data) else {
                    print("Error: Couldn't decode data")
                    return
                }
                completion(films.results)
            }
            
        }
        task.resume()
    }
    
    static func getAllCharacters(characterList: [String], completion: @escaping ([CharacterModel]) -> ()) {
        let group = DispatchGroup()
        var characters:[CharacterModel] = []
        
        for character in characterList {
            group.enter()
            guard let url: URL = URL(string: character) else {return}
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                defer{ group.leave() }
                guard let data = data,
                    error == nil else {
                        print(error?.localizedDescription ?? "Response Error")
                        return
                }
                do{
                    guard let newCharacter = try? JSONDecoder().decode(CharacterModel.self, from: data) else {
                        print("Error: Couldn't decode data")
                        return
                    }
                    characters.append(newCharacter)
                }
                
            }
            task.resume()
        }
        group.notify(queue: DispatchQueue.main){
            completion(characters)
        }

    }
}
