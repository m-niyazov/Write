//
//  DocumentReadViewController.swift
//  Write
//
//  Created by Muhamed Niyazov on 27.04.2021.
//

import UIKit

protocol DocumentReadViewControllerDelegate:DocumentsViewController {
    func updateDocumentsData()
}

protocol DocumentReadDisplayLogic: AnyObject {
    func showDocument(viewModel: DocumentReadModels.getDocument.ViewModel)
    func endDeletingDocument()
    func endEditingDocument()
}

final class DocumentReadViewController: UIViewController, DocumentReadViewDelegate {
    
    // MARK: - Properties
    weak var delegate: DocumentReadViewControllerDelegate?
    var interactor: DocumentReadBusinessLogic?
    var router: (DocumentReadRoutingLogic & DocumentReadDataPassing)?
    var contentView: DocumentReadViewLogic!
    
    // MARK: - Lifecycle
    override func loadView() {
        let navigationBar = navigationController!.navigationBar
        contentView = DocumentReadView(navBar: navigationBar, navItem: navigationItem)
        view = contentView
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
        configure()
    }
    
    // MARK: - Requests
    func getDocument() {
        interactor?.getDocument()
    }
    
    // MARK: -  Methods
    private func configure() {
        getDocument()
    }

    // MARK: - UI Actions
    func handleSaveDocument(requset: DocumentReadModels.updateDocument.Request) {
        interactor?.updateDocument(request: requset)
    }
    
    func handleDeleteDocument() {
        showDeleteAlertController {
            self.interactor?.deleteDocument()
        }
    }
    
    // MARK: - Helpers
    func showDeleteAlertController(complition: @escaping(() -> Void)) {
        let alert = UIAlertController(title: "Are you sure want to delete this document?", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: {_ in
            complition()
        } ))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
}

// MARK: - Display Logic
extension DocumentReadViewController: DocumentReadDisplayLogic {
    func endEditingDocument() {
        contentView.endEditingDocument()
        delegate?.updateDocumentsData()
    }
    
    func endDeletingDocument() {
        delegate?.updateDocumentsData()
        router?.navigateToMainScreen()
    }
    
    func showDocument(viewModel: DocumentReadModels.getDocument.ViewModel) {
        contentView.setViewModel(viewModel: viewModel)
    }
}
