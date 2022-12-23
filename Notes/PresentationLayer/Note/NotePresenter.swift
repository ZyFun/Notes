//
//  NotePresenter.swift
//  Notes
//
//  Created by Дмитрий Данилин on 23.12.2022.
//

import Foundation

protocol NotePresentationLogic: AnyObject {
    
}

protocol NoteViewControllerOutput {
    
}

final class NotePresenter {
    
    // MARK: - Public properties
    
    weak var view: NoteDisplayLogic?
    var interactor: NoteBusinessLogic?
    var router: NoteRoutingLogic?
}

// MARK: - View Controller Output

extension NotePresenter: NoteViewControllerOutput {
    
    // MARK: - Alerts
    
    // MARK: - CRUD methods
    
    // MARK: - Routing

}

// MARK: - Presentation Logic

extension NotePresenter: NotePresentationLogic {
    
}
