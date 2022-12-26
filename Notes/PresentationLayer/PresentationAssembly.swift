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
    private let firstStartAppService: IFirstStartAppService
    
    init() {
        coreDataService = serviceAssembly.coreDataService
        firstStartAppService = serviceAssembly.firstStartAppService
    }
    
    lazy var noteList: NoteListConfigurator = {
        return NoteListConfigurator(
            coreDataService: coreDataService,
            firstStartAppService: firstStartAppService,
            splashScreenPresenter: SplashScreenPresenter()
        )
    }()
    
    lazy var note: NoteConfigurator = {
        return NoteConfigurator(coreDataService: coreDataService)
    }()
}
