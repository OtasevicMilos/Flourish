//
//  GameCardTableViewCell.swift
//  Flourish
//
//  Created by Milos Otasevic on 10/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import UIKit

class GameCardTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var playButtonView: UIView!
    @IBOutlet weak var gameImage: UIImageView!
    var callback: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setView()
    }
    
    func setView(){
        self.backView.layer.cornerRadius = 10
        self.backView.clipsToBounds = true
        self.playButtonView.roundCorners([.bottomLeft, .topRight], radius: 20)
        self.playButtonView.setFlourishGradien(start: CGPoint(x: -0.5, y: 0.5))
    }
    @IBAction func playButtonPressed(_ sender: Any) {
        self.callback?()
    }
}//class
