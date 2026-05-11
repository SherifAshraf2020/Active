//
//  MatchCell.swift
//  Active
//
//  Created by Sherif Ashraf Farooq  on 11/05/2026.
//

import UIKit

class MatchCell: UITableViewCell {
    
    private let matchLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }

    private func setupUI() {
        contentView.addSubview(matchLabel)
        NSLayoutConstraint.activate([
            matchLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            matchLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            matchLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            matchLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
    
    func configure(with text: String) {
        matchLabel.text = text
    }
}
