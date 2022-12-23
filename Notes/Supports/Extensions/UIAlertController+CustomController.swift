//
//  UIAlertController+CustomController.swift
//  Notes
//
//  Created by Дмитрий Данилин on 23.12.2022.
//

import UIKit

extension UIAlertController {
    
    /// Кейсы с сообщениями об ошибке
    enum ErrorMessage: String {
        /// Отображает сообщение, о том что поле с названием необходимо заполнить
        case noTitleNote = "Поле с заголовком не должно быть пустым"
    }
    
    /// Алерт для отображения сообщения об ошибке.
    /// - Parameter errorMessage: принимает кейс с ошибкой,
    /// для отображения нужного сообщения
    static func createErrorAlertController(
        errorMessage: UIAlertController.ErrorMessage
    ) -> UIAlertController {
        
        UIAlertController(
            title: "Ошибка",
            message: errorMessage.rawValue,
            preferredStyle: .alert
        )
    }
    
    /// Действия для алерта с выводом сообщения об ошибке.
    func actionError() {
        let actionOk = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        addAction(actionOk)
    }
}
