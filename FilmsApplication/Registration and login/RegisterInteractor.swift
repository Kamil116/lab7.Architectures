//
//  RegisterInteractor.swift
//  FilmsApplication
//
//  Created by Kamil on 26.07.2023.
//

import Firebase

protocol RegisterLogic {
    func checkFields(request: Models.FetchUser.Request)
}

class RegisterInteractor {
    var presenter: RegisterPresentationLogic?
}

extension RegisterInteractor: RegisterLogic {
    
    func checkFields(request: Models.FetchUser.Request) {
        let username = request.username
        let password = request.password
        let email = request.email
        guard !password.isEmpty, !email.isEmpty, !username.isEmpty
        else {
            presenter?.presentUser(newState: .failure)
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [self] (result, error) in
            if error == nil {
                let ref = Database.database(url: "https://filmsapplication-6d462-default-rtdb.europe-west1.firebasedatabase.app").reference().child("users")
                ref.child(result!.user.uid).updateChildValues(["username": username, "email": email])
                
                presenter?.presentUser(newState: .success)
            } else {
                presenter?.presentUser(newState: .failure)
            }
        }
    }
    
}
