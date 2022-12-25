//
//  NoteViewController.swift
//  Notes
//
//  Created by Дмитрий Данилин on 23.12.2022.
//

import UIKit

protocol NoteDisplayLogic: AnyObject {
    func presentTransferredData(from note: DBNote?)
    func changeNoteFontSize(_ size: CGFloat)
    func showErrorAlert(errorMessage: UIAlertController.ErrorMessage)
}

final class NoteViewController: UIViewController {
    
    // MARK: - Public properties
    
    var presenter: NoteViewControllerOutput?
    var note: DBNote?
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var fontSizeStepper: UIStepper!
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - Private properties
    
    /// Имя текущего  шрифта для заметок
    /// Используется для возможности установить пользователем другой шрифт заметки
    /// - по умолчанию применяется шрифт HelveticaNeue
    private var nameFontNote = "HelveticaNeue"
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        presenter?.presentTransferredData(from: note)
        
    }
    
    // MARK: - Override Methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - IBActions
    
    @IBAction func fontSizeStepperPressed(_ sender: UIStepper) {
        let fontSize = CGFloat(sender.value)
        
        presenter?.changeNoteFontSize(fontSize)
    }
    
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
        setupSteppers()
        setupButtons()
    }
    
    func setupTextFields() {
        titleTextField.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        titleTextField.placeholder = "Введите заголовок"
        titleTextField.borderStyle = .none
    }
    
    func setupTextViews() {
        noteTextView.font = UIFont(name: nameFontNote, size: 17)
        noteTextView.layer.cornerRadius = 10
        noteTextView.clipsToBounds = true
    }
    
    func setupSteppers() {
        fontSizeStepper.value = 17
        fontSizeStepper.minimumValue = 10
        fontSizeStepper.maximumValue = 25
    }
    
    func setupButtons() {
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.setTitleColor(.systemGray, for: .highlighted)
        saveButton.backgroundColor = #colorLiteral(red: 0.196842283, green: 0.4615264535, blue: 0.4103206396, alpha: 1)
        saveButton.layer.cornerRadius = 16
    }
}

// MARK: - Логика обновления данных View

extension NoteViewController: NoteDisplayLogic {
    func presentTransferredData(from note: DBNote?) {
        titleTextField.text = note?.title
        noteTextView.text = note?.note
    }
    
    func changeNoteFontSize(_ size: CGFloat) {
        noteTextView.font = UIFont(name: nameFontNote, size: size)
    }
    
    func showErrorAlert(errorMessage: UIAlertController.ErrorMessage) {
        let alert = UIAlertController
            .createErrorAlertController(errorMessage: errorMessage)
        
        alert.actionError()
        
        present(alert, animated: true)
    }
}
