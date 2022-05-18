//
//  ListController.swift
//  FinalSpace
//
//  Created by Василий Полторак on 15.05.2022.
//

import UIKit

class ListController: UICollectionViewController {
    
    var data: String!
    
    private var characters = [Character]()
    private var character: Character!
    private var episodes = [Episode]()
    private var episode: Episode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateCharacters() {
        NetworkManager.shared.fetchCharacters(by: "character") { characters in
            self.characters = characters
            self.collectionView.reloadData()
        }
    }
    
    func updateEpisodes() {
        NetworkManager.shared.fetchEpisodes(by: "episode") { episodes in
            self.episodes = episodes
            self.collectionView.reloadData()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailController = segue.destination as! DetailController
        if data == "Character" {
            detailController.character = character
        } else {
            detailController.episode = episode
        }
    }

    

}

extension ListController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if data == "Character" {
            return characters.count
        } else {
            return episodes.count
        }
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionCell
        
        if data == "Character" {
            let character = characters[indexPath.row]
            cell.setupCharacters(character)
        } else {
            let episode = episodes[indexPath.row]
            cell.setupEpisodes(episode)
        }
        
        
        
        cell.configureImage(hight: (UIScreen.main.bounds.width / 2 - 10) / 1.75)
        cell.configureBackgroundView()
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        objext = results[indexPath.row]
        if data == "Character" {
            character = characters[indexPath.row]
        } else {
            episode = episodes[indexPath.row]
        }
        performSegue(withIdentifier: "goToDetail", sender: nil)
    }
}

extension ListController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width / 2 - 20, height: UIScreen.main.bounds.height / 3)
    }
}
