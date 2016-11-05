//
//  MainVC.swift
//  Linguist
//
//  Created by Steve on 10/29/16.
//  Copyright © 2016 31Labs. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var client = DuoClient()
    var duoUser = DuoUser()
    
    var circleStats = [CircleStat]()
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var streakLabel: UILabel!
    @IBOutlet weak var extendedLabel: UILabel!
    @IBOutlet weak var skillsLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        duoUser = DuoClient.sharedInstance.duoUser
        self.updateInterface()
        setupCircleItems()
        collectionView.reloadData()
    }
    
    // MARK: IBAction Methods
    
    @IBAction func actionButtonTapped(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "DuoUserName")
        let vc = presentingViewController as? UserEnterVC
        vc?.isFromPresented = true
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func reloadButtonTapped(_ sender: Any) {
        let vc = presentingViewController as? UserEnterVC
        vc?.isFromPresented = true
        vc?.isReload = true
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: UICollectionViewDelegate & UICollectionViewDelegateFlowLayout
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return circleStats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CircleCell",
            for: indexPath
        ) as! CircleCell
        
        let circleStat = circleStats[indexPath.row]
        cell.circleTileView.rating = CGFloat(circleStat.percent)
        cell.percentLabel.text = circleStat.title
        cell.descriptionLabel.text = circleStat.desc
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("collection view tapped")
    }
    
    // MARK: (self) Methods
    
    func setupCircleItems() {
        circleStats.append(CircleStat(
            percent: 0.3,
            title: "A",
            desc: "A"
        )!)
        circleStats.append(CircleStat(
            percent: 0.6,
            title: "P",
            desc: "P"
        )!)
        circleStats.append(CircleStat(
            percent: 0.4,
            title: "S",
            desc: "S"
        )!)
        circleStats.append(CircleStat(
            percent: 0.8,
            title: "Z",
            desc: "Z"
        )!)
    }
    
    func updateInterface() {
        let duoLang = duoUser.duoLanguage()
        let doubleTotal = Double(duoLang.skills.count)
        let doubleLearned = Double(duoLang.numSkillsLearned)
        let skillPercent = doubleLearned/doubleTotal
        let progressPercent = duoLang.duoLevel.levelPercent()
        
//        fluencyLabel.text = fluencyPercent(
//            score: duoLang.fluencyScore
//        )
//        skillsPercentLabel.text = skillsPercent(
//            score: skillPercent
//        )
//        levelProgressLabel.text = levelProgressPercent(
//            progress: progressPercent
//        )
//        levelStrengthLabel.text = levelStrengthPercent(
//            strength: duoLang.languageStrength
//        )
        streakLabel.text = "\(duoLang.streak)"
        skillsLabel.text = "\(duoLang.numSkillsLearned)"
        extendedLabel.text = extendedString(
            extended: duoUser.streakExtendedToday
        )
        navBar.topItem?.title = duoLang.languageString
//        fluencyCircle.rating = CGFloat(duoLang.fluencyScore)
//        skillsCircle.rating = CGFloat(skillPercent)
//        levelProgressCircle.rating = CGFloat(progressPercent)
//        levelStrengthCircle.rating = CGFloat(duoLang.languageStrength)
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
    
    func levelStrengthPercent(strength:Double)->String {
        let strengthDouble = strength * 100
        return String(format: "%.1f", strengthDouble)
    }
    
    func extendedString(extended:Bool)->String {
        return extended ? "YES" : "NO"
    }

}

