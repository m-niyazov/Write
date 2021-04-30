//
//  RegistrationView.swift
//  Write
//
//  Created by Muhamed Niyazov on 18.04.2021.
//

import SnapKit
import UIKit

protocol RegistrationViewLogic: UIView {
    func showErrorText(_ error: String)
    var delegate: RegistrationViewDelegate? { get set }
}

protocol RegistrationViewDelegate: AnyObject {
    func handleRegisterAccountButton(_ request: RegistrationModels.Register.Request)
    func handleGoToLogInButton()
}

final class RegistrationView: UIView {
    // MARK: - Properites
    weak var delegate: RegistrationViewDelegate?
    let authUtilitiesUI = AuthUtilitiesUI()
    
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
    
    lazy var nameTextFieldContainer: UIView = {
        let textFieldContainer = authUtilitiesUI.generateTextFieldContainer(nameTextField)
        return textFieldContainer
    }()
    
    lazy var emailTextFieldContainer: UIView = {
        let textFieldContainer = authUtilitiesUI.generateTextFieldContainer(emailTextField)
        return textFieldContainer
    }()
    
    lazy var passwordTextFieldContainer: UIView = {
        let textFieldContainer = authUtilitiesUI.generateTextFieldContainer(passwordTextField)
        return textFieldContainer
    }()
    
    lazy var registerButtonContainer: UIStackView = {
        let subviews = [errorLabel, registerButton]
        let view = authUtilitiesUI.mainActionButtonContainer(subviews)
        return view
    }()
    
    lazy var nameTextField: UITextField  = {
        let textField = authUtilitiesUI.textFieldWithPlaceholder(withPlaceholder: "Name")
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)),
                            for: .editingChanged)
        textField.delegate = self
        return textField
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
        textField.isSecureTextEntry = true
        textField.tag = 2
        textField.delegate = self
        return textField
    }()
    
    lazy var registerButton: UIButton = {
        let button = authUtilitiesUI.mainActionButton(withTitle: "Sign Up")
        button.addTarget(self, action: #selector(handleRegisterButton), for: .touchUpInside)
        return button
    }()
    
    lazy var errorLabel: UILabel = {
        let label = authUtilitiesUI.errorLabel()
        return label
    }()
    
    lazy var textFiedlsStack: UIStackView = {
        let subviews = [nameTextFieldContainer, emailTextFieldContainer, passwordTextFieldContainer]
        let stackView = authUtilitiesUI.stackViewForTextFields(subviews)
        return stackView
    }()
    
    lazy var alreadyHaveAccountButton: UIButton = {
        let button = authUtilitiesUI.buttonWithTextAttributed("Already have an account?", " Log In")
        button.addTarget(self, action: #selector(handleAlreadyHaveAccountButton), for: .touchUpInside)
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
    
    // MARK: - Selectors
    @objc func handleAlreadyHaveAccountButton() {
        delegate?.handleGoToLogInButton()
    }
    
    @objc func handleRegisterButton() {
        let name = nameTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        delegate?.handleRegisterAccountButton(.init(name: name, email: email, password: password))
    }
    
    // MARK: -  Methods
    private func configure() {
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(logoImage)
        containerView.addSubview(textFiedlsStack)
        containerView.addSubview(registerButtonContainer)
        containerView.addSubview(alreadyHaveAccountButton)
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
        
        registerButton.snp.makeConstraints {
            make in make.height.equalTo(50)
            
        }
        
        registerButtonContainer.snp.makeConstraints { make in
            make.top.equalTo(textFiedlsStack.snp.bottom).offset(40)
            make.left.equalTo(containerView).offset(20)
            make.right.equalTo(containerView).offset(-20)
        }
        
        alreadyHaveAccountButton.snp.makeConstraints { make in
            make.centerX.equalTo(containerView)
            make.bottom.equalTo(containerView.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

// MARK: - RegistrationViewLogic
extension RegistrationView: RegistrationViewLogic {
    func showErrorText(_ error: String) {
        authUtilitiesUI.isErrorLabelHidden(errorLabel, isHidden: false)
        errorLabel.text = error
    }
}


// MARK: - UITextFieldDelegate
extension RegistrationView: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        authUtilitiesUI.isErrorLabelHidden(errorLabel, isHidden: true)
        if textField == textField.superview?.viewWithTag(2) {
            textField.text = textField.text?.replacingOccurrences(of: " ", with: "")
        }
        if  nameTextField.text! == "" || emailTextField.text! == "" || passwordTextField.text! == "" {
            authUtilitiesUI.isEnabledButton(registerButton, isEnabled: false)
            return
        }
       
        authUtilitiesUI.isEnabledButton(registerButton, isEnabled: true)
    }
}
