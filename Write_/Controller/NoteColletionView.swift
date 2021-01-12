//
//  NoteColletionViewController.swift
//  Write_
//
//  Created by Muhamed Niyazov on 10.01.2021.
//  Copyright © 2021 Muhamed Niyazov. All rights reserved.
//

import Foundation
import UIKit

class NoteColletionViewController: UICollectionViewController {
    // MARK: - Properties
    let viewModel: NoteCollectionVMType!
    
    // MARK: - Init
    init(viewModel: NoteCollectionVMType) {
        self.viewModel = viewModel
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(NoteCell.self, forCellWithReuseIdentifier: "NoteCell")
        collectionView.register(NoteCellAdd.self, forCellWithReuseIdentifier: "NoteCellAdd")
        
    }

}

// MARK: UICollectionViewDelegateFlowLayout
extension NoteColletionViewController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfNotes
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell?

        if(indexPath.row == 0 && (type(of: viewModel!) == type(of: DocumentsControllerVM()))) {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoteCellAdd", for: indexPath) as! NoteCellAdd
        } else {
             cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoteCell", for: indexPath) as! NoteCell
        }
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        UIEdgeInsets.mainInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 2
        let paddingWidth = UIEdgeInsets.mainInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: 195)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.mainInsets
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newNoteVC = NewNoteController()

        navigationController?.pushViewController(newNoteVC, animated: true)
    }
    
}
