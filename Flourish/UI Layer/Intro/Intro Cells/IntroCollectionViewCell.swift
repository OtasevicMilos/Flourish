//
//  IntroCollectionViewCell.swift
//  Flourish
//
//  Created by Janko on 21/07/2020.
//  Copyright © 2020 Janko. All rights reserved.
//

import UIKit

class IntroCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewImage.alpha=0
    }
    
}
