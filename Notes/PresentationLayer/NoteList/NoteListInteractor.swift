//
//  NoteListInteractor.swift
//  Notes
//
//  Created by Дмитрий Данилин on 21.12.2022.
//

import Foundation

protocol NoteListBusinessLogic {
    
}

final class NoteListInteractor {
    weak var presenter: NoteListPresentationLogic?
}

extension NoteListInteractor: NoteListBusinessLogic {
    
}
