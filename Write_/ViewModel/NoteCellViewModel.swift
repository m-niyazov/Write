//
//  ViewModel.swift
//  Write_
//
//  Created by Muhamed Niyazov on 10.01.2021.
//  Copyright © 2021 Muhamed Niyazov. All rights reserved.
//

import Foundation


class NoteCellViewModel {
    var note: Note
    
    init(note: Note){
        self.note = note
    }
    
    var title: String {
        return note.title
    }
    
    var dateUpdate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM, yyyy"
        let dateString = dateFormatter.string(from: note.dateUpdate)
        return dateString
    }
    
    var content: String {
        note.content
    }
    
}
