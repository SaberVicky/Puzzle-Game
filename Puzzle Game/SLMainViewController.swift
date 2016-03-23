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
    
    var time = SLGameManager.shareManager.gameDefaultTime
    
    func tickDown() {
        time--
        timeLabel.text = "\(time)"
        if time == 0 {
            timer?.invalidate()
            timer = nil
            loseAlert = UIAlertView(title: "Tip", message: "You lost", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "Quit")
            loseAlert.show()
            gameView.userInteractionEnabled = false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "tickDown", userInfo: nil, repeats: true)
        timer?.fire()
        setupUI()
        setupImages()
    }
    
    private lazy var gameView = UIView()
    var timer: NSTimer?
    private lazy var timeLabel: UILabel = {
       let label = UILabel()
        label.text = "60"
        label.font = UIFont.systemFontOfSize(30)
        return label
    }()
    
    private lazy var quitAlert = UIAlertView()
    private lazy var loseAlert = UIAlertView()}

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
        
        view.addSubview(timeLabel)
        timeLabel.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(gameView.snp_top)
            make.centerX.equalTo(view.snp_centerX)
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
            
            button.setBackgroundImage(UIImage(imageName: SLGameManager.shareManager.gameImageName, currentIndex: Int(n.intValue), totalIndex: count), forState: .Normal)
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
        gameView.hidden = true
        timer?.invalidate()
        timer = nil
        quitAlert = UIAlertView(title: "Tip", message: "Quit Game?", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "Confirm")
        quitAlert.show()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if alertView == quitAlert {
            if buttonIndex == 1 {
                
                navigationController?.popViewControllerAnimated(true)
            } else {
                gameView.hidden = false
                timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "tickDown", userInfo: nil, repeats: true)
                timer?.fire()
            }
            
        } else if alertView == loseAlert {
            if buttonIndex == 1 {
                navigationController?.popViewControllerAnimated(true)
            }
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