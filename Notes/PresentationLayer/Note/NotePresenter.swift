//
//  NotePresenter.swift
//  Notes
//
//  Created by Дмитрий Данилин on 23.12.2022.
//

import Foundation

protocol NotePresentationLogic: AnyObject {
    func showError()
    /// Метод для возврата в список заметок после сохранения заметки
    func returnToBack()
}

protocol NoteViewControllerOutput {
    func presentTransferredData(from note: DBNote?)
    func changeNoteFontSize(_ size: CGFloat)
    func save(title: String?, note: String?, for currentNote: DBNote?)
}

final class NotePresenter {
    
    // MARK: - Public properties
    
    weak var view: NoteDisplayLogic?
    var interactor: NoteBusinessLogic?
    var router: NoteRoutingLogic?
}

// MARK: - View Controller Output

extension NotePresenter: NoteViewControllerOutput {
    
    // MARK: - Presentation
    
    func presentTransferredData(from note: DBNote?) {
        view?.presentTransferredData(from: note)
    }
    
    func changeNoteFontSize(_ size: CGFloat) {
        view?.changeNoteFontSize(size)
    }
    
    // MARK: - CRUD methods
    
    func save(title: String?, note: String?, for currentNote: DBNote?) {
        let newNote = NoteModel(
            title: title,
            note: note
        )
        
        interactor?.save(currentNote: currentNote, with: newNote)
    }
}

// MARK: - Presentation Logic

extension NotePresenter: NotePresentationLogic {
    func showError() {
        view?.showErrorAlert(errorMessage: .noTitleNote)
    }
    
    func returnToBack() {
        router?.routeTo(target: .backToNoteList)
    }
}
