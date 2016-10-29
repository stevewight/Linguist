//
//  DuoUser.swift
//  Linguist
//
//  Created by Steve on 10/29/16.
//  Copyright © 2016 31Labs. All rights reserved.
//

import UIKit

class DuoUser: NSObject {
    
    var username = ""
    var created = ""
    var streakExtendedToday = false
    var learningLanguage = ""
    var duoLanguage = DuoLanguage()
    
    override init() {
        super.init()
    }

    init?(rawJson:[String:AnyObject]) {
        super.init()
        
        if let newUserName = rawJson["username"] as? String {
            username = newUserName
        }
        
        if let newCreated = rawJson["created"] as? String {
            created = newCreated.replacingOccurrences(
                of: "\n",
                with: ""
            )
        }
        
        if let newStreakExtendedToday = rawJson["streak_extended_today"] as? Bool {
            streakExtendedToday = newStreakExtendedToday
        }
        
        if let newLearningLanguage = rawJson["learning_language"] as? String {
            learningLanguage = newLearningLanguage
        }
    }
    
}
