//
//  CategoryTableViewCell.swift
//  Flashcards
//
//  Created by Lionel Maquet on 26/08/2020.
//  Copyright © 2020 Lionel Maquet. All rights reserved.
//

import UIKit
import RealmSwift

protocol CategoryCellDelegate {
    func categoryWasDeleted()
}

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var mainStack: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lastVisitedLabel: UILabel!
    @IBOutlet weak var numberOfCardsLabel: UILabel!
    
    var delegate : CategoryCellDelegate?
    
    let realm = try! Realm()
    
    
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
        titleLabel.textColor = .brown
        
        borderView.layer.borderWidth = 2
        borderView.layer.borderColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1).cgColor
        borderView.layer.cornerRadius = 35
    }

    @IBAction func deleteCategoryButtonPressed(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Delete this category", message: "Are you sure you want to delete this deck?", preferredStyle: .alert)
        let okaction = UIAlertAction(title: "delete", style: .default) { (completion) in
            do {
                try self.realm.write {
                    self.realm.delete(self.category!)
                }
            } catch {
                print(error)
            }
            
            self.delegate?.categoryWasDeleted()
        }
        
        let cancelAction = UIAlertAction(title: "cancel", style: .default) { (completion) in
            // do nothing
        }
        
        
        alert.addAction(okaction)
        alert.addAction(cancelAction)
        (self.delegate as! CategoryTableViewController).present(alert, animated: true)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}


