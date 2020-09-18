//
//  VerificationViewController.swift
//  Flourish
//
//  Created by Milos Otasevic on 09/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import UIKit

protocol VerificationViewControllerDelegate{
    func verificationFinish()
}

class VerificationViewController: UIViewController {
    let dataSource: VerificationVCDataSource
    var delegate: VerificationViewControllerDelegate?
    @IBOutlet weak var gradientLineView: UIView!
    @IBOutlet weak var backButtonView: UIButton!
    @IBOutlet weak var nextButtonView: UIButton!
    @IBOutlet var codeTextFields: [UITextField]!
    
    init(dataSource: VerificationVCDataSource){
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {  fatalError("init")}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setView()
        self.setTextFields()
    }
    
    private func setTextFields(){
        self.codeTextFields.forEach { codeField in
            codeField.layer.cornerRadius = 5
            codeField.clipsToBounds = true
            codeField.delegate = self
        }
    }
    
    private func setView(){
        self.gradientLineView.setFlourishGradien()
        self.nextButtonView.setFlourishGradien(start: CGPoint(x: -0.4, y: 0.5))
        self.nextButtonView.roundCorners([.bottomLeft, .topRight], radius: 20)
        self.backButtonView.roundCorners([.bottomLeft, .topRight], radius: 20)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func verificationButtonPressed(_ sender: Any) {
        var code = ""
        for codeTextField in self.codeTextFields {
            if codeTextField.text?.count ?? 0 < 1{
                codeTextField.shake()
                return
            }
            code.append(contentsOf: codeTextField.text!)
        }
        self.dataSource.verifyMail(code: code) { [weak self] response in
            switch response {
            case .success(let resu):
                self?.delegate?.verificationFinish()
            case .error(let error):
                switch error {
                case WebServiceError.noInternetConnection:
                    self?.showAlert(message: "Check your internet connection.")
                default:
                    self?.showAlert(message: "Please try again")
                }
                
            }
        }
    }
    
    private func showAlert(title: String = "INFO", message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func resendCodeButtonPressed(_ sender: Any) {
        self.dataSource.resetCode()
    }
}//class

//MARK: UITextFieldDelegate
extension VerificationViewController: UITextFieldDelegate{
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text?.isEmpty ?? true { return}
        textField.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1)
        textField.borderStyle = .none
        switch textField {
        case self.codeTextFields[0]:
            self.codeTextFields[1].becomeFirstResponder()
        case self.codeTextFields[1]:
            self.codeTextFields[2].becomeFirstResponder()
        case self.codeTextFields[2]:
            self.codeTextFields[3].becomeFirstResponder()
        default:
            textField.endEditing(true)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor.clear
        
    }
    
}


