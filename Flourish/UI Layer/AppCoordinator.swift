//
//  AppCoordinator.swift
//  Flourish
//
//  Created by Milos Otasevic on 08/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import UIKit

class AppCoordinator{
    let window: UIWindow
    let dependencies = AppDependenciesContainer()
    var presenterVC: PresenterViewController?
    var myprogressVC: MyProgressViewController?
    var gamesVC: GamesViewController?
    var preferencesVC: UIViewController?
    var userID: Int?
    
    init(window: UIWindow = UIWindow(frame: UIScreen.main.bounds)) {
        self.window = window
    }
    
    func start(){
        let introVC = IntroVC()
        introVC.delegate = self
        window.rootViewController = introVC
        window.makeKeyAndVisible()
    }
}//class

//MARK: IntroViewControllerDelegate
extension AppCoordinator: IntroViewControllerDelegate{
    func showLoginVC() {
        
        let loginVC = LoginViewController(dataSource: LoginVCDataSource(dependencies: self.dependencies))
        loginVC.delegate = self
        window.rootViewController = loginVC
        window.makeKeyAndVisible()
    }
}

//for test
var firstTime = true
//MARK: LoginViewControllerDelegate
extension AppCoordinator: LoginViewControllerDelegate{
    func userSingIn() {
        if firstTime {
        let quizzVC = QuizzInfoViewController(dataSource: QuizzInfoVCDataSource(dependecies: self.dependencies))
        quizzVC.delegate = self
        self.window.rootViewController = quizzVC
        self.window.makeKeyAndVisible()
            firstTime = false
            return
        }
        
        if presenterVC == nil{
            self.presenterVC = PresenterViewController()
            self.presenterVC?.delegate = self
        }
        if self.myprogressVC == nil{
            self.myprogressVC = MyProgressViewController(dataSource: MyProgressVCDataSource(dependecies: self.dependencies))
            self.myprogressVC?.delegate = self
        }
        
        presenterVC?.vcToPressent = self.myprogressVC
        self.window.rootViewController = presenterVC
        self.window.makeKeyAndVisible()
        
    }
    
    func forgotPassword() {
        let forgotPasswordVC = ForgotPasswordViewController(dataSourece: ForgotPasswordVCDataSource(dependecies: self.dependencies))
        forgotPasswordVC.modalPresentationStyle = .overFullScreen
        window.rootViewController?.present(forgotPasswordVC, animated: true, completion: nil)
        
    }
    
    func createNewAccount(){
        let createAccount = CreateAccountViewController(dataSource: CreateAccountVCDataSource(dependencies: self.dependencies))
        createAccount.delegate = self
        createAccount.modalPresentationStyle = .overFullScreen
        window.rootViewController?.present(createAccount, animated: true, completion: nil)
    }
}

//MARK: CreateAccountViewControllerDelegate
extension AppCoordinator: CreateAccountViewControllerDelegate{
    func createAccount(userId: Int) {
        self.userID = userId
        let checkInboxVC = CheckInboxViewController()
        checkInboxVC.delegate = self
        checkInboxVC.modalPresentationStyle = .overFullScreen
        window.rootViewController?.presentedViewController?.present(checkInboxVC, animated: true, completion: nil)
    }
}

//MARK: CheckInboxViewControllerDelegate
extension AppCoordinator: CheckInboxViewControllerDelegate{
    func vcFinish() {
        guard let userID = self.userID else {return}
        let verificationVC = VerificationViewController(dataSource: VerificationVCDataSource(dependencies: self.dependencies, userID: userID))
        verificationVC.delegate = self
        verificationVC.modalPresentationStyle = .overFullScreen
        window.rootViewController?.presentedViewController?.present(verificationVC, animated: true, completion: nil)
    }
}

//MARK: ConfirmViewControllerDelegate
extension AppCoordinator: ConfirmViewControllerDelegate{
    func finish() {
        self.showLoginVC()
    }
}

//MARK: VerificationViewControllerDelegate
extension AppCoordinator: VerificationViewControllerDelegate{
    func verificationFinish() {
        let confirmVC = ConfirmViewController()
        confirmVC.delegate = self
        confirmVC.modalPresentationStyle = .overFullScreen
        window.rootViewController?.presentedViewController?.presentedViewController?.present(confirmVC, animated: true, completion: nil)
    }
}

//MARK: PresenterViewControllerDelegare
extension AppCoordinator: PresenterViewControllerDelegare{
    func showMyProgressVC() {
        self.presenterVC?.present(myprogressVC)
    }
    
    func showGamesVC() {
        if gamesVC == nil{
            self.gamesVC = GamesViewController(dataSource: GamesVCDataSource())
            self.gamesVC?.feedback = self.presenterVC
        }
        self.presenterVC?.present(gamesVC)
    }
    
    func showPreferencesVC() {
        if preferencesVC == nil{
            self.preferencesVC = UIViewController()
            self.preferencesVC?.view.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }
        self.presenterVC?.present(preferencesVC)
    }    }


//MARK: DialogueMaestroViewControllerDelegate
extension AppCoordinator: DialogueMaestroViewControllerDelegate{
    func endGame() {
        self.userSingIn()
    }
    
    func startGame(questions: [Question]) {
        let dialogueMaestroGameVC = DialogueMaestroGameViewController(questions: questions)
        dialogueMaestroGameVC.delegate = self
        dialogueMaestroGameVC.modalPresentationStyle = .overFullScreen
        window.rootViewController?.present(dialogueMaestroGameVC, animated: true, completion: nil)
    }
}

//MARK: MyProgressViewControllerDelegate
extension AppCoordinator: MyProgressViewControllerDelegate{
    
    func startDialogueMaestro() {
        let dialogueMaestroVC = DialogueMaestroViewController(dataSource: DialogueMaestroVCDataSource(dependencies: self.dependencies))
        dialogueMaestroVC.delegate = self
        window.rootViewController = dialogueMaestroVC
        window.makeKeyAndVisible()
    }
}

//MARK:DialogueMaestroGameViewControllerDelegate
extension AppCoordinator: DialogueMaestroGameViewControllerDelegate{
    func gameFinish(points: [Int]) {
        let dialogueMaestroCongratulationVC = DialogueMaestroCongratulationViewController(dataSource: DialogueMaestroCongratulationVCDataSource(dependecies: self.dependencies, points: points))
        dialogueMaestroCongratulationVC.delegate = self
        window.rootViewController = dialogueMaestroCongratulationVC
        window.makeKeyAndVisible()
    }
    
    
    func gameOver() {
        let dialogueMaestroGameOverVC = DialogueMaestroGameOverViewController()
        dialogueMaestroGameOverVC.delegate = self
        window.rootViewController = dialogueMaestroGameOverVC
        window.makeKeyAndVisible()
    }
}

//MARK: DialogueMaestroGameOverViewControllerDelegate
extension AppCoordinator: DialogueMaestroGameOverViewControllerDelegate{
    func tryAgain() {
        self.startDialogueMaestro()
    }
    
    func finishGame() {
        self.userSingIn()
    }
}

//MARK: DialogueMaestroCongratulationViewControllerDelegate
extension AppCoordinator: DialogueMaestroCongratulationViewControllerDelegate{
    func finishDialogueMaestro() {
        self.userSingIn()
    }
}

//MARK: QuizzInfoViewControllerDelegate
extension AppCoordinator: QuizzInfoViewControllerDelegate{
    func takeTest(quizz: Quizz) {
        let quizzVC = QuizzViewController(dataSource: QuizzVCDataSource(dependecies: self.dependencies, quizz: quizz))
        quizzVC.delegate = self
        window.rootViewController = quizzVC
        window.makeKeyAndVisible()
    }
}

//MARK: QuizzResultViewControllerDelegate
extension AppCoordinator: QuizzResultViewControllerDelegate{
    func showSingleCategory(_ singleResult: SingleResult, categoryColor: UIColor) {
        let quizzSingleResultViewController = QuizzSingleResultViewController(dataSource: QuizzSingleResultVCDataSource(singleResult: singleResult, categoryColor: categoryColor))
        quizzSingleResultViewController.modalPresentationStyle = .overFullScreen
        window.rootViewController?.present(quizzSingleResultViewController, animated: true, completion: nil)
    }
    
    func showHome() {
        if presenterVC == nil{
            self.presenterVC = PresenterViewController()
            self.presenterVC?.delegate = self
        }
        if self.myprogressVC == nil{
            self.myprogressVC = MyProgressViewController(dataSource: MyProgressVCDataSource(dependecies: self.dependencies))
            self.myprogressVC?.delegate = self
        }
        
        presenterVC?.vcToPressent = self.myprogressVC
        self.window.rootViewController = presenterVC
        self.window.makeKeyAndVisible()
    }
}

//MARK: QuizzViewControllerDelegate
extension AppCoordinator: QuizzViewControllerDelegate{
    func showResults() {
        let quizzResultVC = QuizzResultViewController(dataSource: QuizzResultVCDataSource(dependecies: self.dependencies))
        quizzResultVC.delegate = self
        window.rootViewController = quizzResultVC
        window.makeKeyAndVisible()
    }
    
    func exitQuizz(){
        self.showLoginVC()
    }
}
