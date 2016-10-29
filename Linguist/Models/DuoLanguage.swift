//
//  DuoLanguage.swift
//  Linguist
//
//  Created by Steve on 10/29/16.
//  Copyright © 2016 31Labs. All rights reserved.
//

import UIKit

class DuoLanguage: NSObject {

    var streak = 0
    var fluencyScore = 0.0
    var languageString = ""
    var numSkillsLearned = 0
 
    override init() {
        super.init()
    }
    
    init?(rawJson:[String:AnyObject]) {
        super.init()
        
    }
    
}
