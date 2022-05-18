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
        
        DispatchQueue.global().async {
            guard let url = URL(string: url) else { return }
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data else {
                    print(error?.localizedDescription ?? "No description")
                    return
                }
                do {
                    
                    let character = try JSONDecoder().decode(Character.self, from: data)
                    DispatchQueue.main.async {
                        self.title.text = character.name
                    }
                    
                } catch let error {
                    print(error.localizedDescription)
                }
                
            }.resume()
        }
    }

}
