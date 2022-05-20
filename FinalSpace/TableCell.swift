//
//  TableCell.swift
//  FinalSpace
//
//  Created by Василий Полторак on 16.05.2022.
//

import UIKit

class TableCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    func setupCharacters(_ url: String){
        
        NetworkManager.shared.fetchCharacters(url: url) { result in
            switch result {
            case .success(let character):
                self.title.text = character.name
            case .failure(let error):
                print(error)
            }
        }
    }

}
