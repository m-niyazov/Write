//
//  DocumentCreateViewController.swift
//  Write
//
//  Created by Muhamed Niyazov on 25.04.2021.
//

import UIKit

protocol DocumentCreateDisplayLogic: AnyObject {
    func closeScreen()
}

protocol DocumentCreateViewControllerDelegate: AnyObject {
    func documentCreateSuccess()
}

final class DocumentCreateViewController: UIViewController, DocumentCreateViewDelegate {
    
    // MARK: - Properties
    weak var delegate: DocumentCreateViewControllerDelegate?
    var interactor: DocumentCreateBusinessLogic?
    var router: (DocumentCreateRoutingLogic & DocumentCreateDataPassing)?
    
    var contentView: DocumentCreateViewLogic!
    
    
    
    // MARK: - Lifecycle
    override func loadView() {
        let navigationBar = navigationController!.navigationBar
        contentView = DocumentCreateView(navBar: navigationBar, navItem: navigationItem)
        contentView.delegate = self
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    // MARK: -  Methods
    private func configure() {
        hidesBottomBarWhenPushed = true
    }
    
    // MARK: - UI Actions
    func handleCloseScreenButton() {
        router?.navigateToMainScreen()
    }
    
    func handleCreateDocumentButton(request: DocumentCreateModels.createDocument.Request) {
        interactor?.createDocument(request: request)
    }
    
}

// MARK: - Display Logic
extension DocumentCreateViewController: DocumentCreateDisplayLogic {
    func closeScreen() {
        delegate?.documentCreateSuccess()
        router?.navigateToMainScreen()
    }
    
}
