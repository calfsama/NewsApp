//
//  RegistrationViewController.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 26/07/22.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    
    let nameTitle: UILabel = {
        let title = UILabel()
        title.text = "Create Account"
        title.font = UIFont.systemFont(ofSize: 39, weight: .semibold)

        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    let email: UITextField = {
        let email = UITextField()
        email.placeholder = "Enter your email address"
        email.returnKeyType = .next
        email.leftViewMode = .always
        email.autocapitalizationType = .none
        email.autocorrectionType = .no
        email.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        email.layer.cornerRadius = 20
        email.layer.masksToBounds = true
        email.layer.borderWidth = 1
        email.layer.borderColor = UIColor.secondaryLabel.cgColor
        email.translatesAutoresizingMaskIntoConstraints = false
        return email
    }()
    
    let usernameField: UITextField = {
        let username = UITextField()
        username.placeholder = "Enter your username"
        username.returnKeyType = .next
        username.leftViewMode = .always
        username.autocapitalizationType = .none
        username.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        username.layer.cornerRadius = 20
        username.layer.masksToBounds = true
        username.layer.borderWidth = 1
        username.layer.borderColor = UIColor.secondaryLabel.cgColor
        username.translatesAutoresizingMaskIntoConstraints = false
        return username
    }()
    
    let password: UITextField = {
        let password = UITextField()
        password.placeholder = "Enter your password"
        password.returnKeyType = .next
        password.leftViewMode = .always
        password.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        password.autocapitalizationType = .none
        password.autocorrectionType = .no
        password.layer.cornerRadius = 20
        password.layer.masksToBounds = true
        password.layer.borderWidth = 1
        password.layer.borderColor = UIColor.secondaryLabel.cgColor
        password.translatesAutoresizingMaskIntoConstraints = false
        return password
    }()
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameField.delegate = self
        email.delegate = self
        password.delegate = self
        
        view.addSubview(usernameField)
        view.addSubview(email)
        view.addSubview(password)
        view.addSubview(registerButton)
        view.addSubview(nameTitle)
        
        view.backgroundColor = .systemBackground
        
        
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        
        nameTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        
        email.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        email.topAnchor.constraint(equalTo: nameTitle.bottomAnchor, constant: 70).isActive = true
        email.heightAnchor.constraint(equalToConstant: 50).isActive = true
        email.widthAnchor.constraint(equalToConstant: 350).isActive = true
        
        usernameField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        usernameField.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 20).isActive = true
        usernameField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        usernameField.widthAnchor.constraint(equalToConstant: 350).isActive = true

        
        password.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        password.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 20).isActive = true
        password.heightAnchor.constraint(equalToConstant: 50).isActive = true
        password.widthAnchor.constraint(equalToConstant: 350).isActive = true
        
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 20).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        registerButton.widthAnchor.constraint(equalToConstant: 350).isActive = true
        
    }
    
    @objc private func didTapRegister() {
        
        email.becomeFirstResponder()
        usernameField.becomeFirstResponder()
        password.becomeFirstResponder()
        
        guard let userEmail = email.text, !userEmail.isEmpty,
              let username = usernameField.text, !username.isEmpty,
              let userPassword = password.text, !userPassword.isEmpty, userPassword.count <= 8 else {
            return
        }
    }
}
extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == email {
            usernameField.becomeFirstResponder()
        }
        else if textField == usernameField {
            password.becomeFirstResponder()
        }
        else{
            didTapRegister()
        }
        return true
    }
}

