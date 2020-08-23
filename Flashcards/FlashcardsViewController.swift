//
//  FlashcardsViewController.swift
//  Flashcards
//
//  Created by Lionel Maquet on 22/08/2020.
//  Copyright © 2020 Lionel Maquet. All rights reserved.
//

import UIKit
import CoreData

class FlashcardsViewController: UIViewController {
    
    @IBOutlet weak var btn: UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var selectedCategory: Category? {
        didSet {
            loadFlashcards()
        }
    }
    
    var flashcards = [Flashcard]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadFlashcards()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addFlashcardButtonPressed(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        UIView.transition(with: btn, duration: 0.2, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }
    
    func loadFlashcards(){
        let request: NSFetchRequest<Flashcard> = Flashcard.fetchRequest()
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", self.selectedCategory?.name! as! CVarArg)
        request.predicate = categoryPredicate
        
        do {
            self.flashcards = try context.fetch(request)
            print(flashcards)
        } catch {
            print(error)
        }
        
        
    }
    
}
