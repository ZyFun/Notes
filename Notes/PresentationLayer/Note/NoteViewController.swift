//
//  NoteViewController.swift
//  Notes
//
//  Created by Дмитрий Данилин on 23.12.2022.
//

import UIKit

protocol NoteDisplayLogic: AnyObject {
    func presentTransferredData(from note: DBNote?)
    /// Метод для изменения шрифта заметки
    /// - Parameters:
    ///   - name: принимает имя шрифта
    ///   - size: принимает размер шрифта. При изменении имени, передача размера не требуется.
    func changeFontNote(_ name: String, _ size: CGFloat?)
    func showErrorAlert(errorMessage: UIAlertController.ErrorMessage)
}

final class NoteViewController: UIViewController {
    
    // MARK: - Public properties
    
    var presenter: NoteViewControllerOutput?
    var pickerViewDataSource: IPickerViewDataSourceProvider?
    var note: DBNote?
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var fontSizeStepper: UIStepper!
    @IBOutlet weak var fontTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - Private properties
    
    private let fontPickerView = UIPickerView()
    /// Имя текущего  шрифта для заметок
    /// Используется для возможности установить пользователем другой шрифт заметки
    /// - по умолчанию применяется шрифт HelveticaNeue
    private var fontNoteName = "HelveticaNeue"
    private var fontNoteSize: CGFloat = 17
    private let fontNames = FontNameModel.getFontNames()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        presenter?.presentTransferredData(from: note)
        
        addFormattedMenu()
    }
    
    // MARK: - Нужно отрефакторить эту часть
    
    // TODO: (#Fix) Написано на коленке, нужно подумать над архитектурой кода для форматирования.
    // Знаю что эти методы уже деприкейтед для iOS 16. Но новые работают как то криво,
    // либо я просто не разобрался как грамотно написать используя сразу то меню,
    // которое появляется при выделении текста. А не так что приходится выделить текст,
    // закрыть меню тапом, долго удержать палец и только тогда откроется нужное меню.
    func addFormattedMenu() {
        let boldFormatted = UIMenuItem(title: "Bold", action: #selector(boldTextFormatted))
        let italicFormatted = UIMenuItem(title: "Italic", action: #selector(italicTextFormatted))
        let underlineFormatted2 = UIMenuItem(title: "Underline", action: #selector(underlineTextFormatted))
        
        UIMenuController.shared.menuItems = [boldFormatted, italicFormatted, underlineFormatted2]
    }
    
    @objc func normalTextFormatted() {
        let range = noteTextView.selectedRange
        let string = NSMutableAttributedString(
            attributedString: noteTextView.attributedText
        )
        let normalAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: fontNoteSize)
        ]
        string.addAttributes(normalAttribute, range: range)
        noteTextView.attributedText = string
        noteTextView.selectedRange = range
    }
    
    @objc func boldTextFormatted() {
        let range = noteTextView.selectedRange
        let string = NSMutableAttributedString(
            attributedString: noteTextView.attributedText
        )
        let boldAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: fontNoteSize)
        ]
        string.addAttributes(boldAttribute, range: range)
        noteTextView.attributedText = string
        noteTextView.selectedRange = range
    }
    
    @objc func italicTextFormatted() {
        let range = noteTextView.selectedRange
        let string = NSMutableAttributedString(
            attributedString: noteTextView.attributedText
        )
        let italicAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.italicSystemFont(ofSize: fontNoteSize)
        ]
        string.addAttributes(italicAttribute, range: range)
        noteTextView.attributedText = string
        noteTextView.selectedRange = range
    }
    
    @objc func underlineTextFormatted() {
        let range = noteTextView.selectedRange
        let string = NSMutableAttributedString(
            attributedString: noteTextView.attributedText
        )
        let underlineAttribute = [
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
        string.addAttributes(underlineAttribute, range: range)
        noteTextView.attributedText = string
        noteTextView.selectedRange = range
    }
    
    // MARK: - Override Methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - IBActions
    
    @IBAction func fontSizeStepperPressed(_ sender: UIStepper) {
        let fontSize = CGFloat(sender.value)
        
        presenter?.changeFontNote(fontNoteName, fontSize)
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

private extension NoteViewController {
    
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
        setupPickerView()
        setupTextFields()
        setupTextViews()
        setupSteppers()
        setupButtons()
    }
    
    func setupPickerView() {
        fontPickerView.delegate = pickerViewDataSource
        fontPickerView.dataSource = pickerViewDataSource
        pickerViewDataSource?.fontNames = fontNames
        addToolbarToKeyboard(for: fontTextField)
    }
    
    /// Метод добавляет тулбар на клавиатуру для определенного поля редактирования.
    /// - Parameter textField: принимает поле, для клавиатуры которого
    /// требуется добавить тулбар.
    func addToolbarToKeyboard(for textField: UITextField) {
        let toolbar = UIToolbar(
            frame: CGRect(
                x: 0,
                y: 0,
                width: view.bounds.width,
                height: 44
            )
        )
        
        let leftSpacing = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(toolBarDoneButtonPressed)
        )
        
        toolbar.setItems([leftSpacing, doneButton], animated: false)
        textField.inputAccessoryView = toolbar
    }
    
    @objc func toolBarDoneButtonPressed() {
        let selectedRow = fontPickerView.selectedRow(inComponent: 0)
        fontTextField.text = fontNames[selectedRow].name
        fontTextField.resignFirstResponder()
    }
    
    func setupTextFields() {
        titleTextField.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        titleTextField.placeholder = "Введите заголовок"
        titleTextField.borderStyle = .none
        
        fontTextField.inputView = fontPickerView
        fontTextField.text = fontNoteName
        fontTextField.tintColor = .clear
    }
    
    func setupTextViews() {
        noteTextView.font = UIFont(name: fontNoteName, size: fontNoteSize)
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
    
    func changeFontNote(_ name: String, _ size: CGFloat?) {
        fontNoteName = name
        
        if let fontNoteSize = size {
            noteTextView.font = UIFont(name: fontNoteName, size: fontNoteSize)
            self.fontNoteSize = fontNoteSize
        } else {
            noteTextView.font = UIFont(name: fontNoteName, size: fontNoteSize)
        }
    }
    
    func showErrorAlert(errorMessage: UIAlertController.ErrorMessage) {
        let alert = UIAlertController
            .createErrorAlertController(errorMessage: errorMessage)
        
        alert.actionError()
        
        present(alert, animated: true)
    }
}
