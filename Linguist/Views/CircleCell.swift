//
//  CircleCell.swift
//  Linguist
//
//  Created by Steve on 11/5/16.
//  Copyright © 2016 Steve Wight. All rights reserved.
//

import UIKit

class CircleCell: UICollectionViewCell {
    
    @IBOutlet weak var circleTileView: CircleTileView!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func setPercent(percent:Double) {
        let fullValue = percent * 100
        percentLabel.text = String(
            format: "%.1f",
            fullValue
        )
    }
    
}
