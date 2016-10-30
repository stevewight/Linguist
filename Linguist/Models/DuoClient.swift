//
//  DuoClient.swift
//  Linguist
//
//  Created by Steve on 10/29/16.
//  Copyright © 2016 31Labs. All rights reserved.
//

import UIKit
import Alamofire

protocol DuoClientDelegate {
    func successLoadingUser()
}

class DuoClient: NSObject {

    let baseURL = "https://www.duolingo.com/"
    let currentUser = "steve296840"
    var duoUser = DuoUser()
    
    func loadDuoUser(success:@escaping (_ newUser:DuoUser)->Void) {
        let userURL = baseURL + "users/\(currentUser)"
       
        Alamofire.request(userURL).responseJSON { (response) in
            if let json = response.result.value as? [String:AnyObject] {
                self.duoUser = DuoUser(rawJson: json)!
                success(self.duoUser)
            }
        }
    }
    
}
