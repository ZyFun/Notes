//
//  NoteListPresenter.swift
//  Notes
//
//  Created by Дмитрий Данилин on 21.12.2022.
//

import Foundation

protocol NoteListPresentationLogic: AnyObject {
    
}

protocol NoteListViewControllerOutput {
    func routeToNote(with currentNote: DBNote)
}

final class NoteListPresenter {
    
    // MARK: - Public properties
    
    weak var view: NoteListDisplayLogic?
    var interactor: NoteListBusinessLogic?
    var router: NoteListRoutingLogic?
}

// MARK: - View Controller Output

extension NoteListPresenter: NoteListViewControllerOutput {
    
    // MARK: - Alerts
    
    // MARK: - CRUD methods
    
    // MARK: - Routing
    
    func routeToNote(with currentNote: DBNote) {
        let note = NoteModel(
            title: currentNote.title ?? "",
            note: currentNote.note ?? ""
        )
        
        router?.routeTo(target: .noteVC(note))
    }
}

// MARK: - Presentation Logic

extension NoteListPresenter: NoteListPresentationLogic {
    
}
