//
//  UIScrollView+QSCCollectionFooterMore.swift
//  QSC_Swift
//
//  Created by zhangzhenwei on 17/4/25.
//  Copyright © 2017年 QSC. All rights reserved.
//


typealias DidRefresh = ()->Void

// 监听偏移量
let  kContentOffsetKey:String = "contentOffset";
let  kContentSizeKey:String = "contentSize";

let  QSCDidRefreshBlock = "QSC_Right_DidBlock"

let  QSCRightFooterView = "QSC_Right_footerView"

import Foundation


extension UIScrollView{
    
    
    var didRefreshBlock:DidRefresh{
        set {
            
            self.willChangeValue(forKey: QSCDidRefreshBlock)
            let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: QSCDidRefreshBlock.hashValue)
            objc_setAssociatedObject(self, key, newValue, .OBJC_ASSOCIATION_RETAIN)
            self.didChangeValue(forKey: QSCDidRefreshBlock)
        }
        get {
            let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: QSCDidRefreshBlock.hashValue)
            let obj = objc_getAssociatedObject(self, key) as? DidRefresh
            return obj!
        }
    }

    var footerView: QSCBezierView? {
        set (newValue){
            let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: QSCRightFooterView.hashValue)
            self.willChangeValue(forKey: QSCRightFooterView)
            objc_setAssociatedObject(self, key, newValue, .OBJC_ASSOCIATION_RETAIN)
            self.didChangeValue(forKey: QSCRightFooterView)
        }
        get {
            let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: QSCRightFooterView.hashValue)
            let obj: QSCBezierView? = objc_getAssociatedObject(self, key) as? QSCBezierView
            return obj
        }
    }
    
    
    func addFooterRefreshContentSize( W:CGFloat ,H:CGFloat) {
        var w = W
        w = w>SCREEN_WIDTH ? w : SCREEN_WIDTH
        
        if self.footerView == nil {
           let footerView = QSCBezierView.init(frame: CGRect(x: w, y: 0, width: 110, height: H))
            
            footerView.backgroundColor = UIColor.clear
            self.addSubview(footerView)
            self.footerView = footerView
            
            self.addObserver(self, forKeyPath: kContentSizeKey, options: .new, context: nil)
            self.addObserver(self, forKeyPath: kContentOffsetKey, options: .new, context: nil)

        }else{
            self.footerView?.leftViewFrame = CGRect(x: w, y: 0, width: 110, height: H)
        }
    }

    
    func endFooterRefresh() {
        if (self.footerView != nil) {
            self.removeObserver(self, forKeyPath: kContentSizeKey, context: nil)
            self.removeObserver(self, forKeyPath: kContentOffsetKey, context: nil)
            self.footerView?.removeFromSuperview()
            self.footerView = nil
        }
    }
    
    func addFooterRefresh() {
        if (self.footerView == nil) {
            footerView = QSCBezierView.init(frame: CGRect(x: self.contentSize.width+10, y: 0, width: 110, height: self.height - 55))
            footerView?.backgroundColor = UIColor.clear
            self.addSubview(footerView!)
        }
    }
    
   
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if (footerView != nil) {
            
            let scrWidth = (self.contentSize.width<SCREEN_WIDTH) ? self.width - self.contentSize.width-10 : 0
            
            let offsetX = self.contentOffset.x - self.contentSize.width +  self.width-10 - scrWidth;
            self.footerView?.offsetX = offsetX;
            self.footerView?.setNeedsDisplay()
            if (self.isDragging) { // 拖动
                if (offsetX >= (self.footerView?.width)! * 0.6) {
                    self.footerView?.label?.text =  self.footerView?.insertLinefeeds(text: "释放查看")
                }else{
                    self.footerView?.label?.text =  self.footerView?.insertLinefeeds(text: "查看更多")
                }
            } else { // 松开
                
                if (offsetX >= (self.footerView?.width)! * 0.6 ) {
                    didRefreshBlock();
                }else{
                    return;
                }
            }

        }
    }
    
}
