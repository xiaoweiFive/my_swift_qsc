//
//  QSCRefreshHeader.swift
//  QSC_Swift
//
//  Created by zhangzhenwei on 17/4/25.
//  Copyright © 2017年 QSC. All rights reserved.
//

let  QSCRefreshHeaderHeight:CGFloat = 54.0


import UIKit



class QSCRefreshHeader: QSCRefreshComponent {

    let ignoredScrollViewContentInsetTop:CGFloat? = 0
    
    class func headerWithRefreshingBlock(refreshingBlock:@escaping QSCRefreshComponentRefreshingBlock) ->QSCRefreshHeader{
        let header = QSCRefreshComponent() as! QSCRefreshHeader
        header.refreshingBlock = refreshingBlock
        return header
    }
    
    
    override func prepare() {
        super.prepare()
        self.height = QSCRefreshHeaderHeight
    }
    
    
    override func placeSubviwes() {
        super.placeSubviwes()
        self.y = -self.height - self.ignoredScrollViewContentInsetTop!
    }
    
    override func scrollViewContentSizeDidChange(change: [NSKeyValueChangeKey : Any]) {
        super.scrollViewContentSizeDidChange(change: change)
        if self.state == .QSCRefreshStateRefreshing {
            if self.window == nil { return }
            
 
        }
        
        
        
    }
    
    
    
}
