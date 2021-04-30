//
//  LoginViewController.swift
//  Write
//
//  Created by Muhamed Niyazov on 18.04.2021.
//

import UIKit

protocol LoginDisplayLogic: AnyObject {
    func showErrorLabel(_ viewModel: LoginModels.LoginWithEmail.ViewModel)
    func goToMainScreen()
}

final class LoginViewController: UIViewController, LoginViewDelegate {
    // MARK: - Public Properties
    var interactor: LoginBusinessLogic?
    var router: (LoginRoutingLogic & LoginDataPassing)?
    
    lazy var contentView: LoginViewLogic = LoginView()
    
    
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
    func handleDontHaveAccountButton() {
        router?.navigateToRegistrationScreen()
    }
    
    func handleForgotPasswordButton() {
        router?.navigateToRecoveryPasswordScreen()
    }
    
    func handleLogInButton(_ request: LoginModels.LoginWithEmail.Request) {
        interactor?.logInUser(request)
    }
    
}

// MARK: - Display Logic
extension LoginViewController: LoginDisplayLogic {
    
    func goToMainScreen() {
        router?.navigateToMainScreen()
    }
    
    func showErrorLabel(_ viewModel: LoginModels.LoginWithEmail.ViewModel) {
        contentView.showErrorText(viewModel.loginErrorText)
    }
}
