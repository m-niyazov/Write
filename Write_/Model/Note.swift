//
//  Document.swift
//  Write_
//
//  Created by Muhamed Niyazov on 09.01.2021.
//  Copyright © 2021 Muhamed Niyazov. All rights reserved.
//

import Foundation


struct Note {
    let dateUpdate: Date
    let title: String
    let content: String
    
    
    init(dateUpdate: Date, title: String, content: String) {
        
        self.dateUpdate = dateUpdate
        self.title = title
        self.content = content
        
//        self.dateUpdate = dictionary["dateUpdate"] as! Date
//        self.title = dictionary["title"] as! String
//        self.content = dictionary["content"] as! String
    }
}


