//
//  AppDependenciesContainer.swift
//  Flourish
//
//  Created by Milos Otasevic on 10/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

class AppDependenciesContainer: LoginVCDataSourceDependencies, CreateAccountVCDataSourceDependencies, VerificationVCDataSourceDependencies, MyProgressVCDataSourceDependencies, ForgotPasswordVCDataSourceDependecies, DialogueMaestroVCDataSourceDependecies,DialogueMaestroCongratulationVCDataSourceDependecies, QuizzInfoVCDataSourceDepenecies, QuizzResultVCDataSourceDependecies{
    var loginUseCase: LoginUseCase = LoginInteractor(provider: LoginProvider())
    var registerUseCase: RegisterUseCase  = RegisterInteractor(provider: RegisterProvider())
    var verificationUseCase: VerificationUseCase = VerificationInteractor(provider: VerificationProvider())
    var myProgressUseCase: MyProgressUseCase = MyProgressUseCaseInteractor(provider: MyProgressProvider())
    var forgotPasswordUseCase: ForgotPasswordUseCase = ForgotPasswordInteractor(provider: ForgotPasswordProvider())
    var dialogueMaestroUseCase: DialogueMasterUseCase = DialogueMasterInteractor(provider: DialogueMasterProvider())
    var dialogueMasterResultUseCase: DialogueMasterResultUseCase = DialogueMasterResultInrteractor(provider: DialogueMasterResultsProvider())
    var quizzUseCase: QuizzUseCase  = QuizzInteractor(provider: QuizzProvider())
    var testResultsUseCase: TestResultsUseCase = TestResultsInteractor(provider: TestResultsProvider())

}
