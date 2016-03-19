//
//  SLSettingViewController.swift
//  Puzzle Game
//
//  Created by songlong on 16/3/12.
//  Copyright © 2016年 songlong. All rights reserved.
//

import UIKit


class SLSettingViewController: UIViewController {

    private var currentDifficult: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupDefaultDifficult()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        iconView.setBackgroundImage(UIImage(named: SLGameManager.shareManager.gameDifficultImageName), forState: .Normal)
    }
    
    private lazy var iconView = UIButton()
    
}

extension SLSettingViewController {
    private func setupUI() {
        
        view.backgroundColor = UIColor.lightGrayColor()
        
        let difficultyLabel = UILabel()
        difficultyLabel.text = "Difficulty"
        view.addSubview(difficultyLabel)
        difficultyLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(view.snp_centerX)
            make.top.equalTo(view.snp_top).offset(50)
            make.height.equalTo(100)
        }
        
        
        let margin: CGFloat = 30
        let height: CGFloat = 60
        let width: CGFloat = (kScreenWidth - (3 + 1) * margin) / 3
        let y: CGFloat = 120
        for i in 0...3 {
            let x: CGFloat = margin + CGFloat(i) * (margin + width)
            let difficultyButton = UIButton(frame: CGRectMake(x, y, width, height))
            difficultyButton.setTitle("\(i+3)x\(i+3)", forState: .Normal)
            difficultyButton.setTitleColor(UIColor.redColor(), forState: .Normal)
            difficultyButton.backgroundColor = UIColor.yellowColor()
            difficultyButton.tag = i + 3
            difficultyButton.addTarget(self, action:"selectDifficult:" , forControlEvents: .TouchUpInside)
            view.addSubview(difficultyButton)
        }
        
        let themeLabel = UILabel()
        themeLabel.text = "Theme"
        view.addSubview(themeLabel)
        themeLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(view.snp_centerX)
            make.bottom.equalTo(-kScreenHeight / 2)
        }
        
        iconView.addTarget(self, action: "changeTheme", forControlEvents: .TouchUpInside)
        view.addSubview(iconView)
        iconView.snp_makeConstraints { (make) -> Void in
            make.width.height.equalTo(60)
            make.top.equalTo(themeLabel.snp_bottom).offset(20)
            make.centerX.equalTo(view.snp_centerX).multipliedBy(0.5)
        }
        
        let changeButton = UIButton()
        changeButton.setTitle("Change", forState: .Normal)
        changeButton.backgroundColor = UIColor.yellowColor()
        changeButton.setTitleColor(UIColor.redColor(), forState: .Normal)
        changeButton.addTarget(self, action: "changeTheme", forControlEvents: .TouchUpInside)
        view.addSubview(changeButton)
        changeButton.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(80)
            make.height.equalTo(40)
            make.centerX.equalTo(themeLabel.snp_centerX)
            make.centerY.equalTo(iconView.snp_centerY)
        }
        
        let saveButton = UIButton()
        saveButton.setTitle("Confirm", forState: .Normal)
        saveButton.backgroundColor = UIColor.greenColor()
        saveButton.addTarget(self, action: "clickConfirm", forControlEvents: .TouchUpInside)
        view.addSubview(saveButton)
        saveButton .snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(-50);
            make.centerX.equalTo(view.snp_centerX).multipliedBy(1.5)
            make.height.equalTo(60)
            make.width.equalTo(100)
        }
        
        let cancelButton = UIButton()
        cancelButton.setTitle("Cancel", forState: .Normal)
        cancelButton.backgroundColor = UIColor.greenColor()
        cancelButton.addTarget(self, action: "clickCancel", forControlEvents: .TouchUpInside)
        view.addSubview(cancelButton)
        cancelButton .snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(-50);
            make.centerX.equalTo(view.snp_centerX).multipliedBy(0.5)
            make.height.equalTo(60)
            make.width.equalTo(100)
        }
        
    }
    
    private func setupDefaultDifficult() {
        currentDifficult = SLGameManager.shareManager.gameDifficulty
        view.viewWithTag(SLGameManager.shareManager.gameDifficulty)?.backgroundColor = UIColor.blueColor()
    }
}

extension SLSettingViewController {
    
    func selectDifficult(button: UIButton) {
        for i in 3...6 {
            view.viewWithTag(i)?.backgroundColor = UIColor.yellowColor()
        }
        button.backgroundColor = UIColor.blueColor()
        currentDifficult = button.tag
    }
    
    func clickConfirm() {
        SLGameManager.shareManager.gameDifficulty = currentDifficult!
        dismissViewControllerAnimated(false, completion: nil)
    }
    
    func clickCancel() {
        dismissViewControllerAnimated(false, completion: nil)
    }
    
    func changeTheme() {
        presentViewController(SLPhotoBrowserViewController(), animated: false, completion: nil)
    }
}
