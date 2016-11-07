//
//  MainVC.swift
//  Linguist
//
//  Created by Steve on 10/29/16.
//  Copyright © 2016 31Labs. All rights reserved.
//

import UIKit
import LTMorphingLabel
import UPCarouselFlowLayout

class MainVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var client = DuoClient()
    var duoUser = DuoUser()
    
    var circleStats = [CircleStat]()
    
    var currentPage:Int = 0 {
        didSet {
            print("did set currentPage: \(self.currentPage)")
            if currentPage != oldValue {
                let stat = circleStats[currentPage]
                subDescLabel.text = stat.subDesc
            }
        }
    }
    
    var pageWidth:CGFloat {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        var newSize = layout.itemSize
        newSize.width += layout.minimumLineSpacing
        return newSize.width
    }
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var subDescLabel: LTMorphingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPage = 0
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
        cell.setPercent(percent: circleStat.percent)
        cell.descriptionLabel.text = circleStat.desc
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("collection view tapped")
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        currentPage = Int(floor((offset - pageWidth / 2) / pageWidth) + 1)
    }
    
    // MARK: (self) Methods
    
    func setupCircleItems() {
        let duoLang = duoUser.duoLanguage()
        let doubleTotal = Double(duoLang.skills.count)
        let doubleLearned = Double(duoLang.numSkillsLearned)
        let skillPercent = doubleLearned/doubleTotal
        let progressPercent = duoLang.duoLevel.levelPercent()
        
        circleStats.append(CircleStat(
            percent: duoLang.fluencyScore,
            desc: "% fluent",
            subDesc: "\(duoLang.streak) day streak \(extendedString(extended: duoUser.streakExtendedToday))"
        )!)
        circleStats.append(CircleStat(
            percent: skillPercent,
            desc: "% skill",
            subDesc: "\(duoLang.numSkillsLearned) skills learned with \(duoLang.nextSkillTitle) up next"
        )!)
        circleStats.append(CircleStat(
            percent: progressPercent,
            desc: "% progress",
            subDesc: "currently level \(duoLang.duoLevel.current) with \(duoLang.duoLevel.left)xp to next level"
        )!)
        circleStats.append(CircleStat(
            percent: duoLang.languageStrength,
            desc: "% lang. strength",
            subDesc: "\(duoUser.lingots) lingots with \(duoLang.duoLevel.points)xp total"
        )!)
    }
    
    func updateInterface() {
        let duoLang = duoUser.duoLanguage()
        
        navBar.topItem?.title = duoLang.languageString
        collectionView.reloadData()
    }
    
    func extendedString(extended:Bool)->String {
        return extended ? "extended" : "not extended"
    }

}

