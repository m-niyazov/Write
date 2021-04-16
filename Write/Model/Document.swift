//
//  Document.swift
//  Write
//
//  Created by Muhamed Niyazov on 08.04.2021

import Foundation

struct Document {
    let title: String
    let mainText: String
    var timestamp: Double
    let documentId: String
    let uid: String
    
    init(documentId: String, dictionary: [String: Any]) {
        self.documentId = documentId
        self.title = dictionary["title"] as? String ?? "-"
        self.mainText = dictionary["mainText"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.timestamp = dictionary["timestamp"]  as? Double ?? 0
    }
}
