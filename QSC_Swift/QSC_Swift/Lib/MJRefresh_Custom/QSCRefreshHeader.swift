//
//  QSCRefreshHeader.swift
//  QSC_Swift
//
//  Created by zhangzhenwei on 17/4/25.
//  Copyright © 2017年 QSC. All rights reserved.
//

let  QSCRefreshHeaderHeight:CGFloat = 65.0


import UIKit



class QSCRefreshHeader: QSCRefreshComponent {

    let ignoredScrollViewContentInsetTop:CGFloat? = 0
    var insetTDelta:CGFloat? = 0

    
    
    class func headerWithRefreshingBlock(refreshingBlock:@escaping QSCRefreshComponentRefreshingBlock)->Self{
        
        let header = self.init()
        header.refreshingBlock = refreshingBlock
        return header
    }
    
    
    override func prepare() {
        super.prepare()
        self.height = QSCRefreshHeaderHeight
    }
    
    override func placeMySubviwes() {
        super.placeMySubviwes()
        
        self.y  =  -self.height - self.ignoredScrollViewContentInsetTop!
    }
    
    

    
    override func scrollViewContentOffsetDidChange(change: [NSKeyValueChangeKey : Any]) {
        super.scrollViewContentSizeDidChange(change: change)
        if self.state == .QSCRefreshStateRefreshing {
            if self.window == nil { return }
            
            // sectionheader停留解决
            let insetT:CGFloat? = QSCRefreshHeaderHeight
            
            self.scrollView?.contentInset.top = insetT!;
            self.insetTDelta = (scrollViewOriginalInset?.top)! - insetT!;
            
            return
        }
        
        scrollViewOriginalInset = self.scrollView?.contentInset
        let offsetY = self.scrollView?.contentOffset.y
        print("----------\(offsetY)")
        
        let happenOffsetY = (0-(scrollViewOriginalInset?.top)!)
        
        if (offsetY! > happenOffsetY) {
            return
        }
        // 普通 和 即将刷新 的临界点
        let normal2pullingOffsetY = happenOffsetY - self.height;

        
        if (self.scrollView?.isDragging)! { // 如果正在拖拽
            if (self.state == QSCRefreshState.QSCRefreshStateIdle && (offsetY! < normal2pullingOffsetY)) {
                // 转为即将刷新状态
                self.state = QSCRefreshState.QSCRefreshStatePulling;
            } else if (self.state == QSCRefreshState.QSCRefreshStatePulling && offsetY! >= normal2pullingOffsetY) {
                // 转为普通状态
                self.state = QSCRefreshState.QSCRefreshStateIdle;
            }
        } else if (self.state == QSCRefreshState.QSCRefreshStatePulling) {// 即将刷新 && 手松开
            // 开始刷新
           self.beginRefreshing()
        }
        
    }
    
    override var state: QSCRefreshState?{
        didSet(newValue) {
            if state == QSCRefreshState.QSCRefreshStateIdle {
                if newValue != QSCRefreshState.QSCRefreshStateRefreshing {
                    return
                }
                
                UIView.animate(withDuration: 0.4, animations: {
                    self.scrollView?.contentInset.top += self.insetTDelta!
                }, completion: { (finish) in
                    self.myendRefreshingCompletionBlock?()
                })
                
            }else if (state == QSCRefreshState.QSCRefreshStateRefreshing){
                DispatchQueue.main.async(execute: { 
                    UIView.animate(withDuration: 0.25, animations: { 
                        let top = (self.scrollViewOriginalInset?.top)! + self.height
                        self.scrollView?.contentInset.top = top
                        self.scrollView?.setContentOffset(CGPoint(x: 0, y: -top), animated: false)
                    }, completion: { (finish) in
                        print("QSCRefreshStateRefreshingQSCRefreshStateRefreshingQSCRefreshStateRefreshingQSCRefreshStateRefreshing")
                        self.executeRefreshingCallback()
                    })
                })
            }
   
        }

    }
    
    
    override func endRefresing() {
        DispatchQueue.main.async { 
            self.state = QSCRefreshState.QSCRefreshStateIdle
        }
    }
    
    
}
