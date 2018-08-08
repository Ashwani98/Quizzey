//
//  SelectQuizTVC.swift
//  Quizzey
//
//  Created by Ashwani  Agrawal on 24/07/18.
//  Copyright © 2018 Ashwani  Agrawal. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase
import SwiftyJSON

class SelectQuizTVC: UITableViewController {

//    var quiz: Results<Quiz>?
    
    var quizName = [String]()
    var quizDetails = [String:Any]()
    var arrayDetails = [[String:Any]]()
    
    
    let quizDB = Database.database().reference().child("QuizData")
    let realm = try! Realm()
    
    func getData(){
//        quiz = realm.objects(Quiz.self)
        
        
  

//        quizDB.observeSingleEvent(of: .value, with: { (snapshot) in
//
//            let snap = snapshot.value as! Dictionary<String,Any>
//
//            let quizN = snap["name"] as! String
//            self.quizName.append(quizN)
//            print(quizN)
//            print(self.quizName)
//        })
        
        quizDB.observe(.childAdded) { (snapshot) in
            let snap = snapshot.value as! Dictionary<String,Any>

            let quizN = snap["name"] as! String
            let arrayDetail = snap["details"] as! Dictionary<String,Any>
            self.arrayDetails.append(arrayDetail)
            self.quizName.append(quizN)
            self.tableView.reloadData()
        }
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        tableView.separatorStyle = .none
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return quiz?.count ?? 0
        return quizName.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell", for: indexPath)
//        cell.textLabel?.text = quiz?[indexPath.row].name ?? "no quizzes"
        cell.textLabel?.text = quizName[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Show Questions", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? QuizTaken
        if let indexPath = tableView.indexPathForSelectedRow{
//            destinationVC?.selectedQuiz = quiz?[indexPath.row]
            
//            quizDB.child
            destinationVC?.quizTitle = quizName[indexPath.row]
            destinationVC?.quiz = arrayDetails[indexPath.row]

        }
    }

}
