//
//  VCHelper.swift
//  Linguist
//
//  Created by Steve on 11/1/16.
//  Copyright © 2016 Steve Wight. All rights reserved.
//

import UIKit

class VCHelper: NSObject {

    class func getMainVC()-> MainVC {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(
            withIdentifier: "MainVC"
            ) as! MainVC
        return vc
    }
    
    class func getUserEnterVC()-> UserEnterVC {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(
            withIdentifier: "UserEnterVC"
            ) as! UserEnterVC
        return vc
    }
    
}
