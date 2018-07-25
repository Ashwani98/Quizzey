//
//  QuizTaken.swift
//  Quizzey
//
//  Created by Ashwani  Agrawal on 24/07/18.
//  Copyright © 2018 Ashwani  Agrawal. All rights reserved.
//

import UIKit

class QuizTaken: UIViewController {
    
    //var quiz = Quiz()
    var selectedQuiz: Quiz?
    var questionNumber = 0
    var correctAnswer = 0
    var totalQuestons: Int { return (selectedQuiz?.questions.count)! }
    var score = 0
    
    
    @IBOutlet weak var scoreText: UITextView!
    
    @IBOutlet weak var questionText: UITextView!
    
    @IBOutlet weak var scoreView: UIImageView!
    
    @IBOutlet weak var scoreButton: UIButton!
    @IBAction func scoreButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBOutlet var options: [UIButton]!
    
    @IBAction func optionSelected(_ sender: UIButton) {
        
        if correctAnswer == options.index(of: sender)!{
            sender.backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
            score += 1
            let alert = UIAlertController(title: "Correct", message: "Lets face another question", preferredStyle: .alert)
            let action = UIAlertAction(title: "Bring It On!", style: .default, handler: {
                (action) in
                self.nextQuestion()
            })
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
            
        }
        else{
            sender.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            let alert = UIAlertController(title: "Wrong", message: "Better luck next time", preferredStyle: .alert)
            let action = UIAlertAction(title: "Next", style: .default, handler: {
                (action) in
                self.nextQuestion()
            })
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
        }
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreView.isHidden = true
        scoreButton.isHidden = true
        scoreText.isHidden = true
        navigationItem.title = selectedQuiz?.name
        questionText.text = selectedQuiz?.questions[questionNumber].text
//        questionNumber = (selectedQuiz?.questions.startIndex)!
        correctAnswer = (selectedQuiz?.questions[questionNumber].answer)!
        
        setOptions()
        
    }
    
    func setOptions(){
        for index in 0...3{
            options[index].setTitle(selectedQuiz?.questions[questionNumber].choices[index].choice, for: .normal)
            options[index].backgroundColor = UIColor.lightGray
        }
    }
    
    
    func nextQuestion(){
        questionNumber += 1
        if questionNumber < totalQuestons{
            viewDidLoad()
        }
        else{
            showScore()
        }
        
    }
    
    func showScore(){
        scoreView.isHidden = false
        for index in 0...3{
            options[index].isHidden = true
        }
        //scoreButton.isHidden = false
        scoreText.isHidden = false
        scoreText.text = "\(score) / \(totalQuestons)"
        if score >= Int(totalQuestons/2){
            won()
        }
        else{
            lose()
        }
        
    }
    
    func won(){
        //scoreView.backgroundColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)
        scoreView.image = UIImage(named: "success")
        scoreButton.titleLabel?.text = "You won"
        scoreButton.backgroundColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
        scoreButton.tintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        questionText.text = "YOU PASSED"
        questionText.font?.withSize(100.0)
        questionText.textAlignment = .center
        
        let alert = UIAlertController(title: "Congrats", message: "Brag about it", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Back", style: .default, handler: {
            (action) in
            self.navigationController?.popViewController(animated: true)
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func lose(){
       // scoreView.backgroundColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
        scoreView.image = UIImage(named: "Failure")
        scoreButton.titleLabel?.text = "You lost"
        scoreButton.backgroundColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
        scoreButton.tintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        questionText.text = "YOU FAILED"
        questionText.font?.withSize(80.0)
        questionText.textAlignment = .center
        
        let alert = UIAlertController(title: "Oops", message: "Wanna try another quiz?", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Back", style: .default, handler: {
            (action) in
            self.navigationController?.popViewController(animated: true)
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }


}
