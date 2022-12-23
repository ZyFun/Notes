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
    /// Метод для проверки первого старта приложения после установки
    /// - Если приложение запускается впервые, создаётся заметка с инструкцией.
    func checkIsFirstStartApp()
    func delete(_ note: DBNote)
    func routeToNote(with currentNote: DBNote?)
}

final class NoteListPresenter {
    
    // MARK: - Public properties
    
    weak var view: NoteListDisplayLogic?
    var interactor: NoteListBusinessLogic?
    var router: NoteListRoutingLogic?
}

// MARK: - View Controller Output

extension NoteListPresenter: NoteListViewControllerOutput {
    func checkIsFirstStartApp() {
        interactor?.checkIsFirstStartApp()
    }
    
    // MARK: - CRUD
    
    func delete(_ note: DBNote) {
        interactor?.delete(note)
    }
    
    // MARK: - Routing
    
    func routeToNote(with currentNote: DBNote?) {
        router?.routeTo(target: .noteVC(currentNote))
    }
}

// MARK: - Presentation Logic

extension NoteListPresenter: NoteListPresentationLogic {
    
}
