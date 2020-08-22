//
//  CategoryTableViewController.swift
//  Flashcards
//
//  Created by Lionel Maquet on 22/08/2020.
//  Copyright © 2020 Lionel Maquet. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController, UISearchBarDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categories = [Category]()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        loadCategories()
    }
    
    //MARK: - Add Category

    @IBAction func addCategoryButtonPressed(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add category", style: .default) { (UIAlertAction) in
            if !textfield.text!.isEmpty {
                let newCategory = Category(context: self.context)
                newCategory.name = textfield.text
                self.categories.append(newCategory)
                self.saveCategories()
            }
        }
        
        alert.addAction(action)
        
        alert.addTextField { (tf) in
            tf.placeholder = "category name"
            textfield = tf
        }
        present(alert, animated : true)
    }
    
    //MARK: - Search bar methods
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchText = searchBar.text
        let predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchText as! CVarArg)
        loadCategories(predicate: predicate)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            loadCategories()
            DispatchQueue.main.async {
               searchBar.resignFirstResponder()
            }
            
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell")
        let category = categories[indexPath.row]
        cell?.textLabel!.text = category.name!
        return cell!
    }
    
    
    //MARK: - Did select row
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToFlashcards", sender: self)
    }
    
    //MARK: - Data Functions
    
    func loadCategories(with request : NSFetchRequest<Category> = Category.fetchRequest(), predicate: NSPredicate? = nil){
        
        if let predicate = predicate {
            request.predicate = predicate
        }
        
        do {
            categories = try context.fetch(request)
        } catch {
            print(error)
        }
        tableView.reloadData()
    }
    
    func saveCategories(){
        do {
            try context.save()
        } catch {
         print(error)
        }
        tableView.reloadData()
    }

    
}
