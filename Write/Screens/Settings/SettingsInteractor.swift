//
//  SettingsInteractor.swift
//  Write
//
//  Created by Muhamed Niyazov on 30.04.2021.
//

import Foundation
import Firebase

protocol SettingsBusinessLogic {
    func logOutUser() 
}

protocol SettingsDataStore {
    
}

final class SettingsInteractor: SettingsBusinessLogic, SettingsDataStore {
    // MARK: - Public Properties
    var presenter: SettingsPresentationLogic?
    
    // MARK: - Business Logic
    func logOutUser() {
        do {
            try Auth.auth().signOut()
            presenter?.logOutUserSucces()
        } catch let error {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
}
