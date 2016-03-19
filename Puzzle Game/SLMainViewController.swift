//
//  SLMainViewController.swift
//  Puzzle Game
//
//  Created by songlong on 16/3/12.
//  Copyright © 2016年 songlong. All rights reserved.
//

import UIKit
import SVProgressHUD


class SLMainViewController: UIViewController, UIAlertViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupImages()
    }
    
    private lazy var gameView = UIView()
}

extension SLMainViewController {
    
    private func setupUI() {
        view.backgroundColor = UIColor.lightGrayColor()
        title = "Puzzle Game"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Quit", style: .Plain, target: self, action: "clickQuit")

        gameView.backgroundColor = UIColor.whiteColor()
        view.addSubview(gameView)
        gameView .snp_makeConstraints { (make) -> Void in
            make.center.equalTo(view.snp_center)
            make.width.equalTo(kScreenWidth)
            make.height.equalTo(kScreenWidth)
        }
    }
    
    private func setupImages() {
        
        let difficulty = SLGameManager.shareManager.gameDifficulty
        let count = difficulty * difficulty

        let randomArr = randomArray(count - 1)
        
        let width = kScreenWidth / CGFloat(difficulty)
        let height = width
        for i in 0...(count - 2) {
            let x = CGFloat(i % difficulty) * width
            let y = CGFloat(i / difficulty) * height
            let n = randomArr[i]
            
            
            let button = UIButton(frame: CGRectMake(x, y, width, height))
            button.setImage(UIImage(imageName: "jiqimao", currentIndex: Int(n.intValue), totalIndex: count), forState: .Normal)
            button.tag = Int(n.intValue)
            button.addTarget(self, action: "clickButton:", forControlEvents: .TouchUpInside)
            gameView.addSubview(button)
        }
        
        let x = CGFloat((count - 1)  % difficulty) * width
        let y = CGFloat((count - 1) / difficulty) * height
        let button = UIButton(frame: CGRectMake(x, y, width, height))
        button.backgroundColor = UIColor.whiteColor()
        button.tag = count
        gameView.addSubview(button)
        gameView.sendSubviewToBack(button)
    }
    
    func randomArray(max: Int) -> NSArray {
        let startArray = NSMutableArray()
        for i in 1...max {
            startArray.addObject(i)
        }
        let endArray = NSMutableArray()
        
        while endArray.count < max {
            let n = arc4random() % UInt32(startArray.count)
            endArray.addObject(startArray[Int(n)])
            startArray.removeObjectAtIndex(Int(n))
        }
        return endArray
    }
}

extension SLMainViewController {
    

    
    func clickQuit() {
        UIAlertView(title: "Tip", message: "Quit Game?", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "Confirm").show()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 1 {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func clickButton(sender: UIButton) {
        
        
        
        let difficulty = SLGameManager.shareManager.gameDifficulty
        let count = difficulty * difficulty
        let whiteButton = view.viewWithTag(count)
        let s = sender.frame
        let w = whiteButton!.frame
        if (
            abs(CGRectGetMinX(s) - CGRectGetMinX(w)) <= 1 && abs(CGRectGetMaxY(s) - CGRectGetMinY(w)) <= 1 ||
            abs(CGRectGetMinX(s) - CGRectGetMinX(w)) <= 1 && abs(CGRectGetMaxY(w) - CGRectGetMinY(s)) <= 1 ||
            abs(CGRectGetMinY(s) - CGRectGetMinY(w)) <= 1 && abs(CGRectGetMaxX(s) - CGRectGetMinX(w)) <= 1 ||
            abs(CGRectGetMinY(s) - CGRectGetMinY(w)) <= 1 && abs(CGRectGetMaxX(w) - CGRectGetMinX(s)) <= 1
            ) {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                sender.frame = w
                whiteButton?.frame = s
                }, completion: { (Bool) -> Void in
                    if self.checkWin() {
                        self.gameView.userInteractionEnabled = false
                        SVProgressHUD.showSuccessWithStatus("Win")
                    }
            })
        }
    }
    
    func checkWin() -> Bool {
        let difficulty = SLGameManager.shareManager.gameDifficulty
        let count = difficulty * difficulty
        
        let width = gameView.frame.size.width / CGFloat(difficulty)
        
        for i in 1...(count - 1) {
            let button = view.viewWithTag(i)
            if abs(button!.frame.origin.x - CGFloat((i - 1) % difficulty) * width) > 1 || abs(button!.frame.origin.y - CGFloat((i - 1) / difficulty) * width) > 1{
                return false
            }
        }
        
        return true
    }
}