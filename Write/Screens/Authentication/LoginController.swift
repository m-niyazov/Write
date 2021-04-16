//
//  LoginController.swift
//  Write
//
//  Created by Muhamed Niyazov on 20.03.2021.
//

import UIKit
import SnapKit

class LoginController: UIViewController {
    //MARK: - Properties
    lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "main-logo")
        return imageView
    }()
    
    lazy var emailTextFieldContainer: UIView = {
        let textFieldContainer = UtilitiesUI.instance.textFieldContainer(emailTextField)
        return textFieldContainer
    }()
    
    lazy var passwordTextFieldContainer: UIView = {
        let textFieldContainer = UtilitiesUI.instance.textFieldContainer(passwordTextField)
        return textFieldContainer
    }()
    
    lazy var emailTextField: UITextField  = {
        let textField = UtilitiesUI.instance.textFieldWithPlaceholder(withPlaceholder: "Email")
        textField.delegate = self
        return textField
    }()
    
    lazy var loginButtonContainer: UIStackView = {
        let subviews = [errorLabel, loginButton]
        let view = UIStackView(arrangedSubviews: subviews)
        let button = loginButton
        view.axis = .vertical
        view.spacing = 15
        return view
    }()
    
    lazy var passwordTextField: UITextField  = {
        let textField = UtilitiesUI.instance.textFieldWithPlaceholder(withPlaceholder: "Password")
        textField.tag = 1
        textField.delegate = self
        textField.isSecureTextEntry = !textField.isSecureTextEntry
        return textField
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .lightGray
        label.isHidden = true
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setAttributedTitle(NSAttributedString(string: "Log In", attributes:  [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)]), for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.snp.makeConstraints { make in make.height.equalTo(50)}
        button.addTarget(self, action: #selector(handleLogInButton), for: .touchUpInside)
        return button
    }()
    
    
    lazy var textFiedlsStack: UIStackView = {
        let subviews = [emailTextFieldContainer, passwordTextFieldContainer]
        let stackView = UIStackView(arrangedSubviews: subviews)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    lazy var dontHaveAccountButton: UIButton = {
        let button = UtilitiesUI.instance.attributedButton("Don't have an account?", " Sign Up")
        button.addTarget(self, action: #selector(handleDontHaveAccountButton), for: .touchUpInside)
        return button
    }()
    
    lazy var forgotPasswordButton: UIButton = {
        let button = UtilitiesUI.instance.attributedButton("Forgot", " password?")
        button.addTarget(self, action: #selector(handleForgotPasswordButton), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureUI()
    }
    
    //MARK: - Selectors
    @objc func handleDontHaveAccountButton () {
        navigationController?.pushViewController(RegistrationController(), animated: true)
    }
    
    @objc func handleForgotPasswordButton () {
        let recoveryPasswordScreen = RecoveryPasswordController()
        let navController = UINavigationController(rootViewController: recoveryPasswordScreen)
        navController.modalPresentationStyle = .formSheet
        present(navController, animated: true, completion: nil)
    }
    
    @objc func handleLogInButton() {
        // Validate fields
        let error = validateFields()
        guard  error == nil else { return changeErrorLabel(isHidden: false, error) }
        loginButton.backgroundColor = .lightGray
        //LogIn user
        AuthService.instance.logInUser(email: emailTextField.text!, password: passwordTextField.text!) { (error) in
            self.loginButton.backgroundColor = .white
            guard error == nil else { return self.changeErrorLabel(isHidden: false, error) }
            //Success login user
            self.navigationController?.pushViewController(MainTabController(), animated: true)
            
        }
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(logoImage)
        logoImage.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(80)
        }
        
        view.addSubview(textFiedlsStack)
        textFiedlsStack.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(50)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
        
        view.addSubview(loginButtonContainer)
        loginButtonContainer.snp.makeConstraints { make in
            make.top.equalTo(textFiedlsStack.snp.bottom).offset(40)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        view.addSubview(forgotPasswordButton)
        forgotPasswordButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(dontHaveAccountButton).inset(30)
        }
    }
    
    func changeErrorLabel(isHidden: Bool, _ error: String?) {
        errorLabel.isHidden = isHidden
        errorLabel.text = error ?? ""
    }
    
    func validateFields() -> String? {
        //Check that all fields are filled in
        if  emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        
        //Check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.instance.isPasswordValid(cleanedPassword) == false {
            return "Please make sure your password contains one big letter, one number and is minimum of 8 char long"
        }
        
        //Remove whitespaces in email text field
        emailTextField.text! = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        return nil
    }
    
}


//MARK: - TextFieldDelegate
extension LoginController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        changeErrorLabel(isHidden: true, nil)
    }
    
    //Remove whitespace in password field
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == textField.superview?.viewWithTag(1) {
            textField.text = textField.text?.replacingOccurrences(of: " ", with: "")
        }
        return true
    }
}
