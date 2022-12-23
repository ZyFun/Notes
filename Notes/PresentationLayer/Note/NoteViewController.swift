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
    var note: DBNote?
    
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
        presenter?.save(
            title: titleTextField.text,
            note: noteTextView.text,
            for: note
        )
    }
}

// MARK: - Конфигурирование ViewController

extension NoteViewController {
    
    /// Метод инициализации VC
    func setup() {
        view.backgroundColor = .systemGray6
        setupNavigationBar()
        setupUI()
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
    
    // MARK: - Setup UI
    
    func setupUI() {
        setupTextFields()
        setupTextViews()
        setupButtons()
    }
    
    func setupTextFields() {
        titleTextField.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        titleTextField.placeholder = "Введите заголовок"
        titleTextField.borderStyle = .none
    }
    
    func setupTextViews() {
        noteTextView.font = UIFont(name: "HelveticaNeue", size: 17)
        noteTextView.layer.cornerRadius = 10
        noteTextView.clipsToBounds = true
    }
    
    func setupButtons() {
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.setTitleColor(.systemGray, for: .highlighted)
        saveButton.backgroundColor = #colorLiteral(red: 0.196842283, green: 0.4615264535, blue: 0.4103206396, alpha: 1)
        saveButton.layer.cornerRadius = 16
    }
    
    // MARK: - Display data setting
    
    // TODO: (#Fix) Не совсем понимаю, где более правильно писать этот метод. Прямо в классе, или он должен чем-то запускаться из презентера?
    func setTransferredData() {
        titleTextField.text = note?.title
        noteTextView.text = note?.note
    }
}

// MARK: - Логика обновления данных View

extension NoteViewController: NoteDisplayLogic {
    
}
