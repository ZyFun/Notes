//
//  NoteListConfigurator.swift
//  Notes
//
//  Created by Дмитрий Данилин on 21.12.2022.
//

import UIKit

final class NoteListConfigurator {
    func config(view: UIViewController, navigationController: UINavigationController?) {
        guard let view = view as? NoteListViewController else { return }
        
        let presenter = NoteListPresenter()
        let interactor = NoteListInteractor()
        let router = NoteListRouter(withNavigationController: navigationController)
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
    }
}
