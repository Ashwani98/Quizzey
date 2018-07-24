//
//  Question.swift
//  Quizzey
//
//  Created by Ashwani  Agrawal on 22/07/18.
//  Copyright © 2018 Ashwani  Agrawal. All rights reserved.
//

import Foundation
import RealmSwift

class Question: Object {
    @objc dynamic var identifier = 0
    @objc dynamic var text = ""
    var choices = List<Choice>()
    @objc dynamic var answer = 0
    var parentQuiz = LinkingObjects(fromType: Quiz.self, property: "questions")
}
