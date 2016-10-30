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
    var duoUser = DuoUser()
    
    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var fluencyLabel: UILabel!
    
    @IBAction func reloadButtonTapped(_ sender: Any) {
        print("reload user data")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        client.loadDuoUser { (newUser) in
            self.duoUser = newUser
            self.updateInterface()
        }
    }
    
    // MARK: (self) Methods
    
    func updateInterface() {        
        let duoLang = duoUser.duoLanguage()
        
        fluencyLabel.text = fluencyPercent(
            score: duoLang.fluencyScore
        )
        navBar.topItem?.title = duoLang.languageString
    }
    
    func fluencyPercent(score:Double)->String {
        let percentDouble = score * 100
        return String(format: "%.1f", percentDouble)
    }

}

