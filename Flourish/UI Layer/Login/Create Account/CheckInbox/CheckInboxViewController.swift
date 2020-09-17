//
//  CheckInboxViewController.swift
//  Flourish
//
//  Created by Milos Otasevic on 10/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import UIKit

protocol CheckInboxViewControllerDelegate {
    func vcFinish()
}
class CheckInboxViewController: UIViewController {
    var delegate: CheckInboxViewControllerDelegate?
    @IBOutlet weak var okButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setView()
    }
    
    private func setView(){
        okButton.roundCorners([.bottomLeft, .topRight], radius: 20)
        okButton.setFlourishGradien(start: CGPoint(x: -0.4, y: 0.5))
    }
    @IBAction func okButtonPressed(_ sender: Any) {
        self.dismiss(animated: true) {
        self.delegate?.vcFinish()
        }
    }
}//class
