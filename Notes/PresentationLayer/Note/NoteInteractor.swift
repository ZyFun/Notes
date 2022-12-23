//
//  NoteInteractor.swift
//  Notes
//
//  Created by Дмитрий Данилин on 23.12.2022.
//

import Foundation

protocol NoteBusinessLogic {
    
}

final class NoteInteractor {
    weak var presenter: NotePresentationLogic?
    var coreDataService: ICoreDataService?
}

extension NoteInteractor: NoteBusinessLogic {
    
}
