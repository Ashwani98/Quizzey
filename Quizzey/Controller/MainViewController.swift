//
//  ViewController.swift
//  Quizzey
//
//  Created by Ashwani  Agrawal on 14/07/18.
//  Copyright © 2018 Ashwani  Agrawal. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var quizName = ""
    
    
    @IBAction func makeAQuiz(_ sender: UIButton) {
        
        var quizTextField = UITextField()
        
        let alert = UIAlertController(title: "Name",
                                      message: "Enter the title name for your Quiz",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Submit", style: .default) {
            (action) in
            if quizTextField.text != ""{
                self.quizName = quizTextField.text!
                self.performSegue(withIdentifier: "Make A Quiz", sender: sender)
            }
            else{
                self.generateAlert()
            }
            
        }
        alert.addTextField { (textField) in
            quizTextField = textField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func generateAlert(){
        let alert = UIAlertController(title: "Error", message: "Quiz name cant be nil", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Got It!", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if let destinationVC = segue.destination as? NewQuestionVC{
            destinationVC.quiz.name = quizName
        }
        if let destinationVC = segue.destination as? SelectQuizTVC{
            
        }
    }

}

