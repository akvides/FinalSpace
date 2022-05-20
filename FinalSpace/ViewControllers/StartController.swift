//
//  StartController.swift
//  FinalSpace
//
//  Created by Василий Полторак on 15.05.2022.
//

import UIKit

class StartController: UIViewController {
    
    private var data: DataType!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let listController = segue.destination as! ListController
        listController.updateData(by: data)
        listController.data = data
    }
    
    @IBAction func viewListOfCharacters() {
        data = .character
        performSegue(withIdentifier: "goToList", sender: nil)
    }
    
    @IBAction func viewListOfEpisodes() {
        data = .episode
        performSegue(withIdentifier: "goToList", sender: nil)
    }
    
}
