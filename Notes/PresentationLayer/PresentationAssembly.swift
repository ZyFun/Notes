//
//  PresentationAssembly.swift
//  Notes
//
//  Created by Дмитрий Данилин on 21.12.2022.
//

import Foundation

final class PresentationAssembly {
    private let serviceAssembly = ServiceAssembly()

    private let coreDataService: ICoreDataService
    
    init() {
        coreDataService = serviceAssembly.coreDataService
    }
    
    lazy var noteList: NoteListConfigurator = {
        return NoteListConfigurator(coreDataService: coreDataService)
    }()
}
