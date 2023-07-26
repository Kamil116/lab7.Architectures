//
//  RegisterPresenter.swift
//  FilmsApplication
//
//  Created by Kamil on 26.07.2023.
//

import Foundation

class RegisterPresenter {
    let interactor: RegisterInteractorInput
    weak var view: RegisterViewInput?
    
    init(interactor: RegisterInteractorInput) {
        self.interactor = interactor
    }
}

extension RegisterPresenter: RegisterViewOutput {
    func viewDidTapButton(username: String, email: String, password: String) {
        interactor.checkFields(username: username, email: email, password: password)
    }
    
    
}

extension RegisterPresenter: RegisterInteractorOutput {
    func didChangeState(newState: AuthCases) {
        view?.display(status: newState)
    }
    
    
}
