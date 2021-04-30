//
//  DocumentCreateView.swift
//  Write
//
//  Created by Muhamed Niyazov on 25.04.2021.
//

import SnapKit
import UIKit

protocol DocumentCreateViewLogic: UIView {
    var delegate: DocumentCreateViewDelegate? { get set }
}

protocol DocumentCreateViewDelegate:AnyObject {
    func handleCloseScreenButton()
    func handleCreateDocumentButton(request: DocumentCreateModels.createDocument.Request)
}

final class DocumentCreateView: UIView {
    weak var delegate: DocumentCreateViewDelegate?
    var navigationBar: UINavigationBar!
    var navigationItem: UINavigationItem!
    
    // MARK: - Views
    var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .milk
        return view
    }()
    
    lazy var textView: UITextView =  {
        var textview = TextView()
        textview.delegate = self
        textview.becomeFirstResponder()
        return textview
    }()
    
    // MARK: - Init
    init(frame: CGRect = CGRect.zero, navBar: UINavigationBar, navItem: UINavigationItem) {
        self.navigationBar = navBar
        self.navigationItem = navItem
        super.init(frame: frame)
        configure()
    }
    
    deinit {
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    @objc func handleCreateButton() {
        delegate?.handleCreateDocumentButton(request: .init(text: textView.text!))
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    @objc func handleCloseButton() {
        delegate?.handleCloseScreenButton()
    }
    
    // MARK: -  Methods
    private func configure() {
        addSubviews()
        addConstraints()
        configureNavigationBar(saveButtonEnabled: false)
    }
    
    private func addSubviews() {
        addSubview(containerView)
        addSubview(textView)
    }
    
    private func addConstraints() {
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        textView.snp.makeConstraints { (make) in
            make.edges.equalTo(containerView)
        }
    }
    
    func configureNavigationBar(saveButtonEnabled isEnabled: Bool)  {
        let createButtonTitle = "Create"
        let createButton = UtilitiesUI.instance.barButtonItem(title: createButtonTitle, iconName: nil)
        createButton.target = self
        createButton.isEnabled = isEnabled
        createButton.action =  #selector(handleCreateButton)
        
        let closeIcon = UIImage(systemName: "xmark.circle")
        let grayCloseIcon = closeIcon?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        let barButton =   UIBarButtonItem(image: grayCloseIcon, style: .done, target: self, action: #selector(handleCloseButton))
        
        UtilitiesUI.instance.basicNavBarSettings(.light, navigationBar, navigationItem)
        navigationItem.leftBarButtonItem = barButton
        navigationItem.rightBarButtonItem = createButton
    }
    
}

// MARK: - DocumentCreateViewLogic
extension DocumentCreateView: DocumentCreateViewLogic {
    
}

// MARK: - UITextViewDelegate
extension DocumentCreateView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard textView.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            configureNavigationBar(saveButtonEnabled: true)
            return
        }
        configureNavigationBar(saveButtonEnabled: false)
    }
}
