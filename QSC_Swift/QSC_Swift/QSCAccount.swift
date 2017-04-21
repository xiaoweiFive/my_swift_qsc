//
//  QSCAccount.swift
//  QSC_Swift
//
//  Created by zhangzhenwei on 17/4/20.
//  Copyright © 2017年 QSC. All rights reserved.
//

import UIKit

class QSCAccount: NSObject ,NSCoding{
    
    var userName:String?
    var userPhone:String?
    
    
    override init() {
        super.init()
    }
    
    //    MJCodingImplementation
    
    //构造方法
    required init(userName:String="", userPhone:String="") {
        self.userName = userName
        self.userPhone = userPhone
    }
    
    //从object解析回来
    required init(coder decoder: NSCoder) {
        self.userName = decoder.decodeObject(forKey: "userName") as? String ?? ""
        self.userPhone = decoder.decodeObject(forKey: "userPhone") as? String ?? ""
    }
    
    //编码成object
    func encode(with coder: NSCoder) {
        coder.encode(userName, forKey:"userName")
        coder.encode(userPhone, forKey:"userPhone")
    }
    
}
