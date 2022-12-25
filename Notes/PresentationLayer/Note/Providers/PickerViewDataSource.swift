//
//  PickerViewDataSourceProvider.swift
//  Notes
//
//  Created by Дмитрий Данилин on 25.12.2022.
//

import UIKit

protocol IPickerViewDataSourceProvider: UIPickerViewDelegate, UIPickerViewDataSource {
    var fontNames: [FontNameModel] { get set }
}

final class PickerViewDataSourceProvider: NSObject, IPickerViewDataSourceProvider {
    
    // MARK: - Public properties
    
    var fontNames: [FontNameModel] = []
    
    // MARK: - Private properties
    
    private var presenter: NoteViewControllerOutput?
    
    // MARK: - Initializer
    
    init(presenter: NoteViewControllerOutput?) {
        self.presenter = presenter
    }
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        fontNames.count
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fontNames[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        
        let fontName = fontNames[selectedRow].name
        presenter?.changeFontNote(fontName, nil)
    }
}
