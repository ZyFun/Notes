//
//  FirstStartAppService.swift
//  Notes
//
//  Created by Дмитрий Данилин on 23.12.2022.
//

import Foundation

protocol IFirstStartAppService {
    /// Метод проверяет наличие ключа "firstStartApp" в UserDefaults.
    /// - Используется для логики добавления в базу инструкции пользования в виде тестовой
    /// заметки, которую пользователь в дальнейшем удалит при желании. Если ключа нет.
    func isFirstStartApp() -> Bool
    /// Метод устанавливает ключь "firstStartApp" в UserDefaults в значение true.
    /// - Используется для того, чтобы инструкция  больше не создавалась.
    func setIsNotFirstStartApp()
}

final class FirstStartAppService: IFirstStartAppService {
    
    func isFirstStartApp() -> Bool {
        return !UserDefaults.standard.bool(forKey: "firstStartApp")
    }
    
    func setIsNotFirstStartApp() {
        UserDefaults.standard.set(true, forKey: "firstStartApp")
    }
}
