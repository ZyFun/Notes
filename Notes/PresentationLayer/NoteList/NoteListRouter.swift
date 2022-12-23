//
//  NoteListRouter.swift
//  Notes
//
//  Created by Дмитрий Данилин on 21.12.2022.
//

import UIKit

protocol NoteListRoutingLogic {
    func routeTo(target: NoteListRouter.Target)
}

final class NoteListRouter {
    private var navigationController: UINavigationController?
    
    init(withNavigationController: UINavigationController?) {
        navigationController = withNavigationController
    }
    
    enum Target {
        case noteVC(NoteModel)
    }
}

extension NoteListRouter: NoteListRoutingLogic {
    func routeTo(target: Target) {
        switch target {
        case .noteVC(let note):
            let noteVC = NoteViewController()

            PresentationAssembly().note.config(
                view: noteVC,
                navigationController: navigationController,
                note: note
            )

            navigationController?.pushViewController(noteVC, animated: true)
        }
    }
}
