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
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var fluencyLabel: UILabel!
    @IBOutlet weak var skillsPercentLabel: UILabel!
    @IBOutlet weak var streakLabel: UILabel!
    @IBOutlet weak var extendedLabel: UILabel!
    @IBOutlet weak var skillsLabel: UILabel!
    @IBOutlet weak var fluencyCircle: CircleTileView!
    @IBOutlet weak var skillsCircle: CircleTileView!
    @IBOutlet weak var levelProgressCircle: CircleTileView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var levelProgressLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        duoUser = DuoClient.sharedInstance.duoUser
        self.updateInterface()
    }
    
    // MARK: IBAction Methods
    
    @IBAction func actionButtonTapped(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "DuoUserName")
        let vc = VCHelper.getUserEnterVC()
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func reloadButtonTapped(_ sender: Any) {
        print("reload button tapped")
    }
    
    // MARK: (self) Methods
    
    func updateInterface() {
        let duoLang = duoUser.duoLanguage()
        let doubleTotal = Double(duoLang.skills.count)
        let doubleLearned = Double(duoLang.numSkillsLearned)
        let skillPercent = doubleLearned/doubleTotal
        let progressPercent = duoLang.duoLevel.levelPercent()
        
        fluencyLabel.text = fluencyPercent(
            score: duoLang.fluencyScore
        )
        skillsPercentLabel.text = skillsPercent(
            score: skillPercent
        )
        levelProgressLabel.text = levelProgressPercent(
            progress: progressPercent
        )
        streakLabel.text = "\(duoLang.streak)"
        skillsLabel.text = "\(duoLang.numSkillsLearned)"
        extendedLabel.text = extendedString(
            extended: duoUser.streakExtendedToday
        )
        navBar.topItem?.title = duoLang.languageString
        fluencyCircle.rating = CGFloat(duoLang.fluencyScore)
        skillsCircle.rating = CGFloat(skillPercent)
        levelProgressCircle.rating = CGFloat(progressPercent)
        levelLabel.text = String(duoLang.duoLevel.current)
    }
    
    func fluencyPercent(score:Double)->String {
        let percentDouble = score * 100
        return String(format: "%.1f", percentDouble)
    }
    
    func skillsPercent(score:Double)->String {
        let skillsDouble = score * 100
        return String(format: "%.1f", skillsDouble)
    }
    
    func levelProgressPercent(progress:Double)->String {
        let progressDouble = progress * 100
        return String(format: "%.1f", progressDouble)
    }
    
    func extendedString(extended:Bool)->String {
        return extended ? "YES" : "NO"
    }

}

