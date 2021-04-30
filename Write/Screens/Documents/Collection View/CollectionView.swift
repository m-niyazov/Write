//
//  CollectionView.swift
//  Write
//
//  Created by Muhamed Niyazov on 29.03.2021.
//

import UIKit

private let reuseIdentifier = "CollectionViewCell"

protocol CollectionViewDelegate: AnyObject {
    func didSelectItemAt(selectedItem: Document )
}

class CollectionView: UICollectionViewController {
    //MARK: - Properties
    weak var delegate: CollectionViewDelegate?
    
    var documents = [Document]() {
        didSet {
            collectionView.reloadData()
            filteredDocuments = documents
        }
    }
    
    var filteredDocuments = [Document]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    //MARK: - Lifecylce
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        collectionView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        self.collectionView!.register(CollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: UICollectionViewDataSource & UICollectionViewDelegate
extension CollectionView {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredDocuments.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        let document = filteredDocuments[indexPath.row]
        cell.viewModel = DocumentsModels.CollectionViewCellViewModel(document: document)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItemAt(selectedItem: filteredDocuments[indexPath.row])
    }
}


// MARK: UICollectionViewDelegateFlowLayout
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

