//
//  CircleStatFactory.swift
//  Linguist
//
//  Created by Steve on 11/22/16.
//  Copyright © 2016 Steve Wight. All rights reserved.
//

import UIKit
import DuoKit

class CircleStatFactory: NSObject {

    class func build(duoUser:DuoUser)->[CircleStat] {
        var circleStats = [CircleStat]()
        let duoLang = duoUser.duoLanguage()
        let doubleTotal = Double(duoLang.skills.count)
        let doubleLearned = Double(duoLang.numSkillsLearned)
        let skillPercent = doubleLearned/doubleTotal
        let progressPercent = duoLang.duoLevel.levelPercent()
        let isExtended = duoUser.streakExtendedToday
        
        circleStats.append(CircleStat(
            title: "Fluency 🇲🇽",
            percent: duoLang.fluencyScore,
            desc: "% fluent",
            subDesc: [
                "🔥 \(duoLang.streak) day streak of \(duoUser.dailyGoal)xp goal",
                "\(extendedString(isExtended)) today \(extendedEmoji(isExtended))"
            ]
        )!)
        circleStats.append(CircleStat(
            title: "Skills 💭",
            percent: skillPercent,
            desc: "% skills complete",
            subDesc: [
                "😎 \(duoLang.numSkillsLearned) skills learned",
                "Next skill '\(duoLang.nextSkillTitle)' 🤘"
            ]
        )!)
        circleStats.append(CircleStat(
            title: "Level \(duoLang.duoLevel.current) 👍",
            percent: progressPercent,
            desc: "% level progress",
            subDesc: [
                "😁 \(duoLang.duoLevel.progress)xp this level",
                "\(duoLang.duoLevel.left)xp to next level 🤓"
            ]
        )!)
        circleStats.append(CircleStat(
            title: "Strength 💪",
            percent: duoLang.languageStrength,
            desc: "% language strength",
            subDesc: [
                "\(duoUser.lingots) lingots 💎",
                "🎉 \(duoLang.duoLevel.points)xp total"
            ]
        )!)
        
        return circleStats
    }
    
    class func extendedString(_ extended:Bool)->String {
        return extended ? "Extended" : "Not extended"
    }
    
    class func extendedEmoji(_ extended:Bool)->String {
        return extended ? "😀" : "😅"
    }
    
    
}
