//
//  SLGameManager.swift
//  Puzzle Game
//
//  Created by songlong on 16/3/19.
//  Copyright © 2016年 songlong. All rights reserved.
//

import UIKit

class SLGameManager: NSObject {
    
    var gameDifficulty: Int = 3
    var gameDifficultImageName = "jiqimao"
    var gameDifficultImageArray = ["jiqimao", "dog"]

    static let shareManager: SLGameManager = {
        
        let manager = SLGameManager()
        
        return manager
    }()
}
