//
//  DuoClient.swift
//  Linguist
//
//  Created by Steve on 10/29/16.
//  Copyright © 2016 31Labs. All rights reserved.
//

import UIKit
import Alamofire

class DuoClient: NSObject {

    let baseURL = "https://www.duolingo.com/"
    let currentUser = "steve296840"
    
    func loadFromDuo() {
        let userURL = baseURL + "users/\(currentUser)"
       
        Alamofire.request(userURL).responseJSON { (response) in
            print("*** success loading url...")
            dump(response)
            if let json = response.result.value {
                print("*** success parsing json...")
                dump(json)
            }
        }
    }
    
}
