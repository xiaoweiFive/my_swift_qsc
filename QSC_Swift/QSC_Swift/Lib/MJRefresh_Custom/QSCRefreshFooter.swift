//
//  QSCRefreshFooter.swift
//  QSC_Swift
//
//  Created by zhangzhenwei on 17/4/27.
//  Copyright © 2017年 QSC. All rights reserved.
//

let  QSCRefreshFooterHeight:CGFloat = 44

import UIKit











class QSCRefreshFooter: QSCRefreshComponent {

    class func footerWithRefreshingBlock(refreshingBlock:@escaping QSCRefreshComponentRefreshingBlock)->Self{
        
        let header = self.init()
        header.refreshingBlock = refreshingBlock
        return header
    }
    
    override func prepare() {
        super.prepare()
        self.height = QSCRefreshFooterHeight
    }
    
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if newSuperview != nil {
            if !self.isHidden {
                self.scrollView?.contentInset.bottom += self.height
            }
            self.y = self.scrollView?.contentSize.height;

            
            if (self.scrollView?.isKind(of: UITableView.self))! || (self.scrollView?.isKind(of: UICollectionView.self))!  {
                
                self.scrollView?.QSCReloadDataBlock = {(totalDataCount) in
                    if totalDataCount == 0 {
                        self.isHidden = true
                    }else{
                        self.isHidden = false
//                        self.scrollView?.contentInset.bottom += self.height
//                        self.y = (self.scrollView?.contentSize.height)!
                    }
                }
                
            }else{
                if !self.isHidden {
                    self.scrollView?.contentInset.bottom -= self.height
                }
            }
            
        }
    }
    
    
    
    func endRefreshingWithNoMoreData()  {
        self.state = .QSCRefreshStateNoMoreData
    }
    func resetNoMoreData()  {
        self.state = .QSCRefreshStateIdle
    }

    override var isHidden: Bool{
        willSet{
            let lastHidden = self.isHidden
            if !lastHidden && newValue {
                self.state = QSCRefreshState.QSCRefreshStateIdle
                self.scrollView?.contentInset.bottom -= self.height
            }else if(lastHidden && !newValue){
                self.scrollView?.contentInset.bottom += self.height
                self.y = (scrollView?.contentSize.height)!
            }
        }
    }
    
    override func scrollViewContentSizeDidChange(change: [NSKeyValueChangeKey : Any]) {
        super.scrollViewContentSizeDidChange(change: change)
//        self.y = (self.scrollView?.contentSize.height)!
    }
    
    
    override func scrollViewContentOffsetDidChange(change: [NSKeyValueChangeKey : Any]) {
        super.scrollViewContentOffsetDidChange(change: change)
        if self.state != QSCRefreshState.QSCRefreshStateIdle && self.height == 0 {
            return
        }
        if (scrollView?.contentOffset.y)! > (scrollView?.contentSize.height)! - (scrollView?.height)! + self.height {
            
            let old = change[.oldKey] as! CGPoint
            let new = change[.newKey] as! CGPoint
            if old.y >= new.y {
                return
            }
            self.beginRefreshing()
        }
        
    }
    
    override func scrollViewPanStateDidChange(change: [NSKeyValueChangeKey : Any]) {
        super.scrollViewPanStateDidChange(change: change)
        if self.state != QSCRefreshState.QSCRefreshStateIdle {
            return
        }
        if scrollView?.panGestureRecognizer.state == UIGestureRecognizerState.ended {
            if (scrollView?.contentInset.top)! + (scrollView?.contentSize.height)! <= (scrollView?.height)! {// 不够一个屏幕
                if (scrollView?.contentOffset.y)! + (scrollView?.contentInset.top)! >= 0 {// 向上拽
                    self.beginRefreshing()
                }
            }else{ // 超出一个屏幕
                if (scrollView?.contentOffset.y)! > (scrollView?.contentSize.height)! - (scrollView?.height)! + self.height {
                    self.beginRefreshing()
                }
            }
        }
    }
    
    override var state: QSCRefreshState?{
        didSet(newValue) {
            if state == QSCRefreshState.QSCRefreshStateRefreshing {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    DispatchQueue.main.async {
                        self.executeRefreshingCallback()
                    }
                })
                
            }else if (state == QSCRefreshState.QSCRefreshStateNoMoreData || state == QSCRefreshState.QSCRefreshStateIdle){
                if newValue == QSCRefreshState.QSCRefreshStateRefreshing  {
                    self.myendRefreshingCompletionBlock?()
                }
            }
        }
    }
}
