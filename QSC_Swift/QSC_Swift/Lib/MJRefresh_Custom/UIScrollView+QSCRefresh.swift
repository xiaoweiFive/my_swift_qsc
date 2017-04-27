//
//  UIScrollView+QSCRefresh.swift
//  QSC_Swift
//
//  Created by zhangzhenwei on 17/4/25.
//  Copyright © 2017年 QSC. All rights reserved.
//

typealias QSCReloadDataBlock = (_ totalDataCount:NSInteger)->Void
let  QSCAllDataCountBlock = "QSCAllDataCountBlock"

import UIKit


extension UIScrollView{
    
    var QSCReloadDataBlock:QSCReloadDataBlock{
        set {
            self.willChangeValue(forKey: QSCAllDataCountBlock)
            let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: QSCAllDataCountBlock.hashValue)
            objc_setAssociatedObject(self, key, newValue, .OBJC_ASSOCIATION_RETAIN)
            self.didChangeValue(forKey: QSCAllDataCountBlock)
        }
        get {
            let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: QSCAllDataCountBlock.hashValue)
            let obj = objc_getAssociatedObject(self, key) as? QSCReloadDataBlock
          
            return obj!
        }
    }
    
    func QSCExecuteReloadDataBlock() {
        if self.QSC_header == nil &&  self.QSC_footer == nil {
            return
        }
        self.QSCReloadDataBlock(self.QSC_totalDataCount())
    }
    
    ///  推荐写法
    var QSC_header: QSCRefreshHeader? {
        set (newValue){
            if newValue != self.QSC_header {
                self.QSC_header?.removeFromSuperview()
            }
            
            self.insertSubview(newValue!, at: 0)
            let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "QSC_header".hashValue)
            self.willChangeValue(forKey: "QSC_header")
            objc_setAssociatedObject(self, key, newValue, .OBJC_ASSOCIATION_RETAIN)
            self.didChangeValue(forKey: "QSC_header")
        }
        
        get {
            let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "QSC_header".hashValue)
            let obj: QSCRefreshHeader? = objc_getAssociatedObject(self, key) as? QSCRefreshHeader
            return obj
        }
    }
    ///  推荐写法
    var QSC_footer: QSCRefreshFooter? {
        set (newValue){
            if newValue != self.QSC_footer {
                self.QSC_footer?.removeFromSuperview()
            }
            self.insertSubview(newValue!, at: 0)
            let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "QSC_footer".hashValue)
            self.willChangeValue(forKey: "QSC_footer")
            objc_setAssociatedObject(self, key, newValue, .OBJC_ASSOCIATION_RETAIN)
            self.didChangeValue(forKey: "QSC_footer")
        }
        get {
            let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "QSC_footer".hashValue)
            let obj: QSCRefreshFooter? = objc_getAssociatedObject(self, key) as? QSCRefreshFooter
            return obj
        }
    }
    
    
    func QSC_totalDataCount() -> NSInteger {
        var totalCount:NSInteger = 0
        if self.isKind(of: UITableView.self) {
            let tableView = self as! UITableView
            for i in 0..<tableView.numberOfSections{
                totalCount += tableView.numberOfRows(inSection: i)
            }
        }
        else if self.isKind(of: UICollectionView.self){
            let collectionView = self as! UICollectionView
            for i in 0..<collectionView.numberOfSections{
                totalCount += collectionView.numberOfItems(inSection: i)
            }
        }
        return totalCount;
    }
}


extension NSObject{
    class  func exchangeInstanceMethod(method1:Selector ,method2:Selector)->() {
        method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2))
    }
}

extension UITableView{
    
    open override class func initialize() {
        DispatchQueue.once(token: "onceTableView") {
            self.exchangeInstanceMethod(method1: #selector(reloadData), method2: #selector(QSC_reloadData))
        }
    }
    func QSC_reloadData() {
        self.QSC_reloadData()
        self.QSCExecuteReloadDataBlock()
    }
}

extension UICollectionView{
    open override class func initialize() {
        DispatchQueue.once(token: "onceCollectionView") {
            self.exchangeInstanceMethod(method1: #selector(reloadData), method2: #selector(QSC_reloadData))
        }
    }
    func QSC_reloadData() {
        self.QSC_reloadData()
        self.QSCExecuteReloadDataBlock()
    }
}
