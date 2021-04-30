//
//  DocumentsViewController.swift
//  Write
//
//  Created by Muhamed Niyazov on 22.04.2021.
//

import UIKit

protocol DocumentsDisplayLogic: AnyObject {
    func showDocuments(viewModel: DocumentsModels.fetchDocuments.ViewModel)
    func showEmptyDocumentsView(show: Bool)
}

final class DocumentsViewController: UIViewController, DocumentsViewDelegate {
    // MARK: - Properties
    var interactor: DocumentsBusinessLogic?
    var router: (DocumentsRoutingLogic & DocumentsDataPassing)?
    var contentView: DocumentsViewLogic!
    private var documents: [Document]?
    
    // MARK: - Lifecycle
    override func loadView() {
        let navigationBar = navigationController!.navigationBar
        contentView = DocumentsView(navBar: navigationBar, navItem: navigationItem)
        contentView.delegate = self
        view = contentView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        contentView.configureNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    deinit {
        print("DEBUG: DEINIT DocumentsViewController ")
    }
    
    // MARK: - Requests
    func getDocuments() {
        contentView.activityIndicator(active: true)
        interactor?.fetchDocuments()
    }
    
    // MARK: -  Methods
    private func configure() {
        getDocuments()
    }

    
    // MARK: - UI Actions
    func handleCreateDocumentButton() {
        router?.navigateToCreateDocumentScreen()
    }
    
    func didSelectDocument(selectedDocument: Document) {
        router?.navigateToSelectedDocument(selectedDocument: selectedDocument)
    }
}

// MARK: - Display Logic
extension DocumentsViewController: DocumentsDisplayLogic {
    func showEmptyDocumentsView(show: Bool) {
        contentView.showEmptyDocumentsView(show: show)
    }
    
    func showDocuments(viewModel: DocumentsModels.fetchDocuments.ViewModel) {
        contentView.activityIndicator(active: false)
        contentView.showDocuments(viewModel: viewModel)
    }
}

// MARK: - DocumentCreateViewControllerDelegate
extension DocumentsViewController: DocumentCreateViewControllerDelegate {
    func documentCreateSuccess() {
        getDocuments()
    }
}

// MARK: - DocumentReadViewControllerDelegate
extension DocumentsViewController: DocumentReadViewControllerDelegate {
    func updateDocumentsData() {
        getDocuments()
    }
}
