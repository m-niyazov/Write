//
//  CollectionView.swift
//  Write
//
//  Created by Muhamed Niyazov on 29.03.2021.
//

import UIKit

private let reuseIdentifier = "CollectionViewCell"

class CollectionView: UICollectionViewController {
    //MARK: - Properties
    var documents = [Document]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var filteredDocuments = [Document]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        self.collectionView!.register(CollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        fetchDocuments()
        configureUI()
    }
    
    //MARK: - API
    func fetchDocuments() {
        DocumentService.instance.fetchDocuments() { (documents) in
            self.documents = documents
            self.filteredDocuments = documents
        }
    }
    
    //MARK: - Helperse
    
    func configureUI() {
        //searchController
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        let searchBar = searchController.searchBar
        searchBar.customize()
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
}

// MARK: UICollectionViewDataSource
extension CollectionView {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredDocuments.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        cell.viewModel = DocumentVM(document: filteredDocuments[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let documentController = DocumentController(screenMode: .read)
        documentController.delegate = self
        documentController.viewModel = DocumentVM(document: documents[indexPath.row])
        navigationController?.pushViewController(documentController, animated: true)
        
    }
    
}


// MARK: UICollectionViewDelegate
extension CollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        UIEdgeInsets.mainInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 2
        let paddingWidth = UIEdgeInsets.mainInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.mainInsets
    }
}


//MARK: DocumentControllerDelegate

extension CollectionView: DocumentControllerDelegate {
    func handleDeleteDocumentButton() {
        fetchDocuments()
    }
    
    func handleSaveDocumentButton() {
        fetchDocuments()
    }
}

//MARK: UISearchControllerDelegate
extension CollectionView: UISearchControllerDelegate, UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredDocuments = documents
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredDocuments = []
        
        if (searchText == "") {
            filteredDocuments = documents
        } else {
            for document in documents {
                if(document.title.lowercased().contains(searchText.lowercased())) {
                    filteredDocuments.append(document)
                }
            }
        }
        self.collectionView.reloadData()
    }

}

