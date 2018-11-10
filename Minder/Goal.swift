//
//  Goal.swift
//  Minder
//
//  Created by Nikki Ivie on 11/7/18.
//  Copyright © 2018 Haptic Technologies, LLC. All rights reserved.
//
//

import UIKit

class Goal {
    
    var goalName: String
    var percentComplete: String?
    var goalComplete: String
    
    init?(goalName: String, percentComplete: String?, goalComplete: String){
        
        //Goal Name must not be empty
        guard !goalName.isEmpty else {
            
            return nil
        }
        
        self.goalName = goalName
        self.percentComplete = percentComplete
        self.goalComplete = goalComplete
        

    }
}
