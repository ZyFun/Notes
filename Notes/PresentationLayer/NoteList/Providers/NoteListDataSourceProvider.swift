//
//  NoteListDataSourceProvider.swift
//  Notes
//
//  Created by Дмитрий Данилин on 22.12.2022.
//

import UIKit

protocol INoteListDataSourceProvider: UITableViewDelegate, UITableViewDataSource {
    
    var fetchedResultManager: INoteListFetchedResultsManager { get set }
}

final class NoteListDataSourceProvider: NSObject, INoteListDataSourceProvider {
    
    // MARK: - Public Properties
    
    var fetchedResultManager: INoteListFetchedResultsManager
    
    // MARK: - Private properties
    
    private let presenter: NoteListPresenter?
    
    // MARK: - Initializer
    
    init(
        presenter: NoteListPresenter?,
        resultManager: INoteListFetchedResultsManager
    ) {
        self.presenter = presenter
        self.fetchedResultManager = resultManager
    }
    
    // MARK: - Private methods
    
    private func fetchNote(at indexPath: IndexPath) -> DBNote? {
        guard let note = fetchedResultManager.fetchedResultsController.object(
            at: indexPath
        ) as? DBNote else {
            ConsoleLogger.error("Ошибка каста object к DBNote")
            return nil
        }
        
        return note
    }
}

// MARK: - Table view data source

extension NoteListDataSourceProvider: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        if let sections = fetchedResultManager.fetchedResultsController.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: NoteListCell.identifier),
            for: indexPath
        ) as? NoteListCell else { return UITableViewCell() }
        
        guard let note = fetchNote(at: indexPath) else {
            return UITableViewCell()
        }
        
        cell.configure(titleLabel: note.title)
        
        return cell
    }
    
}

// MARK: - Table view delegate

extension NoteListDataSourceProvider: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        guard let currentNote = fetchNote(at: indexPath) else { return }
        presenter?.routeToNote(with: currentNote)
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        
        guard let currentNote = fetchNote(at: indexPath) else { return nil }
        
        let deleteAction = UIContextualAction(
            style: .normal,
            title: ""
        ) { [weak self] _, _, isDone in
//            self?.presenter?.delete(currentNote)
            
            isDone(true)
        }
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 15.0, weight: .medium, scale: .large)
        
        let deleteColor = #colorLiteral(red: 0.8729341626, green: 0.4694843888, blue: 0.5979845524, alpha: 1)
        deleteAction.backgroundColor = UIColor.systemGray6
        deleteAction.image = UIImage(
            systemName: "trash",
            withConfiguration: largeConfig
        )?.withTintColor(
            .white,
            renderingMode: .alwaysTemplate
        ).addBackgroundCircle(color: deleteColor, diameter: 35)
        
        let configuration = UISwipeActionsConfiguration(
            actions: [deleteAction]
        )
        configuration.performsFirstActionWithFullSwipe = false
        
        return configuration
    }
}
