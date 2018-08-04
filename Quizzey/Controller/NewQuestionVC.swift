//
//  NewQuestionVC.swift
//  Quizzey
//
//  Created by Ashwani  Agrawal on 22/07/18.
//  Copyright © 2018 Ashwani  Agrawal. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase
import SwiftyJSON

class NewQuestionVC: UIViewController {
    
    let quiz = Quiz()
    let realm = try! Realm()
    
    var values = [String:String]()
    var ques = [String:Any]()
    var quesDict = [String:Any]()
    var quizDict = [String:Any]()
    
    

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionText: UITextView!
    
    @IBOutlet var options: [UITextField]!
    
    @IBAction func answer(_ sender: UISegmentedControl) {
        answerIndex = sender.selectedSegmentIndex
    }
    
    
    @IBAction func questionSaved(_ sender: UIButton!) {
        
        saveQuestionOffline()
        
        ques = ["text" : "\(questionText.text!)" , "options" : values, "correct" : answerIndex]
        quesDict["\(questionNumber)"] = ques
        questionNumber += 1
        clearFields(with: questionNumber)
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        clearFields(with: questionNumber)
    }
    
    var questionNumber = 1
    var answerIndex = 0
    
 
    @IBAction func saveQuiz(_ sender: UIBarButtonItem) {
        
        saveOffline()
        saveOnline()
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = quiz.name
        questionLabel.text = "Question " + String(questionNumber)
    }

    
    
    func saveQuestionOffline(){
        let ques = Question()
        ques.identifier = questionNumber
        ques.text = questionText.text
        ques.answer = answerIndex
        ques.choices = getChoices()
        quiz.questions.append(ques)
    }
    
    
    
    func saveOffline(){
        try! realm.write {
            realm.add(quiz)
        }
    }
    
    
    func saveOnline(){
        
        
        let quizDB = Database.database().reference().child("QuizData")
        quizDict = ["\(quiz.name)" : quesDict]
        
        quizDB.childByAutoId().setValue(quizDict){
            (error,reference) in
            if error == nil{
                print("saved")
            }
            else{
                print(error!)
            }
        }

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
        
        var val = [String]()
        
        for index in 0...3{
            let choice = Choice()
            choice.choice  = options[index].text!
            if index == answerIndex{
                choice.correctChoice = true
            }
            choices.append(choice)
            val.append(choice.choice)
        }
        
        values = [ "1" : val[0], "2" : val[1], "3" : val[2], "4" : val[3]]
        return choices
    }
    
    
    

}
