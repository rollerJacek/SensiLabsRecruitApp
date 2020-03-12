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
        guard let url: URL = URL(string: ApiUrl.films) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error in: ConnectionService.getAllFilms")
                    return
            }
            do{
                let films = try JSONDecoder().decode(FilmsResponse.self, from: data)
                completion(films.results)
            } catch {
                print("Error: Couldn't decode data in: ConnectionService.getAllFilms")
            }
        }
        task.resume()
    }
    
    static func getAllCharacters(characterList: [String], completion: @escaping ([CharacterModel]) -> ()) {
        let group = DispatchGroup()
        var characters:[CharacterModel] = []
        
        for character in characterList {
            guard let url: URL = URL(string: character) else {
                return
            }
            
            group.enter()
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                defer { group.leave() }
                
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "Response Error in: ConnectionService.getAllCharacters")
                    return
                }
                
                do {
                    let newCharacter = try JSONDecoder().decode(CharacterModel.self, from: data)
                    characters.append(newCharacter)
                } catch {
                    print("Error: Couldn't decode data in: ConnectionService.getAllCharacters")
                }
            }
            task.resume()
        }
        
        group.notify(queue: DispatchQueue.main){
            completion(characters)
        }
    }
}
