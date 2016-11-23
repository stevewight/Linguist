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
            if currentPage != oldValue {
                self.updateStatsLabels()
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
    @IBOutlet weak var titleLabel: LTMorphingLabel!
    @IBOutlet weak var subDescLabel: LTMorphingLabel!
    @IBOutlet weak var subDescLabelTwo: LTMorphingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPage = 0
        duoUser = DuoClient.sharedInstance.duoUser
        setupCircleItems()
        collectionView.reloadData()
        setMorphingLabels()
        updateInterface()
    }
    
    // MARK: IBAction Methods
    
    @IBAction func actionButtonTapped(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "DuoUserName")
        closeVC(isFromPresented: true, isReload: false)
    }
    
    @IBAction func reloadButtonTapped(_ sender: Any) {
        closeVC(isFromPresented: true, isReload: true)
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
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        currentPage = Int(floor((offset - pageWidth / 2) / pageWidth) + 1)
    }
    
    // MARK: (self) Methods
    
    func setMorphingLabels() {
        subDescLabel.morphingEffect = LTMorphingEffect.fall
        subDescLabelTwo.morphingEffect = LTMorphingEffect.fall
    }
    
    func closeVC(isFromPresented:Bool, isReload:Bool) {
        let vc = presentingViewController as? UserEnterVC
        vc?.isFromPresented = isFromPresented
        vc?.isReload = isReload
        dismiss(animated: true, completion: nil)
    }
    
    func setupCircleItems() {
        circleStats = CircleStatFactory.build(duoUser: duoUser)
    }
    
    func updateInterface() {
        let duoLang = duoUser.duoLanguage()
        navBar.topItem?.title = duoLang.languageString
        collectionView.reloadData()
        updateStatsLabels()
    }
    
    func updateStatsLabels() {
        let stat = circleStats[currentPage]
        titleLabel.text = stat.title
        subDescLabel.text = stat.subDesc[0]
        subDescLabelTwo.text = stat.subDesc[1]
    }

}

