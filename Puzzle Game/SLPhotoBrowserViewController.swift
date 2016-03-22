//
//  SLPhotoBrowserViewController.swift
//  Puzzle Game
//
//  Created by songlong on 16/3/19.
//  Copyright © 2016年 songlong. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PhotoBrowser"

typealias CallBack = (photoName: String)->()

class SLPhotoBrowserViewController: UICollectionViewController {
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = UIScreen.mainScreen().bounds.size
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .Horizontal
        
        super.init(collectionViewLayout: layout)

        collectionView?.pagingEnabled = true
        collectionView?.bounces = false
        collectionView?.showsHorizontalScrollIndicator = false
    }
    
    var callBack = CallBack?()
    
    func initBack( mathFunction:(imageName: String)->Void ){
        callBack = mathFunction
    }
    
    private let photoArray = SLGameManager.shareManager.gameDefaultImageArray

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Photo Browser"
        self.collectionView!.registerClass(PhotoBrowserCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

   


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photoArray.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PhotoBrowserCell
    
        // Configure the cell
        cell.iconName = photoArray[indexPath.item]
                return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        SLGameManager.shareManager.gameImageName = SLGameManager.shareManager.gameDefaultImageArray[indexPath.item]
        callBack!(photoName: photoArray[indexPath.item])
        dismissViewControllerAnimated(false, completion: nil)
    }

}

private class PhotoBrowserCell: UICollectionViewCell {
    
    var iconName: String = "jiqimao" {
        didSet {
            iconView.image = UIImage(named: iconName)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(iconView)
        iconView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(self.snp_center)
            make.left.right.equalTo(0)
            make.height.equalTo(kScreenWidth)
        }
    }
    
    private lazy var iconView = UIImageView()
}
