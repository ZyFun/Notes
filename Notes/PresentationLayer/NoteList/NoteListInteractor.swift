//
//  NoteListInteractor.swift
//  Notes
//
//  Created by Дмитрий Данилин on 21.12.2022.
//

import Foundation

protocol NoteListBusinessLogic {
    /// Метод для проверки первого старта приложения после установки
    /// - Если приложение запускается впервые, создаётся заметка с инструкцией.
    func checkIsFirstStartApp()
    func delete(_ note: DBNote)
}

final class NoteListInteractor {
    weak var presenter: NoteListPresentationLogic?
    var coreDataService: ICoreDataService?
    var firstStartAppService: IFirstStartAppService?
}

extension NoteListInteractor: NoteListBusinessLogic {
    
    func checkIsFirstStartApp() {
        if firstStartAppService?.isFirstStartApp() == true {
            firstStartAppService?.setIsNotFirstStartApp()
            createLearningNote()
        }
    }
    
    private func createLearningNote() {
        let learningNote = NoteModel(
            title: "Инструкция",
            note: """
            1. Для создания заметки нажмите на «+» в правом верхнем углу экрана.
            2. Для удаления заметок сделайте свайп по заметке в левую сторону.
            3. Для поиска заметок сделайте свайп вниз.
            4. Для окончания редактирования заметки и скрытия клавиатуры, сделайте тап за областью полей ввода.
            5. Для изменения размера шрифта нажмите «+» или «-» под полем редактирования заметки.
            """
        )
        
        coreDataService?.performSave { [weak self] context in
            self?.coreDataService?.create(learningNote, context: context)
        }
    }
    
    func delete(_ note: DBNote) {
        coreDataService?.performSave { [weak self] context in
            self?.coreDataService?.delete(note, context: context)
        }
    }
}
