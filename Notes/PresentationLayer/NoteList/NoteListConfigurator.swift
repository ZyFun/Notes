//
//  NoteListConfigurator.swift
//  Notes
//
//  Created by Дмитрий Данилин on 21.12.2022.
//

import UIKit

final class NoteListConfigurator {
    
    private let coreDataService: ICoreDataService
    private let fetchedResultManager: INoteListFetchedResultsManager
    
    init(
        coreDataService: ICoreDataService
    ) {
        self.coreDataService = coreDataService
        fetchedResultManager = NoteListFetchedResultsManager(
            fetchedResultsController: coreDataService.fetchResultController(
                entityName: String(describing: DBNote.self),
                keyForSort: #keyPath(DBNote.title),
                sortAscending: true
            )
        )
    }
    
    func config(view: UIViewController, navigationController: UINavigationController?) {
        guard let view = view as? NoteListViewController else {
            ConsoleLogger.error("ViewController списка заметок не инициализирован")
            return
        }
        
        let presenter = NoteListPresenter()
        let interactor = NoteListInteractor()
        let router = NoteListRouter(withNavigationController: navigationController)
        let dataSourceProvider = NoteListDataSourceProvider(
            presenter: presenter,
            resultManager: fetchedResultManager
        )
        
        view.presenter = presenter
        view.dataSourceProvider = dataSourceProvider
        view.fetchedResultManager = fetchedResultManager
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        interactor.coreDataService = coreDataService
    }
}
