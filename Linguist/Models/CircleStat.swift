//
//  CircleStat.swift
//  Linguist
//
//  Created by Steve on 11/5/16.
//  Copyright © 2016 31Labs. All rights reserved.
//

import UIKit

class CircleStat: NSObject {

    var percent = 0.0
    var desc = ""
    
    init?(percent:Double,desc:String) {
        self.percent = percent
        self.desc = desc
    }
    
}
