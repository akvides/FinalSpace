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
    
    func setupCharacters(_ values: Character) {
        collectionCellLabel.text = values.name
        
        NetworkManager.shared.fetchImage(url: values.img_url ?? "") { imageData in
            self.collectionCellImage.image = UIImage(data: imageData)
        }
    }
    
    func setupEpisodes(_ values: Episode) {
        collectionCellLabel.text = values.name
        
        NetworkManager.shared.fetchImage(url: values.img_url ?? "") { imageData in
            self.collectionCellImage.image = UIImage(data: imageData)
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
