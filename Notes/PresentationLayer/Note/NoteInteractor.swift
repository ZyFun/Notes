//
//  NoteInteractor.swift
//  Notes
//
//  Created by Дмитрий Данилин on 23.12.2022.
//

import Foundation

protocol NoteBusinessLogic {
    func save(currentNote: DBNote?, with newNote: NoteModel)
}

final class NoteInteractor {
    weak var presenter: NotePresentationLogic?
    var coreDataService: ICoreDataService?
}

extension NoteInteractor: NoteBusinessLogic {
    func save(currentNote: DBNote?, with newNote: NoteModel) {
        if newNote.title == nil || newNote.title == "" {
            presenter?.showError()
            return
        }
        
        // Не использую [weak self] в замыкании из соображений, что после выхода
        // из модуля мне нужно продолжать удерживать сервис в памяти,
        // пока данные не сохранятся.
        // Возможно я не прав, поправьте пожалуйста)
        coreDataService?.performSave { context in
            if let currentNote {
                self.coreDataService?.update(currentNote, newData: newNote, context: context)
            } else {
                self.coreDataService?.create(newNote, context: context)
            }
        }
        
        presenter?.returnToBack()
    }
}
