//
//  StartController.swift
//  FinalSpace
//
//  Created by Василий Полторак on 15.05.2022.
//

import UIKit

class StartController: UIViewController {
    
    private var data: String!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let listController = segue.destination as! ListController
        if data == "Character" {
            listController.updateCharacters()
        } else {
            listController.updateEpisodes()
        }
        listController.data = data
        
    }
    
    
    
    @IBAction func viewListOfCharacters() {
        data = "Character"
        performSegue(withIdentifier: "goToList", sender: nil)
    }
    
    @IBAction func viewListOfEpisodes() {
        data = "Episode"
        performSegue(withIdentifier: "goToList", sender: nil)
    }
    
}
