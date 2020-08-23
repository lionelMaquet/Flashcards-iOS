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
        
        var questTF = UITextField()
        var ansTF = UITextField()
        
        let alert = UIAlertController(title: "Add Flashcard", message: "", preferredStyle: .alert)
        alert.addTextField { (questionTF) in
            questionTF.placeholder = "Question"
            questTF = questionTF
            
        }
        
        alert.addTextField { (answerTF) in
            answerTF.placeholder = "Answer"
            ansTF = answerTF
        }
        
        let action = UIAlertAction(title: "Add to this category", style: .default) { (completion) in
            let newFlashcard = Flashcard(context: self.context)
            newFlashcard.parentCategory = self.selectedCategory
            newFlashcard.question = questTF.text
            newFlashcard.response = ansTF.text
            self.flashcards.append(newFlashcard)
            self.saveFlashcards()
        }
        alert.addAction(action)
        
        present(alert, animated: true)
        
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
        } catch {
            print(error)
        }
        
        
    }
    
    func saveFlashcards(){
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
}
