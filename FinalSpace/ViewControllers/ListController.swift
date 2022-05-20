//
//  ListController.swift
//  FinalSpace
//
//  Created by Василий Полторак on 15.05.2022.
//

import UIKit

class ListController: UICollectionViewController {
    
    var data: DataType!
    
    private var values = [Any]()
    private var character: Character!
    private var episode: Episode!
    
    private var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator = GlobalMethods.shared.addActivityIndicator(in: self.view)
    }
    
    func updateData(by: DataType) {
        NetworkManager.shared.fetchData(by: by) { result in
            switch result {
            case .success(let data):
                self.values = data
                self.activityIndicator.stopAnimating()
                self.collectionView.reloadData()
            case .failure(let error): print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailController = segue.destination as! DetailController
        if data == .character {
            detailController.character = character
        } else {
            detailController.episode = episode
        }
    }

}

extension ListController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        values.count
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionCell
        
        let value = values[indexPath.row]
        cell.setupCell(value)
        
        cell.configureImage(hight: (UIScreen.main.bounds.width / 2 - 10) / 1.75)
        cell.configureBackgroundView()
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if data == .character {
            character = values[indexPath.row] as? Character
        } else {
            episode = values[indexPath.row] as? Episode
        }
        performSegue(withIdentifier: "goToDetail", sender: nil)
    }
}

extension ListController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width / 2 - 20, height: UIScreen.main.bounds.height / 3)
    }
}
