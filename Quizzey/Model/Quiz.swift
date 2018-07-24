//
//  Quiz.swift
//  Quizzey
//
//  Created by Ashwani  Agrawal on 22/07/18.
//  Copyright © 2018 Ashwani  Agrawal. All rights reserved.
//

import Foundation
import RealmSwift

class Quiz : Object {
    @objc dynamic var name = ""
    var questions = List<Question>()
}
