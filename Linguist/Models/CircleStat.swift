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
    var subDesc = [String]()
    
    init?(percent:Double,desc:String,subDesc:[String]) {
        self.percent = percent
        self.desc = desc
        self.subDesc = subDesc
    }
    
}
