//
//  RecoveryPasswordView.swift
//  Write
//
//  Created by Muhamed Niyazov on 19.04.2021.
//

import SnapKit
import UIKit

protocol RecoveryPasswordViewLogic: UIView {
    var delegate: RecoveryPasswordViewDelegate? { set get }
}

protocol RecoveryPasswordViewDelegate: AnyObject {
    func handleSendEmailButton(_ request: RecoveryPasswordModels.SendEmail.Request)
}

final class RecoveryPasswordView: UIView, RecoveryPasswordViewLogic {
    var authUtilitiesUI = AuthUtilitiesUI()
    weak var delegate: RecoveryPasswordViewDelegate?
    // MARK: - Views
    var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = authUtilitiesUI.textFieldWithPlaceholder(withPlaceholder: "Email")
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
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
        var button = authUtilitiesUI.mainActionButton(withTitle: "Send")
        button.addTarget(self, action: #selector(handleSendEmailButton), for: .touchUpInside)
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
    @objc func handleSendEmailButton() {
        delegate?.handleSendEmailButton(.init(email: emailTextField.text!))
    }
    
    // MARK: -  Methods
    private func configure() {
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(mainTitle)
        containerView.addSubview(secondaryText)
        containerView.addSubview(emailTextField)
        containerView.addSubview(sendEmailButton)
    }
    
    private func addConstraints() {
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        mainTitle.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(containerView.safeAreaLayoutGuide.snp.top).offset(30)
        }
        
        secondaryText.snp.makeConstraints { (make) in
            make.centerX.equalTo(containerView)
            make.top.equalTo(mainTitle.snp.bottom).offset(15)
            make.right.equalTo(containerView.safeAreaLayoutGuide.snp.right).inset(15)
            make.left.equalTo(containerView.safeAreaLayoutGuide.snp.left).inset(15)
        }
        
        emailTextField.snp.makeConstraints { (make) in
            make.centerX.equalTo(containerView)
            make.top.equalTo(secondaryText.snp.bottom).offset(15)
            make.right.equalTo(containerView.safeAreaLayoutGuide.snp.right).inset(15)
            make.left.equalTo(containerView.safeAreaLayoutGuide.snp.left).inset(15)
            make.height.equalTo(44)
        }
        
        sendEmailButton.snp.makeConstraints { (make) in
            make.right.equalTo(containerView.safeAreaLayoutGuide.snp.right).inset(15)
            make.left.equalTo(containerView.safeAreaLayoutGuide.snp.left).inset(15)
            make.bottom.equalTo(containerView.safeAreaLayoutGuide.snp.bottom).inset(10)
            make.height.equalTo(44)
        }
    }
}

// MARK: - UITextFieldDelegate
extension RecoveryPasswordView: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let text = textField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if text == "" {
            endEditing(true)
            return true
        }
        handleSendEmailButton()
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if emailTextField.text! == "" {
            authUtilitiesUI.isEnabledButton(sendEmailButton, isEnabled: false)
            return
        }
        
        authUtilitiesUI.isEnabledButton(sendEmailButton, isEnabled: true)
    }
    
}
