//
//  CollectionViewCell.swift
//  amc-youtube
//
//  Created by thisdjango on 29.01.2020.
//  Copyright © 2020 thisdjango. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var myimage: UIImageView!
    @IBOutlet weak var mylabel: UILabel!
    
    var image = UIImage()
    var descr = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        myimage.image = image
        mylabel.text = descr
    }
    

}
