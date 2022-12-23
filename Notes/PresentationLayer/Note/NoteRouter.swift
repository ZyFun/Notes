//
//  NoteRouter.swift
//  Notes
//
//  Created by Дмитрий Данилин on 23.12.2022.
//

import UIKit

protocol NoteRoutingLogic {
    func routeTo(target: NoteRouter.Target)
}

final class NoteRouter {
    private var navigationController: UINavigationController?
    
    init(withNavigationController: UINavigationController?) {
        navigationController = withNavigationController
    }
    
    enum Target {
        case backToNoteList
    }
}

extension NoteRouter: NoteRoutingLogic {
    func routeTo(target: Target) {
        switch target {
        case .backToNoteList:
            navigationController?.popViewController(animated: true)
        }
    }
}
