//
//  NoteConfigurator.swift
//  Notes
//
//  Created by Дмитрий Данилин on 23.12.2022.
//

import UIKit

final class NoteConfigurator {
    
    private let coreDataService: ICoreDataService
    
    init(
        coreDataService: ICoreDataService
    ) {
        self.coreDataService = coreDataService
    }
    
    func config(
        view: UIViewController,
        navigationController: UINavigationController?,
        note: NoteModel
    ) {
        guard let view = view as? NoteViewController else {
            ConsoleLogger.error("ViewController заметки не инициализирован")
            return
        }
        
        let presenter = NotePresenter()
        let interactor = NoteInteractor()
        let router = NoteRouter(withNavigationController: navigationController)
        
        view.presenter = presenter
        view.note = note
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        interactor.coreDataService = coreDataService
    }
}
