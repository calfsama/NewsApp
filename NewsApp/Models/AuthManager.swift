//
//  AuthManager.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 22/08/22.
//

import Foundation
import FirebaseAuth

class AuthManager {
    func createUser(email: String, password: String, completion: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(result, error) in
            if let user = result?.user {
                print(user)
                completion(true)
            }
            else {
                completion(false)
            }
        }
    }
}
