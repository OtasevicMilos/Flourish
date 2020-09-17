//
//  QuizzSingleResultTableViewCell.swift
//  Flourish
//
//  Created by Milos Otasevic on 17/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import UIKit

class QuizzSingleResultTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var procentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
