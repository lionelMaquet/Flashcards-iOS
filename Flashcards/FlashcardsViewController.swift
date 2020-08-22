//
//  FlashcardsViewController.swift
//  Flashcards
//
//  Created by Lionel Maquet on 22/08/2020.
//  Copyright © 2020 Lionel Maquet. All rights reserved.
//

import UIKit

class FlashcardsViewController: UIViewController {
    
    @IBOutlet weak var btn: UIButton!
    
    var selectedCategory: Category? {
        didSet {
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addFlashcardButtonPressed(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        UIView.transition(with: btn, duration: 0.2, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }
    
}
