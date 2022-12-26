//
//  CoreDataService.swift
//  Notes
//
//  Created by Дмитрий Данилин on 22.12.2022.
//

import Foundation

import CoreData

/// Протокол для работы с базой данных
protocol ICoreDataService {
    func performSave(_ block: @escaping (NSManagedObjectContext) -> Void)
    func fetchResultController(
        entityName: String,
        keyForSort: String,
        sortAscending: Bool
    ) -> NSFetchedResultsController<NSFetchRequestResult>
    func create(_ note: NoteModel, context: NSManagedObjectContext)
    func update(_ currentNote: DBNote, newData: NoteModel, context: NSManagedObjectContext)
    func delete(_ currentObject: NSManagedObject, context: NSManagedObjectContext)
}
 
final class CoreDataService {
    
    static let shared = CoreDataService()
    
    // MARK: - Core Data stack
    
    private lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Notes")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                ConsoleLogger.error("\(error)")
            } else {
                ConsoleLogger.info("\(storeDescription)")
            }
        }
        return container
    }()
    
    private lazy var readContext: NSManagedObjectContext = {
        let context = container.viewContext
        context.automaticallyMergesChangesFromParent = true
        return context
    }()
    
    private lazy var writeContext: NSManagedObjectContext = {
        let context = container.newBackgroundContext()
        context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        return context
    }()
    
    private init() {}
}

// MARK: - CRUD

extension CoreDataService: ICoreDataService {
    
    func fetchResultController(
        entityName: String,
        keyForSort: String,
        sortAscending: Bool
    ) -> NSFetchedResultsController<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let descriptorDateLastActivity = NSSortDescriptor(key: keyForSort, ascending: sortAscending)
        
        fetchRequest.sortDescriptors = [descriptorDateLastActivity]
        fetchRequest.fetchBatchSize = 15
        
        let fetchResultController = NSFetchedResultsController<NSFetchRequestResult>(
            fetchRequest: fetchRequest,
            managedObjectContext: readContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        do {
            try fetchResultController.performFetch()
        } catch {
            ConsoleLogger.error(error.localizedDescription)
        }
        
        return fetchResultController
    }
    
    func create(_ note: NoteModel, context: NSManagedObjectContext) {
        let dbNote = DBNote(context: context)
        dbNote.title = note.title
        dbNote.note = note.note
        
        ConsoleLogger.info("Запуск сохранения \(dbNote.title ?? "no title")")
    }
    
    func update(_ currentNote: DBNote, newData: NoteModel, context: NSManagedObjectContext) {
        let objectID = currentNote.objectID
        guard let currentObject = context.object(with: objectID) as? DBNote else {
            ConsoleLogger.error("Не удалось скастить объект до DBNote")
            return
        }
        
        currentObject.title = newData.title
        currentObject.note = newData.note
        
        ConsoleLogger.info("Запуск изменения объекта \(currentNote.title ?? "no name")")
    }
    
    func delete(
        _ currentObject: NSManagedObject,
        context: NSManagedObjectContext
    ) {
        let objectID = currentObject.objectID
        let currentObject = context.object(with: objectID)
        context.delete(currentObject)

        ConsoleLogger.info("Запуск удаления объекта из базы")
    }
    
    // MARK: - Save context
    
    func performSave(_ block: @escaping (NSManagedObjectContext) -> Void) {
        let context = writeContext
        context.perform { [weak self] in
            block(context)
            ConsoleLogger.info(
                "Проверка контекста на изменение"
            )
            if context.hasChanges {
                ConsoleLogger.info(
                    "Данные изменены, попытка сохранения"
                )
                do {
                    try self?.performSave(in: context)
                } catch {
                    ConsoleLogger.error(error.localizedDescription)
                }
            } else {
                ConsoleLogger.info(
                    "Изменений нет"
                )
            }
            
            ConsoleLogger.info(
                "Проверка контекста на изменение закончена"
            )
        }
    }
    
    private func performSave(in context: NSManagedObjectContext) throws {
        try context.save()
        ConsoleLogger.info(
            "Данные сохранены"
        )
    }
}
