//
//  CollectionCell.swift
//  FinalSpace
//
//  Created by Василий Полторак on 15.05.2022.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionCellImage: UIImageView!
    @IBOutlet weak var imageHight: NSLayoutConstraint!
    @IBOutlet weak var collectionCellView: UIView!
    @IBOutlet weak var collectionCellLabel: UILabel!
    
    func setupCell(_ value: Any) {
        var name: String?
        var imageUrl: String?
        
        if let character = value as? Character {
            name = character.name
            imageUrl = character.imageUrl
        } else if let episode = value as? Episode {
            name = episode.name
            imageUrl = episode.imageUrl
        }
        
        let activityIndicator = GlobalMethods.shared.addActivityIndicator(in: self.contentView)
        activityIndicator.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        
        collectionCellLabel.text = name
        
        NetworkManager.shared.fetchImage(url: imageUrl ?? "") { result in
            switch result {
                
            case .success(let imageData):
                self.collectionCellImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error.localizedDescription)
                self.collectionCellImage.image = UIImage(named: "no_photo3")
            }
            
            activityIndicator.stopAnimating()
        }
        
    }
    
    func configureImage(hight: CGFloat) {
        collectionCellImage.layer.zPosition = 1
        collectionCellImage.layer.cornerRadius = hight/2
        imageHight.constant = hight
    }
    
    func configureBackgroundView() {
        collectionCellView?.layer.cornerRadius = 15
        
        collectionCellView?.layer.shadowColor = UIColor.black.cgColor
        collectionCellView?.layer.shadowOffset = CGSize(width: 3.5, height: 3.5)
        collectionCellView?.layer.shadowRadius = 1.5
        collectionCellView?.layer.shadowOpacity = 0.3
        collectionCellView?.layer.masksToBounds = false

    }
    
}
