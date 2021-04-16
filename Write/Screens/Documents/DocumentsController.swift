//
//  DocumentsController.swift
//  Write
//
//  Created by Muhamed Niyazov on 20.03.2021.
//

import Foundation
import UIKit

class DocumentsController: UIViewController {
    // MARK: - Properties
    
    let collectionView = CollectionView()
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false 
        searchController.delegate = collectionView
        searchController.searchBar.delegate = collectionView
        return searchController
    }()
    
    let createDocumentButton: UIButton = {
        let button = UtilitiesUI.instance.createDocumentButton()
        button.addTarget(self, action: #selector(handleCreateDocumentButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Selectors
    @objc func handleCreateDocumentButton() {
        let documentController = DocumentController(screenMode: .create)
        let navDocumentController = UINavigationController(rootViewController: documentController)
        documentController.delegate = collectionView
        present(navDocumentController, animated: true, completion: nil)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    // MARK: - Helpers
    func configureUI(){
        view.backgroundColor = .black
        configureNavigationBar()
        
        
        //collectionView
        addChild(collectionView)
        view.addSubview(collectionView.view)
        
        //createDocumentButton
        view.addSubview(createDocumentButton)
        createDocumentButton.snp.makeConstraints { (make) in
            make.height.equalTo(66)
            make.width.equalTo(66)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.right.equalTo(view).inset(30)
        }
    }
    
    func configureNavigationBar() {
        UtilitiesUI.instance.basicNavBarSettings(.dark, navigationController!, navigationItem)
        let backItem = UIBarButtonItem()
        backItem.title = ""
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

