//
//  RecoveryPasswordController.swift
//  Write
//
//  Created by Muhamed Niyazov on 16.04.2021.
//

import Foundation
import UIKit
import SnapKit
class RecoveryPasswordController: UIViewController {
    // MARK: - Properties
    lazy var emailTextField: UITextField  = {
        let textField = UtilitiesUI.instance.textFieldWithPlaceholder(withPlaceholder: "Email")
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)),
                            for: .editingChanged)
        textField.delegate = self
        textField.returnKeyType = UIReturnKeyType.done
        textField.keyboardAppearance = .dark
        textField.backgroundColor = #colorLiteral(red: 0.07841964811, green: 0.07843685895, blue: 0.07841657847, alpha: 1)
        textField.layer.cornerRadius = 10
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.rightViewMode = .always
        return textField
    }()
    
    lazy var mainTitle: UILabel = {
        let label = UILabel()
        label.text = "Enter your email address"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var secondaryText: UILabel = {
        let label = UILabel()
        label.text = "Please enter the email address you used to login"
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var sendEmailButton: UIButton = {
        var button = UIButton(type: .system)
        button.setAttributedTitle(NSAttributedString(string: "Send", attributes:  [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)]), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleSendEmailButton), for: .touchUpInside)
        button.isEnabled = false
        button.backgroundColor = .darkGray
        return button
    }()
        
    // MARK: - Selectors
    @objc func navigationBackButtonAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleSendEmailButton() {
        AuthService.instance.resetPassword(withEmail: emailTextField.text!) { [self] (error) in
            guard error == nil else { return self.alertController(errorMesage: true, title: "Error", message: error!) }
            self.alertController(errorMesage: false, title: "Success", message: "We sent an email to your email address to recover your password")
            
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationBar()
    }
    
    // MARK: - Helpers
    func configureUI(){
        view.backgroundColor = .black
        //mainTitle
        view.addSubview(mainTitle)
        mainTitle.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
        }
        //secondaryText
        view.addSubview(secondaryText)
        secondaryText.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(mainTitle.snp.bottom).offset(15)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).inset(15)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).inset(15)
        }
        //emailTextField
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(secondaryText.snp.bottom).offset(15)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).inset(15)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).inset(15)
            make.height.equalTo(44)
        }
        
        //sendEmailButton
        view.addSubview(sendEmailButton)
        sendEmailButton.snp.makeConstraints { (make) in
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).inset(15)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).inset(15)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10)
            make.height.equalTo(44)
        }
        
        
    }
    
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
        backItem.action = #selector(navigationBackButtonAction)
        navigationItem.leftBarButtonItem = backItem
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    func isEnabledButton(isEnabled: Bool) {
        
        guard !isEnabled else {
            sendEmailButton.isEnabled = true
            sendEmailButton.backgroundColor = .white
            return
        }
        sendEmailButton.backgroundColor = .darkGray
        sendEmailButton.isEnabled = false
    }
    
    
    func alertController(errorMesage: Bool, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.overrideUserInterfaceStyle = .dark
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {_ in
            guard !errorMesage else { return }
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - TextFieldDelegate
extension RecoveryPasswordController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let text = textField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        guard text != "" else {
            self.view.endEditing(true)
            return true
        }
        handleSendEmailButton()
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let text = textField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if(text == "") {
            isEnabledButton(isEnabled: false)
        } else {
            isEnabledButton(isEnabled: true)
        }
    }
}
