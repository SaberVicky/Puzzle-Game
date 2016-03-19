//
//  SLStartViewController.swift
//  Puzzle Game
//
//  Created by songlong on 16/3/12.
//  Copyright © 2016年 songlong. All rights reserved.
//

import UIKit

class SLStartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    private lazy var gameLabel: UILabel = {
        let label = UILabel(frame: CGRectZero)
        label.text = "Puzzle Game"
        label.font = UIFont.systemFontOfSize(30)
        return label
    }()
    
    private lazy var startGameButton: UIButton = {
        let button = UIButton(frame: CGRectZero)
        button.setTitle("StartGame", forState: .Normal)
        button.setTitleColor(UIColor.redColor(), forState: .Normal)
        button.layer.cornerRadius = 5.0
        button.clipsToBounds = true
        button.backgroundColor = UIColor.yellowColor()
        button.addTarget(self, action: "clickStart", forControlEvents: .TouchUpInside)
        return button
    }()
    
    private lazy var settingGameButton: UIButton = {
        let button = UIButton(frame: CGRectZero)
        button.setTitle("SettingGame", forState: .Normal)
        button.setTitleColor(UIColor.redColor(), forState: .Normal)
        button.layer.cornerRadius = 5.0
        button.clipsToBounds = true
        button.backgroundColor = UIColor.yellowColor()
        button.addTarget(self, action: "clickSetting", forControlEvents: .TouchUpInside)
        return button
    }()

}

extension SLStartViewController {
    
    private func setupUI() {
        view.backgroundColor = UIColor.lightGrayColor()
        view.addSubview(gameLabel)
        view.addSubview(startGameButton)
        view.addSubview(settingGameButton)
        
        gameLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(view.snp_centerX)
            make.centerY.equalTo(view.snp_centerY).multipliedBy(0.5)
        }
    
        startGameButton.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(view.snp_centerX)
            make.width.equalTo(120)
            make.height.equalTo(60)
            make.centerY.equalTo(view.snp_centerY).multipliedBy(1.25)
        }
        
        settingGameButton.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(startGameButton.snp_width)
            make.height.equalTo(startGameButton.snp_height)
            make.centerX.equalTo(view.snp_centerX)
            make.centerY.equalTo(view.snp_centerY).multipliedBy(1.75)
        }
    }
    
    func clickStart() {
        let nav = UINavigationController(rootViewController: SLMainViewController())
        presentViewController(nav, animated: false, completion: nil)
    }
    
    func clickSetting() {
        presentViewController(SLSettingViewController(), animated: false, completion: nil)
    }
    
}


