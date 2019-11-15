//
//  ViewController.swift
//  Hangman
//
//  Created by Alex Paul on 11/19/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate  {

    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var myTextField: UITextField!

    
    @IBOutlet weak var turnsLeftLabel: UILabel!
    
    
    @IBOutlet weak var hangmanView: UIImageView!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var textfieldLabel: UILabel!
    
    @IBOutlet weak var privateWordSpaces: UILabel!
    
    
    
    var turnPlay = 6
    
    
    var randomWord = ""
    var guess: String = ""
    var status:GameStatus = .hint
    var randomWordString = ""
    
    var wordArray = [String]()
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    myTextField.delegate = self
    hintLabel.text = ""
    headingLabel.text = "Player 1's turn"
    textfieldLabel.text = "Enter hint: "
    
    //let textField = UITextField()
    //textField.isSecureTextEntry = true // secure text
  }
    // this limits player to input one letter at the time
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if status == GameStatus.game {
        let strCount = string.count
        let textCount = textField.text?.count ?? 0
        if strCount + textCount > 1 {
            return false
        }
        return true
        }
        return true
    }
    // first thing thats happening in the game
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        switch status {
        case .hint:
            hintLabel.text = "Hint: \(myTextField.text ?? "")"
            myTextField.text = ""
            status = .word
            textfieldLabel.text = "Enter word:"
            textField.isSecureTextEntry = true
            randomWord = textField.text ?? ""
            
          // player one is putting in the word that player two is guessing
        case .word:
            textField.backgroundColor = .green
            headingLabel.text = "Player 2's turn"
            textfieldLabel.text = "Guess letter:"
            textField.isSecureTextEntry = false
            status = .game
            randomWord = textField.text ?? ""
            randomWordString = textField.text ?? ""
            print(randomWord)
            let randomWordCount = textField.text?.count
            wordArray = [String](repeating: "_ ", count: randomWordCount ?? 1)
            print(wordArray)
            privateWordSpaces.text = wordArray.joined(separator: "")
            turnsLeftLabel.text = "Turns left: \(turnPlay)"
            hangmanView.image = #imageLiteral(resourceName: "mufasa happy")
            
        case .game:
            guess = textField.text ?? ""
            if randomWord.contains(guess){
                // is comparing and checking if the guess letter is in the word
                for (index, character) in randomWord.enumerated() {
                if character == Character(guess){
                    wordArray[index] = String(character)
                    privateWordSpaces.text = wordArray.joined(separator: "")
                    //.joined all the underspaced
                    //separator , separates them by space
                }
                }
        }  else {
            turnPlay -= 1
            print(turnPlay)
            turnsLeftLabel.text = "Turns left: \(turnPlay)"
                if turnPlay > 2 {
                    textField.backgroundColor = .yellow
                }
                if turnPlay <= 2{
                    textField.backgroundColor = .red
                }
                
                if turnPlay == 6{hangmanView.image = #imageLiteral(resourceName: "mufasa happy")
                }
                if turnPlay == 5{hangmanView.image = #imageLiteral(resourceName: "scarlook")
                }
                if turnPlay == 4{hangmanView.image = #imageLiteral(resourceName: "zazu look")
                }
                if turnPlay == 3{hangmanView.image = #imageLiteral(resourceName: "mufasa scared")
                }
                if turnPlay == 2{hangmanView.image = #imageLiteral(resourceName: "mufasa hanging")
                }
                if turnPlay == 1{hangmanView.image = #imageLiteral(resourceName: "mufasa near death")
                }
                if turnPlay == 0{hangmanView.image = #imageLiteral(resourceName: "mufasa game over")
                }
    }
            print(wordArray)
            print(guess)
            print("game")
        }
        myTextField.text = ""
        return true
    }



}

