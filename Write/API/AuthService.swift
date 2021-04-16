//
//  AuthService.swift
//  Write
//
//  Created by Muhamed Niyazov on 21.03.2021.

import Foundation
import Firebase


struct AuthCredentials {
    let name: String
    let email: String
    let password: String
}


class AuthService {
    static let instance = AuthService()
    private init() {}
    
    func createUser(credentials: AuthCredentials, completion: @escaping(String?) -> Void){
        let name = credentials.name
        let email = credentials.email
        let password = credentials.password
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil  {
                completion(error!.localizedDescription)
                return
            }
            // Success create user
            let dataBase = Firestore.firestore()
            dataBase.collection("users").addDocument(data: ["name" : name, "uid" : authResult!.user.uid]) { error in
                if error != nil  {
                    completion("Error saving user data")
                    return
                }
                // Success create and saving user data
                completion(nil)
            }
        }
    }
    
    func logInUser(email: String, password: String, complition: @escaping(_ error: String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            guard error == nil  else { return complition(error!.localizedDescription)  }
            complition(nil)
        }
    }
    
    func logUserOut(complition: @escaping(_ error: String?) -> Void) {
        do {
            try Auth.auth().signOut()
            complition(nil)
        } catch let error {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    
    func resetPassword(withEmail email: String, complition: @escaping(_ error: String?) -> Void) {
      
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
              print("DEBUG: \(error) ")
            guard error == nil  else { return complition(error!.localizedDescription)  }
            complition(nil)
        }
    }
    
}
