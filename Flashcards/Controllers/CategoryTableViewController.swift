//
//  CategoryTableViewController.swift
//  Flashcards
//
//  Created by Lionel Maquet on 22/08/2020.
//  Copyright © 2020 Lionel Maquet. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController, UISearchBarDelegate {
    
    let realm = try! Realm()
    var categories : Results<Category>?
    override func viewDidLoad() {
        tableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "categoryCell")
        //self.tableView.rowHeight = 80.0
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
                let newCategory = Category()
                newCategory.name = textfield.text!
                newCategory.lastVisited = Date()
                
                do {
                    try self.realm.write {
                        self.realm.add(newCategory)
                    }
                } catch {
                    print(error)
                }
                self.tableView.reloadData()
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
        self.categories = self.categories!.filter(predicate)
        self.tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            loadCategories()
            DispatchQueue.main.async {
               searchBar.resignFirstResponder()
            }
            self.tableView.reloadData()
            
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as! CategoryTableViewCell
        let category = categories![indexPath.row]
        cell.category = category
        return cell
    }
    
    
    //MARK: - Did select row
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        categories![indexPath.row].lastVisited = Date()
        performSegue(withIdentifier: "goToFlashcards", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! FlashcardsViewController
        destinationVC.selectedCategory = categories![tableView.indexPathForSelectedRow!.row]
    }
    
    //MARK: - Data Functions
    
    func loadCategories(){
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    func saveCategories(){
    }

    
}
