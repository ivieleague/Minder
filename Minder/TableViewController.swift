//
//  TableViewController.swift
//  Minder
//
//  Created by Nikki Ivie on 11/6/18.
//  Copyright © 2018 Haptic Technologies, LLC. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var goals = [Goal]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSampleGoal()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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

    private func loadSampleGoal() {
        
        guard let goal1 = Goal(goalName: "Dance", percentComplete: "0", goalComplete: "Yes") else {
            fatalError("Unable to load goal1.")
        }
        guard let goal2 = Goal(goalName: "Eat", percentComplete: "0", goalComplete: "No") else {
            fatalError("Unable to load goal2.")
        }
        
        goals += [goal1, goal2]
    }

}
