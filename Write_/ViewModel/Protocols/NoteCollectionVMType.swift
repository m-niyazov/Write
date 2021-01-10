//
//  NoteCollectionVMType.swift
//  Write_
//
//  Created by Muhamed Niyazov on 10.01.2021.
//  Copyright © 2021 Muhamed Niyazov. All rights reserved.
//

import Foundation


protocol NoteCollectionVMType: class {
    var notes: [Note] { get }
    var numberOfNotes: Int { get }
}
