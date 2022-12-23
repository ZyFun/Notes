//
//  NoteViewController.swift
//  Notes
//
//  Created by Дмитрий Данилин on 23.12.2022.
//

import UIKit

protocol NoteDisplayLogic: AnyObject {
    
}

final class NoteViewController: UIViewController {
    
    // MARK: - Public properties
    
    var presenter: NoteViewControllerOutput?
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - IBActions
    
    @IBAction func saveButtonPressed() {
        
    }
}

// MARK: - Логика обновления данных View

extension NoteViewController: NoteDisplayLogic {
    
}
