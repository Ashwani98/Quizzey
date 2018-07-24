//
//  SelectQuizTVC.swift
//  Quizzey
//
//  Created by Ashwani  Agrawal on 24/07/18.
//  Copyright © 2018 Ashwani  Agrawal. All rights reserved.
//

import UIKit
import RealmSwift
class SelectQuizTVC: UITableViewController {

    var quiz: Results<Quiz>?
    let realm = try! Realm()
    
    func getData(){
        quiz = realm.objects(Quiz.self)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        tableView.separatorStyle = .none
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quiz?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell", for: indexPath)
        cell.textLabel?.text = quiz?[indexPath.row].name ?? "no quizzes"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Show Questions", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? QuizTaken
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC?.selectedQuiz = quiz?[indexPath.row]
        }
    }

}
