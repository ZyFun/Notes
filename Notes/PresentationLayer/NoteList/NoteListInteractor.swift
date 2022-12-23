//
//  NoteListInteractor.swift
//  Notes
//
//  Created by Дмитрий Данилин on 21.12.2022.
//

import Foundation

protocol NoteListBusinessLogic {
    func delete(_ note: DBNote)
}

final class NoteListInteractor {
    weak var presenter: NoteListPresentationLogic?
    var coreDataService: ICoreDataService?
}

extension NoteListInteractor: NoteListBusinessLogic {
    func delete(_ note: DBNote) {
        coreDataService?.performSave { context in
            self.coreDataService?.delete(note, context: context)
        }
    }
}
