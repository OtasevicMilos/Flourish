//
//  CreateAccountViewController.swift
//  Flourish
//
//  Created by Janko on 25/07/2020.
//  Copyright © 2020 Janko. All rights reserved.
//

import UIKit

protocol CreateAccountViewControllerDelegate{
    func createAccount(userId: Int)
}

class CreateAccountViewController: UIViewController {
    let dataSource: CreateAccountVCDataSource
    var delegate: CreateAccountViewControllerDelegate?
    @IBOutlet weak var yearsViewHC: NSLayoutConstraint!
    @IBOutlet weak var emailVuew: HopView!
    @IBOutlet weak var yearsView: DatePickerView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var fullNameCustomView: HopView!
    @IBOutlet weak var phoneCusotmView: HopView!
    @IBOutlet weak var emailCustomView: HopView!
    @IBOutlet weak var passwordCustomView: HopView!
    @IBOutlet weak var repeatPasswordCustomView: HopView!
    @IBOutlet var customViews: [HopView]!
    var textFieds = [UITextField]()
    
    init(dataSource: CreateAccountVCDataSource){
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init") }
    
    var yearViewHCConstant:CGFloat = 0
    var dropYearTapped = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTextFields()
        self.setupHideKeyboardOnTap()
        self.yearsView.callBack = {self.dropYearsActive()}
        self.yearsView.yearTextField.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        yearViewHCConstant = yearsViewHC.constant
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        createAccountButton.setFlourishGradien(start: CGPoint(x: -0.4, y: 0.5))
        gradientView.setFlourishGradien()
        createAccountButton.roundCorners([.bottomLeft, .topRight], radius: 20)
        backButton.roundCorners([.bottomLeft, .topRight], radius: 20)
        
    }
    
    private func setTextFields(){
        self.phoneCusotmView.nameField.keyboardType = .phonePad
        self.emailCustomView.nameField.keyboardType = .emailAddress
        self.passwordCustomView.nameField.isSecureTextEntry = true
        self.repeatPasswordCustomView.nameField.isSecureTextEntry = true
        
        self.fullNameCustomView.nameField.delegate = self
        self.phoneCusotmView.nameField.delegate = self
        self.emailCustomView.nameField.delegate = self
        self.passwordCustomView.nameField.delegate = self
        self.repeatPasswordCustomView.nameField.delegate = self
        
        self.textFieds.append(fullNameCustomView.nameField)
        self.textFieds.append(phoneCusotmView.nameField)
        self.textFieds.append(emailCustomView.nameField)
        self.textFieds.append(passwordCustomView.nameField)
        self.textFieds.append(repeatPasswordCustomView.nameField)
    }
    
    @IBAction func dropYearsViewButton(_ sender: Any) {
        self.dropYearsActive()
    }
    
    func dropYearsActive(){
        if dropYearTapped{
            yearsViewHC.constant = 200
            dropYearTapped=false
        }else{
            yearsViewHC.constant=yearViewHCConstant
            dropYearTapped=true
        }
    }

    
    @IBAction func createAccountButton(_ sender: Any) {
        if !checkForm() {return}
        guard let name = self.fullNameCustomView.nameField.text else {return}
        guard let email = self.emailCustomView.nameField.text else {return}
        guard let password = self.passwordCustomView.nameField.text else {return}
        guard let phoneNumber = self.phoneCusotmView.nameField.text else {return}
        let birthYear = self.yearsView.yearTextField.text ?? "2020"


        self.dataSource.register(name: name, email: email, password: password, phoneNumber: phoneNumber, birthYear: birthYear){ [weak self] result in
            switch result{
            case .error(let errorMessage):
                self?.showAlert(message: errorMessage)
            case .success(let userID):
                self?.delegate?.createAccount(userId: userID)
            }
        }
    }
    
    private func checkForm() -> Bool{
        if fullNameCustomView.nameField.text?.isEmpty ?? true ||  phoneCusotmView.nameField.text?.isEmpty ?? true || emailCustomView.nameField.text?.isEmpty ?? true || passwordCustomView.nameField.text?.isEmpty ?? true || repeatPasswordCustomView.nameField.text?.isEmpty ?? true{
            self.showAlert(message: "You have not filled in all the fields.")
            return false
        }
        if fullNameCustomView.nameField.text?.count ?? 1 < 4 {
            self.showAlert(title: "ERROR",message: "Name and surname must have a minimum of 4 characters.")
            return false
        }
        
        if phoneCusotmView.nameField.text?.count ?? 1 < 9 {
            self.showAlert(title: "ERROR",message: "the phone number must have a minimum of 9 numbers.")
            return false
        }
        if phoneCusotmView.nameField.text?.count ?? 1 < 9 {
            self.showAlert(title: "ERROR",message: "The phone number must have a minimum of 9 numbers.")
            return false
        }
        
        if let phone = phoneCusotmView.nameField.text, !phone.checkPhoneNumber() {
            self.showAlert(title: "ERROR",message: "The phone number was entered incorrectly.")
            return false
        }
        
        if let mail = emailCustomView.nameField.text, !mail.checkEmail() {
            self.showAlert(title: "ERROR",message: "The email was entered incorrectly.")
            return false
        }
        
        if passwordCustomView.nameField.text?.count ?? 1 < 8 {
            self.showAlert(title: "ERROR",message: "The password must have a minimum of 8 characters.")
            return false
        }
        
        if passwordCustomView.nameField.text != repeatPasswordCustomView.nameField.text {
            self.showAlert(title: "ERROR",message: "The passwords do not match.")
            return false
        }
        return true
    }
    
    private func showAlert(title: String = "INFO", message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func seePasswordButtonPressed(_ sender: Any) {
        self.passwordCustomView.nameField.isSecureTextEntry.toggle()
    }
    
    @IBAction func seeRepeatPasswordButtonPressed(_ sender: Any) {
        self.repeatPasswordCustomView.nameField.isSecureTextEntry.toggle()
    }
}//class

//MARK: UITextFieldDelegate
extension CreateAccountViewController: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.passwordCustomView.nameField ||  textField == self.repeatPasswordCustomView.nameField {
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = -200
            }
        }else{
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = 0
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let last = self.textFieds.last, textField == last {
            self.view.endEditing(true)

            return true
        }
        let position = self.textFieds.firstIndex(of: textField)
        guard let positionInt = position else {
            return true}
        for postition in (positionInt + 1)..<self.textFieds.count{
            if self.textFieds[postition].text?.isEmpty ?? false {
                self.textFieds[postition].becomeFirstResponder()
                self.customViews[postition].viewPressed()
                return true
            }
        }
        self.view.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.yearsView.yearTextField, let year = self.yearsView.yearTextField.text {
            if year.count != 4{
            self.yearsView.yearTextField.text = "2020"
        }
            if let yearInt = Int(year){
                if yearInt < self.yearsView.yearsArray.first ?? 1945 || yearInt > self.yearsView.yearsArray.last ?? 2020{
                    self.yearsView.yearTextField.text = "2020"
                }
            }else{
                self.yearsView.yearTextField.text = "2020"
            }
        }
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0
        }
    }
}
