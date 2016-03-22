//
//  SLGameManager.swift
//  Puzzle Game
//
//  Created by songlong on 16/3/19.
//  Copyright © 2016年 songlong. All rights reserved.
//

import UIKit

class SLGameManager: NSObject {
    //游戏默认参数
    
    //默认难度 (3*3/4*4/5*5)
    var gameDifficulty: Int = 3
    //游戏图片
    var gameImageName = "jiqimao"
    //默认图片包
    var gameDefaultImageArray = ["jiqimao", "dog"]

    static let shareManager: SLGameManager = {
        let manager = SLGameManager()
        return manager
    }()
}
