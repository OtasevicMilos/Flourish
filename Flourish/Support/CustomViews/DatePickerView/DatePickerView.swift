//
//  DatePickerView.swift
//  Flourish
//
//  Created by Janko on 25/07/2020.
//  Copyright © 2020 Janko. All rights reserved.
//

import UIKit

class DatePickerView: UIView {
    var tapOnce=true
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var fallView: UIView!
    @IBOutlet weak var yearsTableView: UITableView!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var borderView: UIView!
    var callBack: (() ->())?
    var yearsArray=Array(1940...Calendar.current.component(.year, from: Date()))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        commonInit()
    }
    private func commonInit(){
        Bundle.main.loadNibNamed("DatePickerView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame=self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        createBorder()
        contentView.clipsToBounds=false
        yearsArray.reverse()
        
    }
    @IBAction func dateButton(_ sender: Any) {
        super.frame.size.height=200
        self.contentView.frame.size.height=200
        if tapOnce{
            tapOnce=false
            
            self.contentView.frame.size.height=200
            UIView.animate(withDuration: 0.4, animations: {
                
                self.layoutIfNeeded()
                
            })
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {_ in
                self.layoutIfNeeded()
                super.frame.size.height=200
                self.layoutIfNeeded()
            })
            
        }else{
            tapOnce=true
            self.contentView.frame.size.height=55
            UIView.animate(withDuration: 2, animations: {
                
                self.layoutIfNeeded()
            })
        }
    }
    
    func createBorder(){
        borderView.layer.cornerRadius=5
    }
}


extension DatePickerView:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yearsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        cell.textLabel?.text="\(yearsArray[indexPath.row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        yearTextField.text = "\(yearsArray[indexPath.row])"
        self.callBack?()
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}
