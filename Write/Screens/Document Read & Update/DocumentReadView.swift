//
//  DocumentReadView.swift
//  Write
//
//  Created by Muhamed Niyazov on 27.04.2021.
//

import SnapKit
import UIKit

protocol DocumentReadViewLogic: UIView {
    var delegate: DocumentReadViewDelegate? { get set }
    func endEditingDocument()
    func setViewModel(viewModel: DocumentReadModels.getDocument.ViewModel)
}

protocol DocumentReadViewDelegate: AnyObject {
    func handleSaveDocument(requset: DocumentReadModels.updateDocument.Request)
    func handleDeleteDocument()
}

final class DocumentReadView: UIView {
    //MARK: - Properties
    var viewModel: DocumentReadModels.getDocument.ViewModel? {
        didSet {
            textView.attributedText = viewModel?.сompleteText
        }
    }
    var navigationBar: UINavigationBar!
    var navigationItem: UINavigationItem!
    weak var delegate: DocumentReadViewDelegate?
    
    // MARK: - Views
    var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .milk
        return view
    }()
    
    lazy var textView: UITextView =  {
        var textview = TextView()
        textview.delegate = self
        return textview
    }()
    
    // MARK: - Init
    init(frame: CGRect = CGRect.zero, navBar: UINavigationBar, navItem: UINavigationItem) {
        self.navigationBar = navBar
        self.navigationItem = navItem
        super.init(frame: frame)
        print("DEBUG: DocumentReadView INIT  ")
        configure()
        
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -  Methods
    private func configure() {
        configureNavigationBar(saveButtonEnabled: false)
        addSubviews()
        addConstraints()
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
        UtilitiesUI.instance.basicNavBarSettings(.light, navigationBar, navigationItem)
        
        let saveButton = UtilitiesUI.instance.barButtonItem(title: "Save", iconName: nil)
        
        saveButton.target = self
        saveButton.action =  #selector(handleSaveButton)
        
        let deleteButton = UtilitiesUI.instance.barButtonItem(title: "", iconName: "trash")
        deleteButton.action =  #selector(handleDeleteButton)
        deleteButton.target = self
        
        saveButton.isEnabled = isEnabled
        navigationItem.rightBarButtonItems = [saveButton, deleteButton]
    }
    
    
    //MARK: - Selectors
    
    @objc func handleSaveButton() {
        delegate?.handleSaveDocument(requset: .init(sourceText: textView.text))
    }
    
    @objc func handleDeleteButton() {
        delegate?.handleDeleteDocument()
    }
}

// MARK: - DocumentReadViewLogic

extension DocumentReadView: DocumentReadViewLogic {
    func setViewModel(viewModel: DocumentReadModels.getDocument.ViewModel) {
        self.viewModel = viewModel
    }
    
    func endEditingDocument() {
        textView.endEditing(true)
        configureNavigationBar(saveButtonEnabled: false)
    }
}
// MARK: - UITextViewDelegate
extension DocumentReadView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard textView.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            configureNavigationBar(saveButtonEnabled: true)
            return
        }
        configureNavigationBar(saveButtonEnabled: false)
    }
}
