//
//  DocumentVM.swift
//  Write
//
//  Created by Muhamed Niyazov on 09.04.2021.
//

import Foundation
import UIKit
protocol collectionViewCellVMType {
    var title: String {get}
    var timestamp: String {get}
}

protocol DocumentVMType {
    var title: String {get}
    var mainText: String {get}
    var timestamp: String {get}
    var сompleteText: NSMutableAttributedString {get}
    var documentId: String {get}
}


struct DocumentVM: DocumentVMType, collectionViewCellVMType {
    
    private var document: Document!
    
    var title: String {
        return document.title
    }
    
    var mainText: String {
        return document.mainText
    }
    
    var timestamp: String {
        let timeInterval = document.timestamp
        let date = NSDate(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM, yyyy"
        let dateString = dateFormatter.string(from: date as Date)
        return dateString
    }
    
    var сompleteText: NSMutableAttributedString {
        let attributedText = NSMutableAttributedString(string: """
            \(mainText)
            """, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .regular)])
        
        let titleBold = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.init(name: "PlayfairDisplay-Bold", size: 22)!])
        
        attributedText.insert(titleBold, at: 0)
        return attributedText
    }
    
    var documentId: String {
        return document.documentId
    }
    
    init(document: Document) {
        self.document = document
    }
}
