//
//  RecoveryPasswordViewController.swift
//  Write
//
//  Created by Muhamed Niyazov on 19.04.2021.
//

import UIKit

protocol RecoveryPasswordDisplayLogic: AnyObject {
    func showErrorAlert(_ viewModel: RecoveryPasswordModels.SendEmail.ViewModel)
    func showSuccessAlert()
}

final class RecoveryPasswordViewController: UIViewController, RecoveryPasswordViewDelegate {
    // MARK: - Public Properties
    var interactor: RecoveryPasswordBusinessLogic?
    var router: (RecoveryPasswordRoutingLogic & RecoveryPasswordDataPassing)?
    
    lazy var contentView: RecoveryPasswordViewLogic = RecoveryPasswordView()
    
    
    // MARK: - Lifecycle
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Private Methods
    private func configure() {
        configureNavigationBar()
        contentView.delegate = self
    }
    
    // MARK: - UI Actions
    @objc func handleNavigationBackButton() {
        router?.navigateToMainScreen()
    }
    
    func handleSendEmailButton(_ request: RecoveryPasswordModels.SendEmail.Request) {
        interactor?.sendPasswordReset(request)
    }
}

// MARK: - Display Logic
extension RecoveryPasswordViewController: RecoveryPasswordDisplayLogic {
    
    func showErrorAlert(_ viewModel: RecoveryPasswordModels.SendEmail.ViewModel) {
        alertController(isErrorMesage: true, title: "Error", message: viewModel.error)
    }
    
    func showSuccessAlert() {
        alertController(isErrorMesage: false, title: "Success", message: "We sent an email to your email address to recover your password")
    }
}

//MARK: - UI Settings
extension RecoveryPasswordViewController {
    func configureNavigationBar() {
        let navigationBar = navigationController!.navigationBar
        navigationBar.barStyle = .black
        navigationBar.barTintColor = .black
        navigationItem.title = "Recovery password"
        
        navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 19)]
        
        let backItem = UIBarButtonItem()
        backItem.title = "Cancel"
        backItem.target = self
        backItem.action = #selector(handleNavigationBackButton)
        navigationItem.leftBarButtonItem = backItem
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    func alertController(isErrorMesage: Bool, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.overrideUserInterfaceStyle = .dark
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {_ in
            guard !isErrorMesage else { return }
            self.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
}
