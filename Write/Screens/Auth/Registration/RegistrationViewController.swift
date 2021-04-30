//
//  RegistrationViewController.swift
//  Write
//
//  Created by Muhamed Niyazov on 18.04.2021.
//

import UIKit

protocol RegistrationDisplayLogic: AnyObject {
    func showErrorText(_ viewModel: RegistrationModels.Register.ViewModel)
    func goToMainScreen()
}

final class RegistrationViewController: UIViewController, RegistrationViewDelegate {
    
    // MARK: - Public Properties
    var interactor: RegistrationBusinessLogic?
    var router: (RegistrationRoutingLogic & RegistrationDataPassing)?
    
    lazy var contentView: RegistrationViewLogic = RegistrationView()
    
    
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
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        contentView.delegate = self
    }
    
    // MARK: - UI Actions
    func handleRegisterAccountButton(_ request: RegistrationModels.Register.Request) {
        interactor?.createUser(request)
    }
    
    func handleGoToLogInButton() {
        router?.navigateToLoginScreen()
    }
    
}

// MARK: - Display Logic
extension RegistrationViewController: RegistrationDisplayLogic {
    func goToMainScreen() {
        router?.navigateToMainScreen()
    }
    
    func showErrorText(_ viewModel: RegistrationModels.Register.ViewModel) {
        contentView.showErrorText(viewModel.loginErrorText)
    }
}
