//
//  ItemCollectionViewCell.swift
//  HomeScreen
//
//  Created by Ahmed on 8/3/19.
//  Copyright © 2019 supergenedy. All rights reserved.
//

import UIKit
import Kingfisher

class ItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    
    public func loadImage(urlString: String) {
        let url = URL(string: urlString)
        imageView.kf.setImage(with: url)
    }
    
}
