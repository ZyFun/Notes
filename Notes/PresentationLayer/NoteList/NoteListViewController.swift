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
    
    // MARK: - Outlets
    
    @IBOutlet weak var noteListTableView: UITableView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension NoteListViewController: NoteListDisplayLogic {
    
}
