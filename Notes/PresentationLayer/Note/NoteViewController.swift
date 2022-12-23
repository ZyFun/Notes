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
    var note: NoteModel?
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
    }
    
    // MARK: - IBActions
    
    @IBAction func saveButtonPressed() {
        
    }
}

// MARK: - Конфигурирование ViewController

extension NoteViewController {
    
    /// Метод инициализации VC
    func setup() {
        view.backgroundColor = .systemGray6
        setupNavigationBar()
        setTransferredData()
    }
    
    // MARK: - Setup navigation bar
    
    /// Метод настройки navigation bar
    func setupNavigationBar() {
        titleSetup()
    }
    
    /// Метод для настройки заголовка navigation bar
    func titleSetup() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    // MARK: - Display data setting
    
    // TODO: (#Fix) Не совсем понимаю, где более правильно писать этот метод. Прямо в классе, или он должен чем-то запускаться из презентера?
    func setTransferredData() {
        titleTextField.text = note?.note
        noteTextView.text = note?.note
    }
}

// MARK: - Логика обновления данных View

extension NoteViewController: NoteDisplayLogic {
    
}
