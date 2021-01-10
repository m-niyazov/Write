//
//  DocumentsControllerVM.swift
//  Write_
//
//  Created by Muhamed Niyazov on 10.01.2021.
//  Copyright © 2021 Muhamed Niyazov. All rights reserved.
//

import Foundation


class DocumentsControllerVM: NoteCollectionVMType {
    var notes: [Note]
    
    init(notes: [Note] = []) {
        var notesArray = notes
        let cellAddMockup: Note = Note(dateUpdate: Date(), title: "", content: "")
        notesArray.insert(cellAddMockup, at: 0)
        self.notes = notesArray
    }
    
    var numberOfNotes: Int {
        return notes.count 
    }
}
