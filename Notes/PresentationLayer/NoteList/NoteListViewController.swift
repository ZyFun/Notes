//
//  NoteListViewController.swift
//  Notes
//
//  Created by Дмитрий Данилин on 21.12.2022.
//

import UIKit

protocol NoteListDisplayLogic: AnyObject {
    
}

final class NoteListViewController: UIViewController {
    
    // MARK: - Public properties
    
    var presenter: NoteListViewControllerOutput?
    var dataSourceProvider: INoteListDataSourceProvider?
    var fetchedResultManager: INoteListFetchedResultsManager?
    
    // MARK: - Outlets
    
    @IBOutlet weak var noteListTableView: UITableView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        presenter?.checkIsFirstStartApp()
    }
}

// MARK: - Конфигурирование ViewController

extension NoteListViewController {
    
    /// Метод инициализации VC
    func setup() {
        view.backgroundColor = .systemGray6
        setupNavigationBar()
        setupTableView()
        setupPlaceholder()
    }
    
    // MARK: - Setup navigation bar
    
    /// Метод настройки navigation bar
    func setupNavigationBar() {
        titleSetup()
        addBarButtons()
        addSearchController()
    }
    
    /// Метод для настройки заголовка navigation bar
    func titleSetup() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Заметки"
    }
    
    /// Добавление кнопок в navigation bar
    func addBarButtons() {
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewNote)
        )
        navigationItem.rightBarButtonItems = [addButton]
    }
    /// Добавление нового лекарства
    @objc func addNewNote() {
        presenter?.routeToNote(with: nil)
//        presenter?.updatePlaceholder()
    }
    
    func addSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Введите название заметки"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        
        searchController.searchBar.delegate = self
    }
    
    // MARK: - Setup table view
    
    /// Метод настройки таблицы
    func setupTableView() {
        noteListTableView.delegate = dataSourceProvider
        noteListTableView.dataSource = dataSourceProvider
        
        noteListTableView.separatorStyle = .none
        noteListTableView.backgroundColor = .systemGray6
        
        fetchedResultManager?.tableView = noteListTableView
        
        registerCell()
    }
    
    /// Регистрация ячейки
    func registerCell() {
        // Регистрируем ячейку для таблицы аптечек
        noteListTableView.register(
            NoteListCell.self,
            forCellReuseIdentifier: NoteListCell.identifier
        )
    }
    
    // MARK: - Setup placeholders
    
    func setupPlaceholder() {
//        placeholderLabel.textColor = .systemGray
    }
}

// MARK: - UISearchBarDelegate

extension NoteListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let notesFilter = NSPredicate(
            format: "title CONTAINS[c] %@", searchText
        )
        
        fetchedResultManager?.fetchedResultsController
            .fetchRequest.predicate = notesFilter
        
        do {
            try fetchedResultManager?.fetchedResultsController.performFetch()
        } catch let error {
            ConsoleLogger.error(error.localizedDescription)
        }
        
        noteListTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        fetchedResultManager?.fetchedResultsController
            .fetchRequest.predicate = nil
        
        do {
            try fetchedResultManager?.fetchedResultsController.performFetch()
        } catch let error {
            ConsoleLogger.error(error.localizedDescription)
        }
        
        noteListTableView.reloadData()
    }
}

// MARK: - Логика обновления данных View

extension NoteListViewController: NoteListDisplayLogic {
    
}
