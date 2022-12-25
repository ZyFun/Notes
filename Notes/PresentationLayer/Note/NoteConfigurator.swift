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
        note: DBNote?
    ) {
        guard let view = view as? NoteViewController else {
            ConsoleLogger.error("ViewController заметки не инициализирован")
            return
        }
        
        let presenter = NotePresenter()
        let interactor = NoteInteractor()
        let router = NoteRouter(withNavigationController: navigationController)
        let pickerViewDataSource = PickerViewDataSourceProvider(presenter: presenter)
        
        view.presenter = presenter
        view.note = note
        view.pickerViewDataSource = pickerViewDataSource
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        interactor.coreDataService = coreDataService
    }
}
