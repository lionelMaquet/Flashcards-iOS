//
//  FlashcardsViewController.swift
//  Flashcards
//
//  Created by Lionel Maquet on 22/08/2020.
//  Copyright © 2020 Lionel Maquet. All rights reserved.
//

import UIKit
import RealmSwift

class FlashcardsViewController: UIViewController {
    
    let realm = try! Realm()
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var qoraLabel: UILabel!
    @IBOutlet weak var flashcardLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    
    //MARK: - Variables
    
    var selectedCategory: Category? {
        didSet {
            loadFlashcards()
        }
    }
    
    var flashcards : Results<Flashcard>?
    var currentPosition: Int = 0
    var shouldDisplayQuestion: Bool = true
    
    var currentQuestion: String {
        if (flashcards!.count > 0){
            return flashcards![currentPosition].question
        } else {
            return "There is currently no flashcard in this deck !"
        }
        
    }
    
    var currentAnswer: String {
        if (flashcards!.count > 0){
            return flashcards![currentPosition].response
        } else {
            return "There is currently no flashcard in this deck !"
        }
        
    }
    
    var textForPositionLabel: String {
        if (flashcards!.count == 0){
            return "0/0"
        }
        
        return "\(currentPosition + 1) / \(flashcards!.count)"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadFlashcards()
        updateFlashcardUI()
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeLeftGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRightGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let touch = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        self.view.addGestureRecognizer(touch)
    }
    
    @objc func handleTapGesture(){
        shouldDisplayQuestion = !shouldDisplayQuestion
        
        if (self.shouldDisplayQuestion){
            self.flashcardLabel.text = self.currentQuestion
        } else {
            self.flashcardLabel.text = self.currentAnswer
        }
        self.updateFlashcardUI()
    }
    
    @objc func handleSwipeLeftGesture(){
        if(currentPosition < flashcards!.count - 1){
            shouldDisplayQuestion = true
            currentPosition += 1
            updateFlashcardUI()
        }
    }
    
    @objc func handleSwipeRightGesture(){
        if(currentPosition > 0){
            shouldDisplayQuestion = true
            currentPosition -= 1
            updateFlashcardUI()
        }
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
            let newFlashcard = Flashcard()
            newFlashcard.question = questTF.text!
            newFlashcard.response = ansTF.text!
            newFlashcard.dateCreated = Date()
            
            do {
                try self.realm.write {
                    self.selectedCategory?.flashcards.append(newFlashcard)
                }
            } catch {
                print(error)
            }
            
            
            self.updateFlashcardUI()
        }
        alert.addAction(action)
        
        present(alert, animated: true)
        
    }
    
    
    //MARK: - Data Methods
    
    func loadFlashcards(){
        self.flashcards = selectedCategory!.flashcards.sorted(byKeyPath: "dateCreated", ascending: true)
    }
    
    
    //MARK: - Flashcard functions
    
    
    func updateFlashcardUI(){
        if (shouldDisplayQuestion){
            qoraLabel.text = "Question"
            flashcardLabel.text = self.currentQuestion
        } else {
            qoraLabel.text = "Answer"
            flashcardLabel.text = self.currentAnswer
        }
        positionLabel.text = self.textForPositionLabel
    }
}
