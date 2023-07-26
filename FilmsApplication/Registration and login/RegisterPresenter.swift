//
//  RegisterPresenter.swift
//  FilmsApplication
//
//  Created by Kamil on 26.07.2023.
//

import Foundation

protocol RegisterPresentationLogic: AnyObject {
    func presentUser(newState: AuthCases)
}

class RegisterPresenter {
    weak var view: RegisterDisplayLogic?
}

extension RegisterPresenter: RegisterPresentationLogic {
    func presentUser(newState: AuthCases) {
        let viewModel = Models.FetchUser.ViewModel(state: newState)
        view?.display(viewModel: viewModel)
    }
        
}

