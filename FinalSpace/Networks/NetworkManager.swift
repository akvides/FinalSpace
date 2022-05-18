//
//  NetworkManager.swift
//  FinalSpace
//
//  Created by Василий Полторак on 15.05.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchCharacters(by: String, completion: @escaping([Character]) -> Void) {
        guard let url = URL(string: "https://finalspaceapi.com/api/v0/"+by) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No description")
                return
            }
            
            do {
                
                let characters = try JSONDecoder().decode([Character].self, from: data)
                
                DispatchQueue.main.async {
                    completion(characters)
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    func fetchEpisodes(by: String, completion: @escaping([Episode]) -> Void) {
        guard let url = URL(string: "https://finalspaceapi.com/api/v0/"+by) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No description")
                return
            }
            
            do {
                
                let episodes = try JSONDecoder().decode([Episode].self, from: data)
                
                DispatchQueue.main.async {
                    completion(episodes)
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    func fetchImage(url: String?, completion: @escaping(Data) -> Void ) {
        DispatchQueue.global().async {
            guard let url = URL(string: url ?? "") else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                completion(imageData)
            }
        }
    }
    
    private init() {}
}
