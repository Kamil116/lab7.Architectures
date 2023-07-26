//
//  RegisterFactory.swift
//  FilmsApplication
//
//  Created by Kamil on 26.07.2023.
//

import UIKit

class RegisterFactory {
    let password: String
    let email: String
    let username: String
    
    init(password: String, email: String, username: String) {
        self.password = password
        self.email = email
        self.username = username
    }
    
    func produce() -> UIViewController {
        let interactor = RegisterInteractor()
        let presenter = RegisterPresenter(interactor: interactor)
        let viewController = RegisterViewController(output: presenter)
        
        interactor.output = presenter
        presenter.view = viewController
        
        return viewController
    }
}
