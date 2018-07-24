//
//  Choice.swift
//  Quizzey
//
//  Created by Ashwani  Agrawal on 24/07/18.
//  Copyright © 2018 Ashwani  Agrawal. All rights reserved.
//

import Foundation
import RealmSwift

class Choice: Object {
    
    @objc dynamic var choice = ""
    @objc dynamic var correctChoice = false
    var parentQuestion = LinkingObjects(fromType: Question.self, property: "choices")
    
}
