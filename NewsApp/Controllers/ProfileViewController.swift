//
//  ProfileViewController.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 31/07/22.
//

import UIKit
import Lottie
import SkeletonView
import FirebaseAuth
import FirebaseFirestore

class ProfileViewController: UIViewController {
    var animationView: LottieAnimationView?
    
    let uiView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.frame = CGRect.init(x: 0, y: 0, width: 430, height: 350)
        return view
    }()
    
    
    let info: UILabel = {
        let label = UILabel()
        label.text = "Information"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        return label
    }()
    
    let username: UILabel = {
        let label = UILabel()
        label.text = "loading..."
        label.textColor = .link
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    let email: UILabel = {
        let label = UILabel()
        label.text = "Email:"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    let phone: UILabel = {
        let label = UILabel()
        label.text = "Phone:"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    let emailAddress: UILabel = {
        let label = UILabel()
        label.text = "loading..."
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    let phoneNumber: UILabel = {
        let label = UILabel()
        label.text = "loading..."
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        animation()
        configureConstraints()
    }
    
    func animation() {
        animationView = .init(name: "23290-newspaper")
        animationView?.frame = uiView.bounds
        animationView?.loopMode = .autoReverse
        animationView?.contentMode = .scaleAspectFit
        uiView.addSubview(animationView!)
        animationView?.play()
    }
    
    func configureConstraints() {
        view.addSubview(info)
        view.addSubview(email)
        view.addSubview(phone)
        view.addSubview(uiView)
        view.addSubview(username)
        view.addSubview(phoneNumber)
        view.addSubview(emailAddress)
       
        NSLayoutConstraint.activate([
            username.heightAnchor.constraint(equalToConstant: 50),
            username.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            username.leftAnchor.constraint(equalTo: uiView.leftAnchor, constant: 10),
            username.topAnchor.constraint(equalTo: uiView.bottomAnchor, constant: -60),
            username.rightAnchor.constraint(equalTo: uiView.rightAnchor, constant: -10),
            
            info.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            info.topAnchor.constraint(equalTo: uiView.bottomAnchor, constant: 20),
            
            email.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            email.topAnchor.constraint(equalTo: info.bottomAnchor, constant: 20),
            
            emailAddress.topAnchor.constraint(equalTo: info.bottomAnchor, constant: 20),
            emailAddress.leftAnchor.constraint(equalTo: email.rightAnchor, constant: 20),
            
            phone.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            phone.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 20),
            
            phoneNumber.leftAnchor.constraint(equalTo: email.rightAnchor, constant: 20),
            phoneNumber.topAnchor.constraint(equalTo: emailAddress.bottomAnchor, constant: 20)
        ])
    }
    
    func getData() {
        let docRef = Firestore.firestore().collection("users").whereField("uid", isEqualTo: Auth.auth().currentUser?.uid ?? "")
            docRef.getDocuments { (querySnapshot, error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                else {
                    let document = querySnapshot!.documents.first
                    let dataDescription = document?.data()
                    guard let email = dataDescription?["email"] as? String else { return }
                    guard let phone = dataDescription?["number"] as? String else { return }
                    guard let username = dataDescription?["username"] as? String else { return }
                    self.emailAddress.text = email
                    self.phoneNumber.text = phone
                    self.username.text = "@\(username)"
                }
            }
        }
    
    @IBAction func logOut(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                let loginVC = LoginViewController()
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginVC)
            }
            catch {
                print("Error \(error)")
            }
        }
    }
}

