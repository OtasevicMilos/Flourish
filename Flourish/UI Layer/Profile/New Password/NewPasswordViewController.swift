//
//  NewPasswordViewController.swift
//  Flourish
//
//  Created by Janko on 24/07/2020.
//  Copyright © 2020 Janko. All rights reserved.
//

import UIKit

class NewPasswordViewController: UIViewController {
    
    @IBOutlet var repeatPassView: HopView!
    @IBOutlet var newPassView: HopView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var gradientView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.roundCorners([.bottomLeft, .topRight], radius: 20)
        gradientView.setFlourishGradien()
        saveButton.setFlourishGradien()
        // Do any additional setup after loading the view.
    }
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func saveButton(_ sender: Any) {
        navigationController?.pushViewController(ConfirmViewController(), animated: true)
    }
    
    
    
    
}
