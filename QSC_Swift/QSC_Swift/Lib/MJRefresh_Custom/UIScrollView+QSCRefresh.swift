//
//  UIScrollView+QSCRefresh.swift
//  QSC_Swift
//
//  Created by zhangzhenwei on 17/4/25.
//  Copyright © 2017年 QSC. All rights reserved.
//

import UIKit


extension UIScrollView{
    
    var QSC_ReloadDataBlock:(_ totalDataCount:NSInteger)->()?{
        set {
            self.willChangeValue(forKey: "QSC_ReloadDataBlock")
            
            let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "QSC_RefreshReloadDataBlockKey".hashValue)
            objc_setAssociatedObject(self, key, newValue, .OBJC_ASSOCIATION_RETAIN)
            
            self.didChangeValue(forKey: "QSC_ReloadDataBlock")
        }
        
        get {
            let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "QSC_RefreshReloadDataBlockKey".hashValue)
            
            return objc_getAssociatedObject(self, key) as! (NSInteger) -> ()?
        }
    }
    
    func executeReloadDataBlock() {
            self.mj_reloadDataBlock?(self.QSC_totalDataCount())
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
    
    func QSC_totalDataCount() -> NSInteger {
        var totalCount:NSInteger = 0
        if self.isKind(of: UITableView.self) {
            let tableView = self as! UITableView
            for i in 0...tableView.numberOfSections{
                totalCount += tableView.numberOfRows(inSection: i)
            }
        }
        else if self.isKind(of: UICollectionView.self){
            let collectionView = self as! UICollectionView
            for i in 0...collectionView.numberOfSections{
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
        self.executeReloadDataBlock()
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
        self.executeReloadDataBlock()
    }
}
