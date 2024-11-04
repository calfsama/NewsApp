//
//  LoginViewController.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 26/07/22.
//

import UIKit
import FirebaseAuth

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
        configureConstraints()
        view.backgroundColor = .systemBackground
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
    }
    
    func configureConstraints() {
        view.addSubview(email)
        view.addSubview(password)
        view.addSubview(nameTitle)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        NSLayoutConstraint.activate([
        
            nameTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 230),
            
            email.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            email.topAnchor.constraint(equalTo: nameTitle.bottomAnchor, constant: 50),
            email.heightAnchor.constraint(equalToConstant: 50),
            email.widthAnchor.constraint(equalToConstant: 350),
            
            password.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            password.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 20),
            password.heightAnchor.constraint(equalToConstant: 50),
            password.widthAnchor.constraint(equalToConstant: 350),
            
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 20),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.widthAnchor.constraint(equalToConstant: 350),
            
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 300)
        ])
    }
    
    @objc private func didTapCreateAccountButton() {
        let vc = RegistrationViewController()
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    @objc private func didTapLoginButton() {
        
        if let email = email.text, let password = password.text {
            Auth.auth().signIn(withEmail: email, password: password) { (success, error) in
                if let error = error {
                    print("Error \(error)")
                }
                else if let success = success{
                    print("Successfully")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let tabBar = storyboard.instantiateViewController(withIdentifier: "TabBarController")
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(tabBar)
                }
            }
        }
    }
}

