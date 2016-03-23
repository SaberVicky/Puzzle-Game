//
//  SLChapterViewController.swift
//  Puzzle Game
//
//  Created by songlong on 16/3/22.
//  Copyright © 2016年 songlong. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ChapterCell"

class SLChapterViewController: UICollectionViewController {
    
    func clickQuit() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(100, 100)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        
        super.init(collectionViewLayout: layout)
        
        collectionView?.bounces = true
        collectionView?.backgroundColor = UIColor.lightGrayColor()
        collectionView?.showsHorizontalScrollIndicator = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chapter"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: "clickQuit")
        self.collectionView!.registerClass(ChapterCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return chapterArray.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ChapterCell
        
        cell.chapterTitle = "Chapter" + "\(indexPath.item + 1)"
        let chapter = chapterArray[indexPath.item] as! SLChapter
        cell.configureWithModel(chapter)
    
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let chapter = chapterArray[indexPath.item] as! SLChapter
        if chapter.chapterIsFinished == true {
            let vc = SLMainViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    private lazy var chapterArray: NSArray = {
        
        let home = NSURL(string: NSHomeDirectory())
        let docPath = home?.URLByAppendingPathComponent("Documents")
        let filePath = docPath?.URLByAppendingPathComponent("chapter.plist")
        
        var data = NSArray(contentsOfFile: filePath!.absoluteString)
        if (data == nil) {
            let dictArr = NSMutableArray()
            for i in 1...20 {
                let dic = ["chapterIsFinished": i == 1 ? true : false, "chapterStarsCount": 0]
                dictArr.addObject(dic)
            }
            dictArr.writeToFile(filePath!.absoluteString, atomically: true)
        }
        data = NSArray(contentsOfFile: filePath!.absoluteString)
        
        let chapterArray = NSMutableArray()
        
        for dict in data! {
            let chapter = SLChapter(dict: dict as! [String : AnyObject])
            chapterArray.addObject(chapter)
        }
        
        return chapterArray
    }()
}

private class ChapterCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var chapterTitle: String = "Chapter" {
        didSet {
            titleLabel.text = chapterTitle
        }
    }
    
    func configureWithModel(chapter: SLChapter) {
        
        lockView.image = chapter.chapterIsFinished == true ? nil : UIImage(named: "lock")
        if chapter.chapterStarsCount == 0  {
            starViewLeft.image = UIImage(named: "star_black")
            starViewMid.image = UIImage(named: "star_black")
            starViewRight.image = UIImage(named: "star_black")
        } else if chapter.chapterStarsCount >= 1 {
            starViewLeft.image = UIImage(named: "star_golden")
            starViewMid.image = UIImage(named: "star_black")
            starViewRight.image = UIImage(named: "star_black")
        } else if chapter.chapterStarsCount >= 2 {
            starViewLeft.image = UIImage(named: "star_golden")
            starViewMid.image = UIImage(named: "star_golden")
            starViewRight.image = UIImage(named: "star_black")
        } else {
            starViewLeft.image = UIImage(named: "star_golden")
            starViewMid.image = UIImage(named: "star_golden")
            starViewRight.image = UIImage(named: "star_golden")
        }
        
    }
    
    private func setupUI() {
        contentView.backgroundColor = UIColor.redColor()
        self.addSubview(titleLabel)
        self.addSubview(lockView)
        self.addSubview(starViewLeft)
        self.addSubview(starViewMid)
        self.addSubview(starViewRight)
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(self.snp_height).multipliedBy(0.2)
        }
        
        lockView.snp_makeConstraints { (make) -> Void in
            make.left.right.top.equalTo(0)
            make.height.equalTo(self.snp_height).multipliedBy(0.8)
        }
        
        starViewLeft.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.snp_centerY)
            make.left.equalTo(0)
            make.width.height.equalTo(self.snp_width).multipliedBy(1.0 / 3.0)
        }
        
        starViewRight.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.snp_centerY)
            make.right.equalTo(0)
            make.width.height.equalTo(self.snp_width).multipliedBy(1.0 / 3.0)
        }
        
        starViewMid.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.snp_centerY)
            make.width.height.equalTo(self.snp_width).multipliedBy(1.0 / 3.0)
            make.left.equalTo(starViewLeft.snp_right)
        }
    
    }
    
    private lazy var lockView = UIImageView(image: UIImage(named: "lock"))
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .Center
        label.textColor = UIColor.whiteColor()
        return label
    }()
    
    private lazy var starViewLeft = UIImageView()
    private lazy var starViewMid = UIImageView()
    private lazy var starViewRight = UIImageView()
}
