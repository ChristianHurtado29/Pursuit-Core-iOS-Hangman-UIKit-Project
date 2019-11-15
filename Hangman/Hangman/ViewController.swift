//
//  ViewController.swift
//  Hangman
//
//  Created by Alex Paul on 11/19/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var hangmanView: UIView!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var textfieldLabel: UILabel!
    
    var turnPlay = 0
    
    var status:GameStatus = .hint
    
  override func viewDidLoad() {
    super.viewDidLoad()
    myTextField.delegate = self
    hintLabel.text = ""
    headingLabel.text = "Player 1's turn"
    textfieldLabel.text = "Enter hint: "
    
    //let textField = UITextField()
    //textField.isSecureTextEntry = true // secure text
  }
    
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        switch status {
        case .hint:
            hintLabel.text = "Hint: \(myTextField.text ?? "")"
            myTextField.text = ""
            status = .word
            textfieldLabel.text = "Enter word:"
            textField.isSecureTextEntry = true
        case .word:
            textfieldLabel.text = "Guess letter"
            textField.isSecureTextEntry = false
            status = .game
            
        case .game:
            
            print("game")
        }
        myTextField.text = ""
        return true
    }



}

