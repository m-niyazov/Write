//
//  RegistrationController.swift
//  Write
//
//  Created by Muhamed Niyazov on 20.03.2021.
import UIKit
import SnapKit

class RegistrationController: UIViewController {
    //MARK: - Properties
    lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "main-logo")
        return imageView
    }()
    
    lazy var nameTextFieldContainer: UIView = {
        let textFieldContainer = UtilitiesUI.instance.textFieldContainer(nameTextField)
        return textFieldContainer
    }()
    
    lazy var emailTextFieldContainer: UIView = {
        let textFieldContainer = UtilitiesUI.instance.textFieldContainer(emailTextField)
        
        return textFieldContainer
    }()
    
    lazy var passwordTextFieldContainer: UIView = {
        let textFieldContainer = UtilitiesUI.instance.textFieldContainer(passwordTextField)
        return textFieldContainer
    }()
    
    lazy var registerButtonContainer: UIStackView = {
        let subviews = [errorLabel, registerButton]
        let view = UIStackView(arrangedSubviews: subviews)
        let button = registerButton
        view.axis = .vertical
        view.spacing = 15
        return view
    }()
    
    lazy var nameTextField: UITextField  = {
        let textField = UtilitiesUI.instance.textFieldWithPlaceholder(withPlaceholder: "Name")
        textField.delegate = self
        return textField
    }()
    
    lazy var emailTextField: UITextField  = {
        let textField = UtilitiesUI.instance.textFieldWithPlaceholder(withPlaceholder: "Email")
        textField.delegate = self
        return textField
    }()
    
    lazy var passwordTextField: UITextField  = {
        let textField = UtilitiesUI.instance.textFieldWithPlaceholder(withPlaceholder: "Password")
        textField.isSecureTextEntry = true
        textField.tag = 2
        textField.delegate = self
        return textField
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setAttributedTitle(NSAttributedString(string: "Sign Up", attributes:  [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)]), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.snp.makeConstraints {make in make.height.equalTo(50)}
        button.addTarget(self, action: #selector(handleRegisterButton), for: .touchUpInside)
        return button
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .systemRed
        label.isHidden = true
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var textFiedlsStack: UIStackView = {
        let subviews = [nameTextFieldContainer, emailTextFieldContainer, passwordTextFieldContainer]
        let stackView = UIStackView(arrangedSubviews: subviews)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    lazy var alreadyHaveAccountButton: UIButton = {
        let button = UtilitiesUI.instance.attributedButton("Already have an account?", " Log In")
        button.addTarget(self, action: #selector(handleAlreadyHaveAccountButton), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureUI()
    }
    
    
    //MARK: - Selectors
    @objc func handleAlreadyHaveAccountButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleRegisterButton() {
        //Validate the fields
        let error = validateFields()
        guard error == nil else { return changeErrorLabel(isHidden: false, error) }
        
        let user = AuthCredentials(name: nameTextField.text!,
                                   email: emailTextField.text!,
                                   password: passwordTextField.text!)
        //RegisterUser
        registerButton.backgroundColor = .lightGray
        AuthService.instance.createUser(credentials: user) { error in
            self.registerButton.backgroundColor = .white
            guard error == nil else { return self.changeErrorLabel(isHidden: false, error) }
            //Success register user
            print("DEBUG: \(user.name) create! ")
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
        
        view.addSubview(registerButtonContainer)
        registerButtonContainer.snp.makeConstraints { make in
            make.top.equalTo(textFiedlsStack.snp.bottom).offset(40)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func changeErrorLabel(isHidden: Bool, _ error: String?) {
        errorLabel.isHidden = isHidden
        errorLabel.text = error ?? ""
    }
    
    func validateFields() -> String? {
        //Check that all fields are filled in
        if  nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""  ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            print("DEBUG: \(nameTextField.text!) ")
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
extension RegistrationController: UITextFieldDelegate {
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
        
        if textField == textField.superview?.viewWithTag(2) {
            textField.text = textField.text?.replacingOccurrences(of: " ", with: "")
        }
        return true
    }
}
