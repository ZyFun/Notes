//
//  NoteListCell.swift
//  Notes
//
//  Created by Дмитрий Данилин on 22.12.2022.
//

import UIKit

final class NoteListCell: UITableViewCell {
    
    // MARK: - Public properties
    
    static let identifier = String(describing: NoteListCell.self)
    
    // MARK: - Private properties
    
    /// Кастомный контейнер
    /// - В нем содержаться все элементы заметки
    /// - нужен для того, чтобы сделать его в виде карточки
    private let viewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        
        contentView.addSubview(viewContainer)
        viewContainer.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            viewContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            viewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            viewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            viewContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            titleLabel.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Publik Methods

extension NoteListCell {
    func configure(titleLabel: String?) {
        self.titleLabel.text = titleLabel
    }
}

// MARK: - Конфигурирование ячейки

private extension NoteListCell {
    /// Метод инициализации настроек ячейки
    func setup() {
        setupUI()
    }
    
    /// Метод для настройки отображения элементов
    func setupUI() {
        selectionStyle = .none
        contentView.backgroundColor = .clear
        backgroundColor = .clear
    }
}
