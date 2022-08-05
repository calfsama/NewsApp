//
//  LoginViewController.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 26/07/22.
//

import UIKit

class LoginViewController: UIViewController {
    

    let nameTitle: UILabel = {
        let title = UILabel()
        title.text = "Sign in"
        title.font = UIFont.systemFont(ofSize: 45, weight: .semibold)

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
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemIndigo
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Don't have an account? Sign up", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.backgroundColor = .systemBackground
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        email.delegate = self
        password.delegate = self
        
        view.addSubview(nameTitle)
        view.addSubview(email)
        view.addSubview(password)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        view.backgroundColor = .systemBackground
        
        registerButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        
        
//        nameTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150).isActive = true
//        nameTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 150).isActive = true
        nameTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 230).isActive = true
        
        
        //email.center
        email.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        email.topAnchor.constraint(equalTo: nameTitle.bottomAnchor, constant: 50).isActive = true
        email.heightAnchor.constraint(equalToConstant: 50).isActive = true
        email.widthAnchor.constraint(equalToConstant: 350).isActive = true
        
        
        password.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        password.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 20).isActive = true
        password.heightAnchor.constraint(equalToConstant: 50).isActive = true
        password.widthAnchor.constraint(equalToConstant: 350).isActive = true
        
        
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 20).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 350).isActive = true
        
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 300).isActive = true
    }
    
    
        @objc private func didTapCreateAccountButton() {
    
            let vc = RegistrationViewController()
            //vc.title = "Create Account"
    
            present(UINavigationController(rootViewController: vc), animated: true)
        }
    
    @objc private func didTapLoginButton() {
        
        password.resignFirstResponder()
        email.resignFirstResponder()
        
        guard let userEmail = email.text, !userEmail.isEmpty,
              let userPassword = password.text, !userPassword.isEmpty, userPassword.count >= 8 else {
            return
        }
        
        //login functionally
        var emailAddress: String?
        var username: String?
        
        if userEmail.contains("@"), userEmail.contains("."){
            //email
            emailAddress = userEmail
        }
        else {
            // username
            username = userEmail
        }
    }
    
    

}
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == email {
            password.becomeFirstResponder()
        }
        else if textField == password {
            didTapLoginButton()
        }
        return true
    }
}

