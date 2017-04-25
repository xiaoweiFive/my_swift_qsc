//
//  QSCRuntimeTool.swift
//  QSC_Swift
//
//  Created by zhangzhenwei on 17/4/25.
//  Copyright © 2017年 QSC. All rights reserved.
//

import Foundation


class QSCRuntimeTool:NSObject {

    let addRuntimeProperty = {
        
        
    }
    
    
    class func QSC_setRuntimeAddProperty(myKey:String,newValue:Any) {
        self.willChangeValue(forKey: myKey)
        let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: myKey.hashValue)
        objc_setAssociatedObject(self, key, newValue, .OBJC_ASSOCIATION_RETAIN)
        self.didChangeValue(forKey: myKey)
        
    }
    
    
    class func QSC_getRuntimeAddProperty(myKey:String,propertyClass:String)->AnyClass {
        
        let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: myKey.hashValue)
        
        let obj = objc_getAssociatedObject(self, key)
        
        return obj! as! AnyClass
        
    }


}
