//
//  CircleStat.swift
//  Linguist
//
//  Created by Steve on 11/5/16.
//  Copyright © 2016 31Labs. All rights reserved.
//

import UIKit

class CircleStat: NSObject {

    var title = ""
    var percent = 0.0
    var desc = ""
    var subDesc = [String]()
    
    init?(title:String,percent:Double,desc:String,subDesc:[String]) {
        self.title = title
        self.percent = percent
        self.desc = desc
        self.subDesc = subDesc
    }
    
}
