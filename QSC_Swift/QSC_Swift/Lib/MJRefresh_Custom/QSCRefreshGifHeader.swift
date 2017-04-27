//
//  QSCRefreshGifHeader.swift
//  QSC_Swift
//
//  Created by zhangzhenwei on 17/4/25.
//  Copyright © 2017年 QSC. All rights reserved.
//

import UIKit

class QSCRefreshGifHeader: QSCRefreshHeader {
    
    lazy var imageView:UIImageView = UIImageView()
    lazy var stateLabel:UILabel = UILabel()
    var idleImages = [UIImage]()
    
    
    lazy var imageArray: [UIImage] = {
        var myImageArray = [UIImage]()
        for i in 1...12 {
            let image:UIImage = UIImage(named: "pullCat-\(i)")! as UIImage
            myImageArray.append(image)
        }
        return myImageArray
    }()
    
    
    
    
    
    override var state: QSCRefreshState?{
        didSet{
            
            if (state == QSCRefreshState.QSCRefreshStatePulling) {
                self.imageView.stopAnimating()
                self.stateLabel.text = "松开刷新..."
                self.imageView.image = imageArray[0]
                
            }else if(state == QSCRefreshState.QSCRefreshStateRefreshing ){
                self.imageView.stopAnimating()
                self.stateLabel.text = "刷新中..."
                self.imageView.animationDuration = 1.0
                self.imageView.animationImages = imageArray
                self.imageView.startAnimating()
            }else if state == QSCRefreshState.QSCRefreshStateIdle{
                self.stateLabel.text = "下拉刷新..."
                self.imageView.image = imageArray[0]
                self.imageView.stopAnimating()
            }
        }
    }
    
    override func placeMySubviwes() {
        self.imageView.centerX = self.centerX;
        self.imageView.frame.size = CGSize(width: 80, height: 50);
        self.imageView.contentMode = .scaleToFill
        self.stateLabel.frame = CGRect(x: 0, y: self.imageView.height, width: SCREEN_WIDTH, height: 15)

        self.stateLabel.textAlignment = .center
        self.addSubview(self.imageView)
        self.addSubview(self.stateLabel)
        
        self.y  =  -64
    }
}
