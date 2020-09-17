//
//  HopView.swift
//  Flourish
//
//  Created by Janko on 24/07/2020.
//  Copyright © 2020 Janko. All rights reserved.
//

import UIKit

class HopView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    
    var tapOnce=true
    @IBOutlet weak var textTC: NSLayoutConstraint!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var hopHC: NSLayoutConstraint!
    @IBOutlet weak var hopLC: NSLayoutConstraint!
    @IBOutlet weak var hopTC: NSLayoutConstraint!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var clipView: UIView!
    
    @IBInspectable var hint:String="" {
        didSet{
            hintLabel.text=hint
        }
    }
    @IBInspectable var type:String="" {
           didSet{
               typeLabel.text=type
           }
       }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        commonInit()
    }
    private func commonInit(){
        Bundle.main.loadNibNamed("HopView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame=self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addGestures()
        createBorder()
        contentView.clipsToBounds=false
        backgroundView.clipsToBounds=false
        clipView.clipsToBounds=false
        
    }
    func createBorder(){
        let borderView=UIView()
        borderView.frame = CGRect(x: 1, y: 1, width: backgroundView.bounds.size.width-2, height: backgroundView.bounds.size.height-2)
        borderView.backgroundColor=UIColor.white
        borderView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        borderView.layer.cornerRadius=4
        
        backgroundView.addSubview(borderView)
    }
    
}

extension HopView{
    func addGestures(){
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(contentViewTapped)))
        
    }
    
    func viewPressed(){
        self.contentViewTapped()
    }
    @objc func contentViewTapped() {
        
        if tapOnce{
            tapOnce=false
            hintLabel.isHidden=true
            
            UIView.animate(withDuration: 0.5, animations: {
                self.hopTC.constant=self.hopTC.constant-20
                self.hopLC.constant=self.hopLC.constant-30
                self.hopHC.constant=75
                self.textTC.constant=self.textTC.constant-20
                self.layoutIfNeeded()
                self.nameField.becomeFirstResponder()
            }, completion: { result in
                if result{
                    //       self.textTC.constant=self.textTC.constant-20
                }
                
            })
        }
    }
    
    
    
}
