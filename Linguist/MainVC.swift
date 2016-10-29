//
//  MainVC.swift
//  Linguist
//
//  Created by Steve on 10/29/16.
//  Copyright © 2016 31Labs. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    var client = DuoClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("finished loading mainVC")
        client.loadFromDuo()
    }

}

