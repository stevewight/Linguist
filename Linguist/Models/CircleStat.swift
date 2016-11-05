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
    var title = ""
    var desc = ""
    
    init?(percent:Double,title:String,desc:String) {
        self.percent = percent
        self.title = title
        self.desc = desc
    }
    
}
