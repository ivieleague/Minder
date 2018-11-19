//
//  TableViewController.swift
//  Minder
//
//  Created by Nikki Ivie on 11/6/18.
//  Copyright © 2018 Haptic Technologies, LLC. All rights reserved.
//
//

import UIKit
import os.log


class TableViewController: UITableViewController {
    
    var goals = [Goal]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        if let savedGoals = loadGoal() {
            goals += savedGoals
        }
        else {
                    loadSampleGoal()
        }
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "GoalViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? GoalViewCell else {
            
            fatalError("Something's not quite right.")
        }
        
        let goal = goals[indexPath.row]
        
        cell.goalName.text = goal.goalName
        cell.percentCompleteLabel.text = goal.percentComplete
        cell.goalIsComplete.text = goal.goalComplete
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            
        case "showDetailSegue":
            guard let goalDetailViewController = segue.destination as? ViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedGoalCell = sender as? GoalViewCell else {
                fatalError("Unexpected sender.")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedGoalCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedGoal = goals[indexPath.row]
            goalDetailViewController.goal = selectedGoal
            
        default:
            fatalError("Unexpected Segue Identifier")
        }
    }
    
    @IBAction func unwindToGoalList(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? ViewController, let goal = sourceViewController.goal {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                
                goals[selectedIndexPath.row] = goal
                tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
            } else {
                
                let newIndexPath = IndexPath(row: goals.count, section: 0)
                
                goals.append(goal)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            saveGoals()
        }
        
    }

    private func loadSampleGoal() {
        
        guard let goal1 = Goal(goalName: "Dance", percentComplete: "0", goalComplete: "Yes") else {
            fatalError("Unable to load goal1.")
        }
        guard let goal2 = Goal(goalName: "Eat", percentComplete: "0", goalComplete: "No") else {
            fatalError("Unable to load goal2.")
        }
        
        goals += [goal1, goal2]
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                // Delete the row from the data source
                goals.remove(at: indexPath.row)
                saveGoals()
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else if editingStyle == .insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            }
        }
    
    private func saveGoals() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(goals, toFile: Goal.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadGoal() -> [Goal]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Goal.ArchiveURL.path) as? [Goal]
    }}
