//
//  DetailController.swift
//  FinalSpace
//
//  Created by Василий Полторак on 15.05.2022.
//

import UIKit

class DetailController: UIViewController {

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var characteristics: UITableView!
    
    private var imgUrl: String?
    
    var character: Character?
    var episode: Episode?
    
    private var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator = GlobalMethods.shared.addActivityIndicator(in: self.view)
        
        if character?.name != nil {
            navigationItem.title = character?.name
            imgUrl = character?.imageUrl
        } else {
            navigationItem.title = episode?.name
            imgUrl = episode?.imageUrl
        }
        NetworkManager.shared.fetchImage(url: imgUrl ?? "") { result in
            switch result {
            case .success(let imageData):
                self.mainImage.image = UIImage(data: imageData)
            case .failure(let error):
                self.mainImage.image = UIImage(named: "no_photo3")
                print(error)
            }
            
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func setupTableView(_ section: Int) -> (numberOfRowsInSection: Int, title: String) {
        if character?.name != nil {
            if section == 0 {
                return (4, "Characteristics")
            } else {
                return (character?.alias?.count ?? 0, "Alias")
            }
        } else {
            if section == 0 {
                return (3, "Info")
            } else {
                return (episode?.characters?.count ?? 0, "Characters")
            }
        }
    }
    
}

extension DetailController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        setupTableView(section).title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        setupTableView(section).numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characteristic", for: indexPath) as! TableCell

        if character?.name != nil {
            if indexPath.section == 0 {
                switch indexPath.row {
                case 0: cell.title.text = "Status - \(character?.status ?? "Unknown")"
                case 1: cell.title.text = "Species - \(character?.species ?? "Unknown")"
                case 2: cell.title.text = "Gender - \(character?.gender ?? "Unknown")"
                default: cell.title.text = "Origin - \(character?.origin ?? "Unknown")"
                }
            } else {
                cell.title.text = character?.alias?[indexPath.row]
            }
        } else {
            if indexPath.section == 0 {
                switch indexPath.row {
                case 0: cell.title.text = "Air date - \(episode?.airDate ?? "Unknown")"
                case 1: cell.title.text = "Director - \(episode?.director ?? "Unknown")"
                default: cell.title.text = "Writer - \(episode?.writer ?? "Unknown")"
                }
            } else {
                cell.setupCharacters(episode?.characters?[indexPath.row] ?? "Unknown")
            }
        }
        
        return cell
    }
    
    
}
