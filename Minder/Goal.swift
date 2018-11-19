//
//  Goal.swift
//  Minder
//
//  Created by Nikki Ivie on 11/7/18.
//  Copyright © 2018 Haptic Technologies, LLC. All rights reserved.
//
//

import UIKit
import os.log

class Goal:NSObject, NSCoding {
    
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
    
    struct PropertyKey {
        static let goalName = "goalName"
        static let percentComplete = "percentComplete"
        static let goalComplete = "goalComplete"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(goalName, forKey: PropertyKey.goalName)
        aCoder.encode(percentComplete, forKey: PropertyKey.percentComplete)
        aCoder.encode(goalComplete, forKey: PropertyKey.goalComplete)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let goalName = aDecoder.decodeObject(forKey: PropertyKey.goalName) as? String else {
            os_log("Unable to decode the name for a goal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let percentComplete = aDecoder.decodeObject(forKey: PropertyKey.percentComplete) //as? Int
        
        let goalComplete = aDecoder.decodeObject(forKey: PropertyKey.goalComplete)
        
        // Must call designated initializer.
        self.init(goalName: goalName, percentComplete: percentComplete as? String, goalComplete: goalComplete as! String)
        
    }
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("goals")
    
}
