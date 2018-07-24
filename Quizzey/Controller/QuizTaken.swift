//
//  QuizTaken.swift
//  Quizzey
//
//  Created by Ashwani  Agrawal on 24/07/18.
//  Copyright © 2018 Ashwani  Agrawal. All rights reserved.
//

import UIKit

class QuizTaken: UIViewController {

    var selectedQuiz: Quiz?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = selectedQuiz?.name
        
    }


}
