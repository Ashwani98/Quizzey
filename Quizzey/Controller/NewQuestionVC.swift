//
//  NewQuestionVC.swift
//  Quizzey
//
//  Created by Ashwani  Agrawal on 22/07/18.
//  Copyright © 2018 Ashwani  Agrawal. All rights reserved.
//

import UIKit
import RealmSwift

class NewQuestionVC: UIViewController {
    
    let quiz = Quiz()
    let realm = try! Realm()
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionText: UITextView!
    
    @IBOutlet var options: [UITextField]!
    
    @IBAction func answer(_ sender: UISegmentedControl) {
        answerIndex = sender.selectedSegmentIndex
    }
    
    
    @IBAction func questionSaved(_ sender: UIButton!) {
        
        let ques = Question()
        ques.identifier = questionNumber
        ques.text = questionText.text
        ques.answer = answerIndex
        ques.choices = getChoices()
//        ques.answer = answerIndex
        
//        print(ques.identifier)
//        print(ques.text)
//        for index in 0...3{
//            print(ques.choices[index])
//        }
//        print(ques.answer)
        
        
        
        quiz.questions.append(ques)
        questionNumber += 1
        clearFields(with: questionNumber)
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        clearFields(with: questionNumber)
    }
    
    var questionNumber = 1
    var answerIndex = 0
    
 
    @IBAction func saveQuiz(_ sender: UIBarButtonItem) {
        try! realm.write {
            realm.add(quiz)
        }
      //  self.dismiss(animated: true, completion: nil)
//        //navigationController?.dismiss(animated: true, completion: nil)
//        self.navigationController?.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = quiz.name
        questionLabel.text = "Question " + String(questionNumber)
    }
    
    
    func clearFields(with questionNumber: Int){
        questionText.text = nil
        for index in options.indices{
            options[index].text = nil
        }
        viewDidLoad()

    }
    
    func getChoices() -> List<Choice> {
        let choices = List<Choice>()
        
        for index in 0...3{
            let choice = Choice()
            choice.choice  = options[index].text!
            if index == answerIndex{
                choice.correctChoice = true
            }
            choices.append(choice)
        }
        
        
        return choices
    }
    
    
    

}
