//
//  ForgotPasswordViewController.swift
//  Flourish
//
//  Created by Janko on 24/07/2020.
//  Copyright © 2020 Janko. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    let dataSourece: ForgotPasswordVCDataSource
    @IBOutlet weak var emailView: HopView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var backButton: UIButton!
    
    init(dataSourece: ForgotPasswordVCDataSource){
        self.dataSourece = dataSourece
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradients()
        self.setupHideKeyboardOnTap()
        self.setTextField()
    }
    override func viewDidLayoutSubviews() {
        emailView.clipsToBounds=false
        self.sendButton.roundCorners([.bottomLeft, .topRight], radius: 20)
        self.backButton.roundCorners([.bottomLeft, .topRight], radius: 20)
    }
    
    private func setTextField(){
        self.emailView.nameField.keyboardType = .emailAddress
        self.emailView.nameField.delegate = self
    }
    
    private func checkForm() -> Bool{
        if emailView.nameField.text?.isEmpty ?? true {
              self.showAlert(message: "You have not filled in all the fields.")
              return false
              }
              guard let mail = self.emailView.nameField.text else {return false}
              if !mail.checkEmail(){
                  self.showAlert(title: "ERROR",message: "The email was entered incorrectly.")
                  return false
              }
              return true
          }

    @IBAction func sendButton(_ sender: Any) {
        if !checkForm(){ return }
        guard let mail = self.emailView.nameField.text else {return }
        self.dataSourece.resetPassword(mail: mail) { [weak self] response in
            switch response{
            case .success:
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    self?.dismiss(animated: true, completion: nil)
                }
                
                let alert = UIAlertController(title: "GOOD", message: "message", preferredStyle: .alert)
                alert.addAction(okAction)
                self?.present(alert, animated: true, completion: nil)
            case .error(let eroroMess):
                self?.showAlert(message: eroroMess)
            }
        }
    }
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func setGradients(){
        self.sendButton.setFlourishGradien(withColors: [#colorLiteral(red: 0.7764705882, green: 0.4352941176, blue: 0.8941176471, alpha: 1).cgColor, #colorLiteral(red: 0.9607843137, green: 0.3098039216, blue: 0.3529411765, alpha: 1).cgColor])
        self.gradientView.setFlourishGradien()
    }
    
    private func showAlert(title: String = "INFO", message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}//class

//MARK: UITextFieldDelegate
extension ForgotPasswordViewController: UITextFieldDelegate{
    
}
