//
//  ViewController.swift
//  Minder
//
//  Created by Nikki Ivie on 11/5/18.
//  Copyright © 2018 Haptic Technologies, LLC. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController, UITextFieldDelegate {
    
    var goal: Goal?

    @IBOutlet weak var goalText: UITextField!
    @IBOutlet weak var goalProgress: UITextField!
    @IBOutlet weak var goalIsComplete: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        goalText.delegate = self
        goalProgress.delegate = self
        goalIsComplete.delegate = self
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = goalText.text ?? ""
        let progress = goalProgress.text
        let complete = goalIsComplete.text
        
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        //goalName: String, percentCompelete: String?, goalComplete: String
        goal = Goal(goalName: name, percentComplete: progress, goalComplete: complete ?? "0")
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        //Hide the keyboard
        goalText.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        
    }

}

