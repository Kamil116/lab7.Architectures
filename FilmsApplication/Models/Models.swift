//
//  Models.swift
//  FilmsApplication
//
//  Created by Kamil on 26.07.2023.
//

enum Models {
    enum FetchUser {
        
        struct Request {
            let username: String
            let password: String
            let email: String
        }
        
        struct ViewModel {
            let state: AuthCases
        }
    }
}
