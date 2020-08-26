//
//  Flashcard.swift
//  Flashcards
//
//  Created by Lionel Maquet on 26/08/2020.
//  Copyright © 2020 Lionel Maquet. All rights reserved.
//

import Foundation
import RealmSwift

class Flashcard: Object {
    @objc dynamic var question: String = ""
    @objc dynamic var response: String = ""
    @objc dynamic var dateCreated: Date?
    // reverse category, coming from the property items of the category
    var parentCategory = LinkingObjects(fromType: Category.self, property: "flashcards")
}
