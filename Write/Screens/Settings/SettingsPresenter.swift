//
//  SettingsPresenter.swift
//  Write
//
//  Created by Muhamed Niyazov on 30.04.2021.
//

import UIKit

protocol SettingsPresentationLogic {
    func logOutUserSucces()
}

final class SettingsPresenter: SettingsPresentationLogic {
    
    // MARK: -  Properties
    weak var viewController: SettingsDisplayLogic?
    
    // MARK: - Presentation Logic
    func logOutUserSucces() {
        viewController?.goToLoginScreen()
    }
}
