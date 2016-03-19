
//
//  UIImageView+Extension.swift
//  Puzzle Game
//
//  Created by songlong on 16/3/19.
//  Copyright © 2016年 songlong. All rights reserved.
//

import UIKit

extension UIImage {
    convenience init(imageName: String, currentIndex: Int, totalIndex: Int) {
        let image = UIImage(named: imageName)
        let imageRef = image?.CGImage
        let n = Int(sqrt(CGFloat(totalIndex)))
        
        let width = image!.size.width / CGFloat(n)
        let height = image!.size.height / CGFloat(n)
        let x = CGFloat((currentIndex - 1) % n) * width
        let y = CGFloat((currentIndex - 1) / n) * height
        
        let clipImage = CGImageCreateWithImageInRect(imageRef, CGRectMake(x, y, width, height))
        self.init(CGImage: clipImage!)
    }
}
