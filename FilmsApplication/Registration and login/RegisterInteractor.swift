//
//  RegisterInteractor.swift
//  FilmsApplication
//
//  Created by Kamil on 26.07.2023.
//

import Firebase

protocol RegisterInteractorInput {
    func checkFields(username: String, email: String, password: String)
}

protocol RegisterInteractorOutput: AnyObject {
    func didChangeState(newState: AuthCases)
}


class RegisterInteractor {
    weak var output: RegisterInteractorOutput?
}

extension RegisterInteractor: RegisterInteractorInput {
    func checkFields(username: String, email: String, password: String) {
        guard !password.isEmpty, !email.isEmpty, !username.isEmpty
        else {
            output?.didChangeState(newState: .failure)
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [self] (result, error) in
            if error == nil {
                let ref = Database.database(url: "https://filmsapplication-6d462-default-rtdb.europe-west1.firebasedatabase.app").reference().child("users")
                ref.child(result!.user.uid).updateChildValues(["username": username, "email": email])
                
                output?.didChangeState(newState: .success)
            } else {
                output?.didChangeState(newState: .failure)
            }
        }
        
    }
}
