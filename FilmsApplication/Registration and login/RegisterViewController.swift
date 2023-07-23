//
//  ViewController.swift
//  FilmsApplication
//
//  Created by Kamil on 18.07.2023.
//

import UIKit
import Firebase


final class RegisterViewController: UIViewController {
    
    //MARK: Private properties
    private let usernameTextField = GeneralTextField(placeholder: "Enter your username")
    private let emailTextField = GeneralTextField(placeholder: TextsEnum.enterEmail.rawValue)
    private let passwordTextField = GeneralTextField(placeholder: TextsEnum.enterPassword.rawValue)
    
    private let signUpButton = UIButton()
    private let signInButton = UIButton()
    
    private let usernameLabel = UILabel()
    private let emailLabel = UILabel()
    private let passwordLabel = UILabel()
    private let askLabel = UILabel()
    
    private let eyeButtonForPassword = EyeButton()
    
    private var isEyeButtonForPasswordPrivate = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    
    //MARK: Private methods
    @objc private func signUpButtonClicked() {
        guard let password = passwordTextField.text, !password.isEmpty, let email = emailTextField.text, !email.isEmpty, let username = usernameTextField.text, !username.isEmpty
        else {
            showAlertWithWarning(TextsEnum.fillFields.rawValue)
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error == nil {
                let ref = Database.database(url: "https://filmsapplication-6d462-default-rtdb.europe-west1.firebasedatabase.app").reference().child("users")
                ref.child(result!.user.uid).updateChildValues(["username": self.usernameTextField.text!, "email": self.emailTextField.text!])
                
                self.goToMainPage()
                
            } else {
                print(error.debugDescription)
                self.showAlertWithWarning(TextsEnum.invalidData.rawValue)
            }
        }
    }
    
    func goToMainPage() {
        let tab = UITabBarController()
        
        let home = UINavigationController(rootViewController: HomeViewController())
        home.title = "Home"
        let search = UINavigationController(rootViewController: SearchViewController())
        search.title = "Search"
        let profile = UINavigationController(rootViewController: ProfileViewController())
        profile.title = "Profile"
        
        
        
        tab.tabBar.tintColor = .black
        
        
        
        
        tab.setViewControllers([home, search, profile], animated: false)
        
        guard let items = tab.tabBar.items else { return }
        
        let images = ["house", "magnifyingglass.circle", "person.circle"]
        
        for i in 0...2 {
            items[i].image = UIImage(systemName: images[i])
        }
        
        tab.modalPresentationStyle = .fullScreen
        
        navigationController?.present(tab, animated: true)
    }
    
    @objc private func signInButtonClicked() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
        
        //        let tab = UITabBarController()
        //
        //        let home = UINavigationController(rootViewController: HomeViewController())
        //        home.title = "Home"
        //        let search = UINavigationController(rootViewController: SearchViewController())
        //        search.title = "Search"
        //        let profile = UINavigationController(rootViewController: ProfileViewController())
        //        profile.title = "Profile"
        //
        //
        //
        //        tab.tabBar.tintColor = .black
        //
        //
        //
        //
        //        tab.setViewControllers([home, search, profile], animated: false)
        //
        //        guard let items = tab.tabBar.items else { return }
        //
        //        let images = ["house", "magnifyingglass.circle", "person.circle"]
        //
        //        for i in 0...2 {
        //            items[i].image = UIImage(systemName: images[i])
        //        }
        //
        //        tab.modalPresentationStyle = .fullScreen
        //
        //        navigationController?.present(tab, animated: true)
        
    }
    
    private func showAlertWithWarning(_ warning: String) {
        let alert = UIAlertController(title: "Warning", message: warning, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func eyeButtonForPasswordPressed() {
        let imageName = isEyeButtonForPasswordPrivate ? "eye" : "eye.slash"
        passwordTextField.isSecureTextEntry.toggle()
        eyeButtonForPassword.setImage(UIImage(systemName: imageName), for: .normal)
        isEyeButtonForPasswordPrivate.toggle()
    }
    
}

// MARK: Setting views

private extension RegisterViewController {
    func setupView() {
        view.backgroundColor = .white
        addSubViews()
        addActions()
        
        configureLabels()
        configureSignUpButton()
        configureSignInButton()
        configureTextFields()
    }
}

// MARK: Configurations

private extension RegisterViewController {
    func addSubViews() {
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(emailTextField)
        
        view.addSubview(usernameLabel)
        view.addSubview(emailLabel)
        view.addSubview(passwordLabel)
        view.addSubview(askLabel)
        
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
    }
    
    func addActions() {
        eyeButtonForPassword.addTarget(self, action: #selector(self.eyeButtonForPasswordPressed), for: .touchUpInside)
    }
    
    func configureLabels() {
        usernameLabel.textColor = .black
        usernameLabel.text = "Username"
        usernameLabel.font = .systemFont(ofSize: 22)
        setLabelConstraints(toItem: usernameLabel, topAnchorConstraint: 0)
        
        emailLabel.textColor = .black
        emailLabel.text = TextsEnum.email.rawValue
        emailLabel.font = .systemFont(ofSize: 22)
        setLabelConstraints(toItem: emailLabel, topAnchorConstraint: 130)
        
        passwordLabel.textColor = .black
        passwordLabel.text = TextsEnum.password.rawValue
        passwordLabel.font = .systemFont(ofSize: 22)
        setLabelConstraints(toItem: passwordLabel, topAnchorConstraint: 260)
        
        askLabel.textColor = .black
        askLabel.text = "Already have an account?"
        askLabel.textAlignment = .center
        askLabel.font = .systemFont(ofSize: 22)
        setLabelConstraints(toItem: askLabel, topAnchorConstraint: 460)
    }
    
    func configureTextFields() {
        usernameTextField.autocapitalizationType = .none
        emailTextField.autocapitalizationType = .none
        emailTextField.keyboardType = .emailAddress
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        passwordTextField.rightView = eyeButtonForPassword
        passwordTextField.rightViewMode = .always
        
        setTextFieldConstraints(toItem: usernameTextField, topAnchorConstraint: 50)
        setTextFieldConstraints(toItem: emailTextField, topAnchorConstraint: 180)
        setTextFieldConstraints(toItem: passwordTextField, topAnchorConstraint: 310)
    }
    
    func configureSignInButton() {
        signInButton.setTitle("Sign in", for: .normal)
        signInButton.setTitleColor(UIColor.white, for: .normal)
        signInButton.titleLabel?.font = .systemFont(ofSize: 20)
        setButtonConstraints(toItem: signInButton, topAnchorConstraint: 510)
        signInButton.layer.cornerRadius = 10
        signInButton.layer.backgroundColor = UIColor.black.cgColor
        signInButton.addTarget(self, action:#selector(self.signInButtonClicked), for: .touchUpInside)
    }
    
    func configureSignUpButton() {
        signUpButton.setTitle("Sign up", for: .normal)
        signUpButton.titleLabel?.font = .systemFont(ofSize: 20)
        setButtonConstraints(toItem: signUpButton, topAnchorConstraint: 390)
        signUpButton.setTitleColor(UIColor.white, for: .normal)
        signUpButton.layer.cornerRadius = 10
        signUpButton.layer.backgroundColor = UIColor.black.cgColor
        signUpButton.addTarget(self, action:#selector(self.signUpButtonClicked), for: .touchUpInside)
        
    }
}

// MARK: Constraints

private extension RegisterViewController {
    
    func setTextFieldConstraints(toItem: UITextField, topAnchorConstraint: CGFloat) {
        toItem.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toItem.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topAnchorConstraint),
            toItem.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            toItem.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -70)
        ])
    }
    
    func setLabelConstraints(toItem: UILabel, topAnchorConstraint: CGFloat) {
        toItem.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toItem.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topAnchorConstraint),
            toItem.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            toItem.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -70),
            toItem.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.07)
        ])
    }
    
    func setButtonConstraints(toItem: UIButton, topAnchorConstraint: CGFloat) {
        toItem.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toItem.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topAnchorConstraint),
            toItem.widthAnchor.constraint(equalToConstant: 100),
            toItem.heightAnchor.constraint(equalToConstant: 50)
        ])
        toItem.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}