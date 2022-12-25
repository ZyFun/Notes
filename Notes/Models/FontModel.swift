//
//  FontModel.swift
//  Notes
//
//  Created by Дмитрий Данилин on 25.12.2022.
//

import Foundation

struct FontNameModel {
    let name: String
    
    static func getFontNames() -> [FontNameModel] {
        [
            FontNameModel(name: "HelveticaNeue"),
            FontNameModel(name: "Georgia"),
            FontNameModel(name: "Courier")
        ]
    }
}
