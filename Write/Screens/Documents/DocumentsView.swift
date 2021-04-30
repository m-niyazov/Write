//
//  DocumentsView.swift
//  Write
//
//  Created by Muhamed Niyazov on 22.04.2021.
//

import SnapKit
import UIKit

protocol DocumentsViewLogic: UIView {
    var delegate: DocumentsViewDelegate? { get set }
    func showDocuments(viewModel: DocumentsModels.fetchDocuments.ViewModel)
    func configureNavigationBar()
    func activityIndicator(active: Bool)
    func showEmptyDocumentsView(show: Bool)
    
}
protocol DocumentsViewDelegate: AnyObject {
    func handleCreateDocumentButton()
    func didSelectDocument(selectedDocument: Document)
}

final class DocumentsView: UIView {
    weak var delegate: DocumentsViewDelegate?
    var navigationBar: UINavigationBar!
    var navigationItem: UINavigationItem!
    
    // MARK: - Views
    var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let activityView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.color = .milk
        return activityView
    }()
    
    lazy var emptyDocumentsView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .bgGray
        view.isHidden = true
        
        let titleText = textLabelGenerate(text: "No documents here yet...")
        titleText.font = UIFont.boldSystemFont(ofSize: 16)
        
        let secondaryText = textLabelGenerate(text: "Create a document by clicking on the button below 🌚")
        
        view.addSubview(titleText)
        titleText.snp.makeConstraints { make in
            make.top.equalTo(view).offset(20)
            make.left.equalTo(view).inset(30)
            make.right.equalTo(view).inset(30)
        }
        
        view.addSubview(secondaryText)
        secondaryText.snp.makeConstraints { make in
            make.top.equalTo(titleText.snp.bottom).offset(10)
            make.bottom.equalTo(view).inset(20)
            make.left.equalTo(view).inset(30)
            make.right.equalTo(view).inset(30)
        }
        
        return view
    }()
    
    let collectionView = CollectionView()
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.searchTextField.backgroundColor = .bgGray
        searchController.delegate = collectionView
        searchController.searchBar.delegate = collectionView
        return searchController
    }()
    
    let createDocumentButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .bgGray
        button.setImage(UIImage(named: "add-icon"), for: .normal)
        button.layer.cornerRadius = 66 / 2
        button.addTarget(self, action: #selector(handleCreateDocumentButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    init(frame: CGRect = CGRect.zero, navBar: UINavigationBar, navItem: UINavigationItem) {
        super.init(frame: frame)
        self.navigationBar = navBar
        self.navigationItem = navItem
        configure()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func configure() {
        collectionView.delegate = self
        addSubviews()
        addConstraints()
        configureNavigationBar()
    }
    
    private func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(collectionView.view)
        containerView.addSubview(createDocumentButton)
        containerView.addSubview(activityView)
        containerView.addSubview(emptyDocumentsView)
    }
    
    private func addConstraints() {
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        createDocumentButton.snp.makeConstraints { (make) in
            make.height.equalTo(66)
            make.width.equalTo(66)
            make.bottom.equalTo(containerView.safeAreaLayoutGuide).inset(30)
            make.right.equalTo(containerView).inset(30)
        }
        
        activityView.snp.makeConstraints { make in
            make.center.equalTo(containerView)
        }
        
        emptyDocumentsView.snp.makeConstraints { make in
            make.center.equalTo(containerView)
            make.width.equalTo(260)
            
        }
    }
    func textLabelGenerate(text: String) -> UILabel {
        let labelText = UILabel()
        labelText.textColor = .white
        labelText.numberOfLines = 0
        labelText.text = text
        labelText.textAlignment = .center
        return labelText
    }
    
    // MARK: - Selectors
    @objc func handleCreateDocumentButton() {
        delegate?.handleCreateDocumentButton()
    }
    
    // MARK: - Helpers
    func configureNavigationBar() {
        UtilitiesUI.instance.basicNavBarSettings(.dark, navigationBar, navigationItem)
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        backItem.tintColor = UIColor.white
        navigationItem.backBarButtonItem = backItem
        navigationItem.backBarButtonItem?.tintColor = UIColor.rgb(red: 121, green: 121, blue: 121)
        
        //searchController
        navigationItem.searchController = searchController
        let searchBar = searchController.searchBar
        searchBar.customize()
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK: - DocumentsViewLogic
extension DocumentsView: DocumentsViewLogic {
    
    func showEmptyDocumentsView(show: Bool) {
        emptyDocumentsView.isHidden = !show
    }
    
    func activityIndicator(active: Bool) {
        guard active else {
            activityView.stopAnimating()
            return
        }
        activityView.startAnimating()
    }
    
    func showDocuments(viewModel: DocumentsModels.fetchDocuments.ViewModel) {
        collectionView.documents = viewModel.documents
    }
}
// MARK: - CollectionViewDelegate
extension DocumentsView: CollectionViewDelegate {
    func didSelectItemAt(selectedItem: Document) {
        delegate?.didSelectDocument(selectedDocument: selectedItem)
    }
}
