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
        /// Принимает опционально модель базы данных заметки
        /// - Если модель nil, откроется пустое окно редактирования и отработает логика
        /// с сохранением новой заметки.
        /// - если модель не nil, откроет окно с информацией из модели и при изменении данных
        /// отработает логика по редактированию заметки
        /// - логика сохранения/редактирования прописана в интеракторе модуля Note
        case noteVC(DBNote?)
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
