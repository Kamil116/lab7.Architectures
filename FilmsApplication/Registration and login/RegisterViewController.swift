//
//  ViewController.swift
//  FilmsApplication
//
//  Created by Kamil on 18.07.2023.
//

import UIKit
import Firebase

enum AuthCases {
    case success
    case failure
}

protocol RegisterViewOutput {
    func viewDidTapButton(username: String, email: String, password: String)
}

protocol RegisterViewInput: AnyObject {
    func display(status: AuthCases)
}

final class RegisterViewController: UIViewController {
    
    //MARK: Private properties
    private let usernameTextField = GeneralTextField(placeholder: "Enter your username")
    private let emailTextField = GeneralTextField(placeholder: "Enter your email")
    private let passwordTextField = GeneralTextField(placeholder: "Enter your password")
    
    private let signUpButton = UIButton()
    private let registrationLabel = UILabel()
    
    let output: RegisterViewOutput
    
    init(output: RegisterViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Private methods
    @objc private func signUpButtonClicked() {
        output.viewDidTapButton(username: usernameTextField.text ?? "", email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
}

// MARK: Setting views

private extension RegisterViewController {
    func setupView() {
        view.backgroundColor = .white
        addSubViews()
        
        configureLabels()
        configureSignUpButton()
        configureTextFields()
    }
}

// MARK: Configurations

private extension RegisterViewController {
    func addSubViews() {
        view.addSubview(registrationLabel)
        
        view.addSubview(signUpButton)
    }
    
    func configureLabels() {
        registrationLabel.textColor = .black
        registrationLabel.text = "Registration"
        registrationLabel.textAlignment = .center
        registrationLabel.font = .systemFont(ofSize: 30)
        setLabelConstraints(toItem: registrationLabel, topAnchorConstraint: 10)
    }
    
    func configureTextFields() {
        usernameTextField.autocapitalizationType = .none
        emailTextField.autocapitalizationType = .none
        emailTextField.keyboardType = .emailAddress
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        passwordTextField.rightViewMode = .always
        
        let stackView = UIStackView()
        self.view.addSubview(stackView)
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.spacing = 35.0
        stackView.alignment = UIStackView.Alignment.center
        stackView.axis = .vertical
        usernameTextField.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -70).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -70).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -70).isActive = true
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
    }
    
    
    func configureSignUpButton() {
        signUpButton.setTitle("Sign up", for: .normal)
        signUpButton.titleLabel?.font = .systemFont(ofSize: 20)
        setButtonConstraints(toItem: signUpButton, topAnchorConstraint: 350)
        signUpButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        signUpButton.setTitleColor(UIColor.white, for: .normal)
        signUpButton.layer.cornerRadius = 10
        signUpButton.layer.backgroundColor = UIColor.black.cgColor
        signUpButton.addTarget(self, action:#selector(self.signUpButtonClicked), for: .touchUpInside)
    }
}

// MARK: Constraints

private extension RegisterViewController {
    
    func setLabelConstraints(toItem: UILabel, topAnchorConstraint: CGFloat) {
        toItem.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toItem.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topAnchorConstraint)
        ])
        toItem.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setButtonConstraints(toItem: UIButton, topAnchorConstraint: CGFloat) {
        toItem.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toItem.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topAnchorConstraint),
            toItem.heightAnchor.constraint(equalToConstant: 50)
        ])
        toItem.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

extension RegisterViewController: RegisterViewInput {
    func display(status: AuthCases) {
        switch status {
        case .success:
            let alert = UIAlertController(title: "Success!", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        case .failure:
            let alert = UIAlertController(title: "Warning", message: "Invalid data", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
}
