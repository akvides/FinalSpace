//
//  NetworkManager.swift
//  FinalSpace
//
//  Created by Василий Полторак on 15.05.2022.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(by: DataType, completion: @escaping(Result<[Any], Error>) -> Void) {
        AF.request("https://finalspaceapi.com/api/v0/"+by.rawValue)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    switch by {
                    case .character:
                        let characters = Character.getCharacters(from: value)
                        DispatchQueue.main.async {
                            completion(.success(characters))
                        }
                    case .episode:
                        let episodes = Episode.getEpisodes(from: value)
                        DispatchQueue.main.async {
                            completion(.success(episodes))
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func fetchCharacters(url: String, completion: @escaping(Result<Character, Error>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let character = Character(characterData: value as! [String : Any])
                    DispatchQueue.main.async {
                        completion(.success(character))
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
      
    func fetchImage(url: String, completion: @escaping(Result<Data, Error>) -> Void ) {
        DispatchQueue.global().async {
            guard let url = URL(string: url) else { return }
            do {
                let imageData = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    completion(.success(imageData))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }

    
}
