//
//  ViewController.swift
//  Project2
//
//  Created by Nikita on 20.01.23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var counterOfQuestion = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
//        button1.layer.borderColor = UIColor.cyan.cgColor
//        button2.layer.borderColor = UIColor.cyan.cgColor
//        button3.layer.borderColor = UIColor.cyan.cgColor

        askQuestion()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showScore))
    }

    @objc func showScore() {
        let ac = UIAlertController(title: "\(counterOfQuestion) question were asked", message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = Int.random(in: 0...2)
        title = countries[correctAnswer].uppercased()
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        
        var title: String
        var message: String
        counterOfQuestion += 1
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong! Thats flag of \(countries[sender.tag].uppercased())"
            score -= 1
        }
        
       

        if counterOfQuestion % 3 == 0 {
            message = "Your score is \(score), make a subsequent decision"
            title = "Game over"
        } else {
            message = "Your score is \(score)"
        }
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))

        let refreshAction = UIAlertAction(title: "Restart", style: .default, handler: refresh)
        if counterOfQuestion % 10 == 0 {
            ac.addAction(refreshAction)
        }
        present(ac, animated: true)
        
    }

    func refresh(action: UIAlertAction!) {
        counterOfQuestion = 0
        correctAnswer = 0
        askQuestion()
    }
    
}

