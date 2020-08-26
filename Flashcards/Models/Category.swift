//
//  Category.swift
//  Flashcards
//
//  Created by Lionel Maquet on 26/08/2020.
//  Copyright © 2020 Lionel Maquet. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var lastVisited: Date?
    // forward category
    let flashcards = List<Flashcard>() // container type specific to Realm
}
