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

}

// MARK: - Presentation Logic

extension NoteListPresenter: NoteListPresentationLogic {
    
}
