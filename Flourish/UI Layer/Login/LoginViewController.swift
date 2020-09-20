//
//  LoginViewController.swift
//  Flourish
//
//  Created by Milos Otasevic on 08/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import UIKit

protocol LoginViewControllerDelegate {
    func forgotPassword()
    func userSingIn()
    func createNewAccount()
}
class LoginViewController: UIViewController {
    var delegate: LoginViewControllerDelegate?
    let dataSource: LoginVCDataSource
    @IBOutlet weak var mailCustomView: HopView!
    @IBOutlet weak var passwordCustomView: HopView!
    @IBOutlet weak var languageView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var downLineView: UIView!
    
    init(dataSource: LoginVCDataSource){
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init error") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setView()
        self.setupHideKeyboardOnTap()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setLoginButton()
        
        self.mailCustomView.nameField.text = "lukamugosa1945@gmail.com"
        self.passwordCustomView.nameField.text = "12345678"
    }
    
    private func setLoginButton(){
        self.loginButton.setFlourishGradien(withColors: [#colorLiteral(red: 0.7764705882, green: 0.4352941176, blue: 0.8941176471, alpha: 1).cgColor, #colorLiteral(red: 0.9607843137, green: 0.3098039216, blue: 0.3529411765, alpha: 1).cgColor])
        self.loginButton.roundCorners([.bottomLeft, .topRight], radius: 20)
    }
    
    private func setView(){
        self.mailCustomView.nameField.delegate = self
        self.passwordCustomView.nameField.delegate = self
        self.languageView.layer.borderWidth = 1
        self.languageView.layer.cornerRadius = 14
        self.languageView.clipsToBounds = true
        self.loginButton.clipsToBounds = true
        self.loginButton.backgroundColor = #colorLiteral(red: 0.1882187724, green: 0.1882653832, blue: 0.4429796934, alpha: 1)
        self.loginButton.roundCorners([.bottomLeft, .topRight], radius: 20)
        self.loginButton.clipsToBounds = true
        self.downLineView.setFlourishGradien()
        self.mailCustomView.nameField.keyboardType = .emailAddress
        self.passwordCustomView.nameField.isSecureTextEntry = true
    }
    
    private func checkForm() -> Bool{
        if mailCustomView.nameField.text?.isEmpty ?? true || passwordCustomView.nameField.text?.isEmpty ?? true{
            self.showAlert(message: "You have not filled in all the fields.")
            return false
        }
        guard let password = self.passwordCustomView.nameField.text else {return false}
        guard let mail = self.mailCustomView.nameField.text else {return false}
        if !mail.checkEmail(){
            self.showAlert(title: "ERROR",message: "The email was entered incorrectly.")
            return false
        }
        if password.count < 8{
            self.showAlert(title: "ERROR",message: "The password must have a minimum of 8 characters.")
            return false
        }
        return true
    }
    
    @IBAction func forgotPasswordButtonPressed(_ sender: Any) {
        self.delegate?.forgotPassword()
    }
    @IBAction func createAccountButtonPressed(_ sender: Any) {
        self.delegate?.createNewAccount()
    }
    @IBAction func singinButtonPressed(_ sender: Any) {
        if !checkForm(){ return }
        self.dataSource.loginUser(email: self.mailCustomView.nameField.text!, password: self.passwordCustomView.nameField.text!){ response in
            switch response{
            case .success(let user):
                self.delegate?.userSingIn()
            case .error(let error):
                switch error {
                case WebServiceError.noInternetConnection:
                    self.showAlert(message: "Check your internet connection.")
                default:
                    self.showAlert(message: "The mail or password is incorrect.")
                }
                
                
            }
        }
    }
    @IBAction func seePasswordButtonPressed(_ sender: Any) {
        self.passwordCustomView.nameField.isSecureTextEntry.toggle()
    }
    
    private func showAlert(title: String = "INFO", message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}//class

//MARK: UITextViewDelegate
extension LoginViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.mailCustomView.nameField && self.passwordCustomView.nameField.text?.isEmpty ?? false {
            self.passwordCustomView.contentViewTapped()
            self.passwordCustomView.nameField.becomeFirstResponder()
            return true
        }else{
            self.view.endEditing(true)
            return false
        }
    }
}
