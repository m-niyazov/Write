//
//  SettingsViewController.swift
//  Write
//
//  Created by Muhamed Niyazov on 30.04.2021.
//

import UIKit

protocol SettingsDisplayLogic: AnyObject {
    func goToLoginScreen()
}

final class SettingsViewController: UIViewController, SettingsViewDelegate {
    // MARK: - Properties
    var interactor: SettingsBusinessLogic?
    var router: (SettingsRoutingLogic & SettingsDataPassing)?
    
    lazy var contentView: SettingsViewLogic = SettingsView()
    
    // MARK: - Lifecycle
    override func loadView() {
        contentView.delegate = self
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    // MARK: -  Methods
    
    private func configure() {
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        let navigationTitle = UILabel()
        navigationTitle.font = UIFont.boldSystemFont(ofSize: 20)
        navigationTitle.text = "Settings"
        navigationTitle.textColor = .white
        navigationItem.titleView = navigationTitle
        navigationController?.navigationBar.barStyle = .black
    }
    
    func alertController(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.overrideUserInterfaceStyle = .dark
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: {_ in
            self.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - UI Actions
    func aboutCellTapped() {
        alertController(title: "Write 1.0", message: "")
    }
    
    func logOutCellTapped() {
        interactor?.logOutUser()
    }
}

// MARK: - Display Logic
extension SettingsViewController: SettingsDisplayLogic {
    func goToLoginScreen() {
        router?.navigateToLoginScreen()
    }
    
}
