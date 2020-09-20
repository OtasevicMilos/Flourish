//
//  StrengthsAndWeaknessesHomeViewController.swift
//  Flourish
//
//  Created by Milos Otasevic on 19/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import UIKit

protocol StrengthsAndWeaknessesHomeViewControllerDelegate{
}

class StrengthsAndWeaknessesHomeViewController: UIViewController {
    let dataSource: StrengthsAndWeaknessesHomeVCDataSource
    var delegate: StrengthsAndWeaknessesHomeViewControllerDelegate?
    @IBOutlet var roundViews: [UIView]!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var startButtonView: UIView!
    
    init(dataSource: StrengthsAndWeaknessesHomeVCDataSource){
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.startButtonView.roundCorners([.bottomLeft, .topRight], radius: 20)
    }
    
    private func setView(){
        self.startButtonView.clipsToBounds = true
        self.roundViews.forEach { view in
            view.clipsToBounds = true
            view.layer.cornerRadius = 21
        }
    }
    
    
}//class
