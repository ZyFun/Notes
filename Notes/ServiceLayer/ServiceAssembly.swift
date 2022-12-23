//
//  ServiceAssembly.swift
//  Notes
//
//  Created by Дмитрий Данилин on 22.12.2022.
//

import Foundation

final class ServiceAssembly {
    lazy var coreDataService: ICoreDataService = {
        return CoreDataService.shared
    }()
    
    lazy var firstStartAppService: IFirstStartAppService = {
        return FirstStartAppService()
    }()
}
