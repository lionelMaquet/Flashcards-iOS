//
//  CategoryTableViewCell.swift
//  Flashcards
//
//  Created by Lionel Maquet on 26/08/2020.
//  Copyright © 2020 Lionel Maquet. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lastVisitedLabel: UILabel!
    @IBOutlet weak var numberOfCardsLabel: UILabel!
    
    var category: Category? {
        didSet {
            let lastVisitDate = category!.lastVisited
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            
            titleLabel.text = category?.name
            lastVisitedLabel.text = "Last checked : \(formatter.string(from: lastVisitDate!))"
            numberOfCardsLabel.text = "Flashcards : \(category?.flashcards.count ?? 0)"
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func deleteCategoryButtonPressed(_ sender: UIButton) {
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
