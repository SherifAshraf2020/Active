//
//  MatchCell.swift
//  Active
//
//  Created by Sherif Ashraf Farooq  on 11/05/2026.
//

import UIKit

class MatchCell: UITableViewCell {
    
    @IBOutlet weak var matchLabel: UILabel!

    func configure(with text: String) {
        matchLabel.text = text
    }
}
