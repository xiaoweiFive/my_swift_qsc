//
//  QSC_MJRefreshGifTool.swift
//  QSC_Swift
//
//  Created by zhangzhenwei on 17/4/24.
//  Copyright © 2017年 QSC. All rights reserved.
//

import UIKit
import MJRefresh

public typealias GifBlock = () -> ()


class QSC_MJRefreshGifTool: NSObject {
    
    //imageArray
    var idleImages:NSMutableArray = []
    var objectArr = [String]()
    var refreshingImages:NSMutableArray = []
    
    
    class func MJRefreshGifCustomBlock(tableView:UITableView, block:@escaping GifBlock) {

        //下拉过程时的图片集合(根据下拉距离自动改变)
        var idleImages = [UIImage]()
        for i in 1...2 {
            idleImages.append(UIImage(named:"pullCat-\(i)")!)
        }
        
        // 设置普通状态的动画图片
        for i in 1...10 {
            let image:UIImage = UIImage(named: "pullCat-\(i)")! as UIImage
            idleImages.append(image)
        }
        
        let header:MJRefreshGifHeader = MJRefreshGifHeader.init { 
            block()
        };
        //设置普通状态动画图片
        header.setImages(idleImages as [AnyObject], for: MJRefreshState.idle)
        //设置下拉操作时动画图片
        header.setImages(idleImages as [AnyObject], for: MJRefreshState.pulling)
        //设置正在刷新时动画图片
        header.setImages(idleImages as [AnyObject], for: MJRefreshState.refreshing)
        
        header.lastUpdatedTimeLabel.isHidden = true
        //        header.stateLabel.isHidden = true
        
        header.setTitle("下拉刷新...", for: MJRefreshState.idle)
        header.setTitle("松开刷新...", for: MJRefreshState.pulling)
        header.setTitle("加载中...", for: MJRefreshState.refreshing)
        
        tableView.mj_header = header;
    }
}
