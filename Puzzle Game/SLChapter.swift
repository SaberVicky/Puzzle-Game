//
//  SLChapter.swift
//  Puzzle Game
//
//  Created by songlong on 16/3/22.
//  Copyright © 2016年 songlong. All rights reserved.
//

import UIKit

class SLChapter: NSObject {
    var chapterIsFinished: Bool = false
    var chapterStarsCount: Int = 0
    
    init(dict: [String: AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }

    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
}
