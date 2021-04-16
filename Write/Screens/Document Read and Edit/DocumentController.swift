//
//  CreateDocumentController.swift
//  Write
//
//  Created by Muhamed Niyazov on 07.04.2021.
//

import Foundation
import UIKit
import SnapKit

protocol DocumentControllerDelegate {
    func handleSaveDocumentButton()
    func handleDeleteDocumentButton()
}

enum ScreenMode {
    case edit
    case create
    case read
}

class DocumentController: UIViewController {
    // MARK: - Properties
    var delegate: DocumentControllerDelegate?
    var viewModel: DocumentVMType?
    var screenMode: ScreenMode
    
    lazy var textView: UITextView =  {
        var textview = TextView()
        textview.delegate = self
        textview.attributedText = viewModel?.сompleteText ?? .none
        guard screenMode == .create else { return textview }
        textview.becomeFirstResponder()
        return textview
    }()
    
    
    
    // MARK: - Selectors
    @objc func handleDeleteButton() {
        showDeleteAlertController {
            DocumentService.instance.deleteDocument(documentId: self.viewModel!.documentId) {
                self.delegate?.handleDeleteDocumentButton()
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @objc func handleSaveButton() {
        guard let dataDictionary = textViewTextFormatter() else { return  print("DEBUG: Empty Text ")}
        if(screenMode == .edit) {
            self.textView.endEditing(true)
            DocumentService.instance.updateDocument(documentId: viewModel!.documentId, data: dataDictionary) {
                self.delegate?.handleSaveDocumentButton()
                self.screenMode = .read
                self.configureNavigationBar(saveButtonEnabled: false)
            }
        } else if (screenMode == .create) {
            self.configureNavigationBar(saveButtonEnabled: false)
            DocumentService.instance.createDocument(data: dataDictionary) {
                self.dismiss(animated: true, completion: nil)
                self.delegate?.handleSaveDocumentButton()
            }
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar(saveButtonEnabled: false)
        configureUI()
    }
    
    init(screenMode: ScreenMode) {
        self.screenMode = screenMode
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helpers
    
    func configureUI(){
        view.backgroundColor = .milk
        //TextView
        view.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    func configureNavigationBar(saveButtonEnabled isEnabled: Bool)  {
        let saveButtonTitle = screenMode == .edit || screenMode == .read ? "Save" : "Create"
        let saveButton = UtilitiesUI.instance.barButtonItem(title: saveButtonTitle, iconName: nil)
        saveButton.target = self
        saveButton.action =  #selector(handleSaveButton)
        
        let deleteButton = UtilitiesUI.instance.barButtonItem(title: "", iconName: "trash")
        deleteButton.action =  #selector(handleDeleteButton)
        deleteButton.target = self
        
        UtilitiesUI.instance.basicNavBarSettings(.light, navigationController!, navigationItem)
        saveButton.isEnabled = isEnabled
        if(screenMode == .read || screenMode == .edit) {
            navigationItem.rightBarButtonItems = [saveButton, deleteButton]
        } else if (screenMode == .create) {
            navigationItem.rightBarButtonItem = saveButton
        }
    }
    
    func textViewTextFormatter() -> [String:String]? {
        if !textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            let originalText = textView.text!
            let lines = originalText.split(separator:"\n")
            let title = String(lines.first!)
            let mainText = originalText.replacingOccurrences(of: title, with: "")
            return ["title": title, "mainText": mainText]
        }
        
        return nil
    }
    
    func showDeleteAlertController(complition: @escaping( () -> Void)) {
        let alert = UIAlertController(title: "Are you sure you want to delete this document?", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: {_ in
            complition()
        } ))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    
}


extension DocumentController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        configureNavigationBar(saveButtonEnabled: true)
        if(screenMode == .read) {
            screenMode = .edit
        }
    }
}
