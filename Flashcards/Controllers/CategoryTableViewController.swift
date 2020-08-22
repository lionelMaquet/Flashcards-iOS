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

    @IBAction func addCategoryButtonPressed(_ sender: UIBarButtonItem) {
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
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
    
    //MARK: - Data Functions
    
    func loadCategories(){
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do {
            categories = try context.fetch(request)
        } catch {
            print(error)
        }
        tableView.reloadData()
    }
    
    func saveCategories(){
        
    }

    
}
