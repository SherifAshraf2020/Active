//
//  SectionHeaderView.swift
//  Active
//
//  Created by Yomna on 13/05/2026.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {

    static let identifier = "SectionHeaderView"

    let titleLabel: UILabel = {

        let label = UILabel()

        label.font = .systemFont(
            ofSize: 24,
            weight: .bold
        )

        label.textColor = .label

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(titleLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            titleLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),

            titleLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16
            ),

            titleLabel.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -8
            )
        ])
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}
