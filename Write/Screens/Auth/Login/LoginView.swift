//
//  LoginView.swift
//  Write
//
//  Created by Muhamed Niyazov on 18.04.2021.
//

import SnapKit
import UIKit
//MARK: - Protocols
protocol LoginViewLogic: UIView {
    var delegate: LoginViewDelegate? { get set }
    func showErrorText(_ error: String)
}

protocol LoginViewDelegate: AnyObject {
    func handleDontHaveAccountButton()
    func handleForgotPasswordButton()
    func handleLogInButton(_ request: LoginModels.LoginWithEmail.Request)
}

final class LoginView: UIView {
    //MARK: - Properties
    weak var delegate: LoginViewDelegate?
    var authUtilitiesUI = AuthUtilitiesUI()
    
    // MARK: - Views
    var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    lazy var logoImage: UIImageView = {
        let imageView = authUtilitiesUI.logoImageView()
        return imageView
    }()
    
    lazy var emailTextFieldContainer: UIView = {
        let textFieldContainer = authUtilitiesUI.generateTextFieldContainer(emailTextField)
        return textFieldContainer
    }()
    
    lazy var passwordTextFieldContainer: UIView = {
        let textFieldContainer = authUtilitiesUI.generateTextFieldContainer(passwordTextField)
        return textFieldContainer
    }()
    
    lazy var emailTextField: UITextField  = {
        let textField = authUtilitiesUI.textFieldWithPlaceholder(withPlaceholder: "Email")
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)),
                            for: .editingChanged)
        textField.delegate = self
        return textField
    }()
    
    lazy var passwordTextField: UITextField  = {
        let textField = authUtilitiesUI.textFieldWithPlaceholder(withPlaceholder: "Password")
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)),
                            for: .editingChanged)
        textField.delegate = self
        textField.isSecureTextEntry = !textField.isSecureTextEntry
        return textField
    }()
    
    lazy var textFiedlsStack: UIStackView = {
        let subviews = [emailTextFieldContainer, passwordTextFieldContainer]
        let stackView = authUtilitiesUI.stackViewForTextFields(subviews)
        return stackView
    }()
    
    lazy var errorLabel: UILabel = {
        let label = authUtilitiesUI.errorLabel()
        return label
    }()
    
    lazy var loginButtonContainer: UIStackView = {
        let subviews = [errorLabel, loginButton]
        let view = authUtilitiesUI.mainActionButtonContainer(subviews)
        return view
    }()
    
    lazy var loginButton: UIButton = {
        let button = authUtilitiesUI.mainActionButton(withTitle: "Log In")
        button.addTarget(self, action: #selector(handleLogInButton), for: .touchUpInside)
        return button
    }()
    
    lazy var forgotPasswordButton: UIButton = {
        let button = authUtilitiesUI.buttonWithTextAttributed("Forgot", " password?")
        button.addTarget(self, action: #selector(handleForgotPasswordButton), for: .touchUpInside)
        return button
    }()
    
    lazy var dontHaveAccountButton: UIButton = {
        let button = authUtilitiesUI.buttonWithTextAttributed("Don't have an account?", " Sign Up")
        button.addTarget(self, action: #selector(handleDontHaveAccountButton), for: .touchUpInside)
        return button
    }()

    // MARK: - Init
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private Methods
    private func configure() {
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(logoImage)
        containerView.addSubview(textFiedlsStack)
        containerView.addSubview(loginButtonContainer)
        containerView.addSubview(forgotPasswordButton)
        containerView.addSubview(dontHaveAccountButton)
    }
    
    private func addConstraints() {
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        logoImage.snp.makeConstraints { make in
            make.centerX.equalTo(containerView)
            make.top.equalTo(containerView.safeAreaLayoutGuide.snp.top).offset(80)
        }
        
        textFiedlsStack.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(50)
            make.left.equalTo(containerView).offset(20)
            make.right.equalTo(containerView).offset(-20)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
        
        loginButtonContainer.snp.makeConstraints { make in
            make.top.equalTo(textFiedlsStack.snp.bottom).offset(40)
            make.left.equalTo(containerView).offset(20)
            make.right.equalTo(containerView).offset(-20)
        }
        
        dontHaveAccountButton.snp.makeConstraints { make in
            make.centerX.equalTo(containerView)
            make.bottom.equalTo(containerView.safeAreaLayoutGuide.snp.bottom)
        }
        
        forgotPasswordButton.snp.makeConstraints { make in
            make.centerX.equalTo(containerView)
            make.bottom.equalTo(dontHaveAccountButton).inset(30)
        }
    }
    
    //MARK: - Selectors
    @objc func handleDontHaveAccountButton () {
        delegate?.handleDontHaveAccountButton()
    }
    
    @objc func handleForgotPasswordButton () {
        delegate?.handleForgotPasswordButton()
    }
    
    @objc func handleLogInButton() {
        let email  = emailTextField.text!
        let password = passwordTextField.text!
        delegate?.handleLogInButton(.init(email: email, password: password))
    }
    
}

// MARK: - LoginViewLogic
extension LoginView: LoginViewLogic {
    func showErrorText(_ error: String) {
        authUtilitiesUI.isErrorLabelHidden(errorLabel, isHidden: false)
        errorLabel.text = error
    }
}

//MARK: - TextFieldDelegate
extension LoginView: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        authUtilitiesUI.isErrorLabelHidden(errorLabel, isHidden: true)
        if emailTextField.text! == "" || passwordTextField.text! == "" {
            authUtilitiesUI.isEnabledButton(loginButton, isEnabled: false)
            return
        }
        authUtilitiesUI.isEnabledButton(loginButton, isEnabled: true)
    }
}


