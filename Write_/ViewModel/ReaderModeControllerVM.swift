//
//  ColletionViewModel.swift
//  Write_
//
//  Created by Muhamed Niyazov on 10.01.2021.
//  Copyright © 2021 Muhamed Niyazov. All rights reserved.
//

import Foundation

class ReaderModeControllerVM: NoteCollectionVMType {
    var notes: [Note] = []
    
    var numberOfNotes: Int  {
        return notes.count
    }
    
    func noteCellViewModel(indexPath: IndexPath) -> NoteCellViewModel {
        return NoteCellViewModel(note: notes[indexPath.row])
    }
    
}
