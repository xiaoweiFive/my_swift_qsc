//
//  QSCAccountTool.swift
//  QSC_Swift
//
//  Created by zhangzhenwei on 17/4/20.
//  Copyright © 2017年 QSC. All rights reserved.
//

import UIKit

class QSCAccountTool: NSObject {
    
    var kFile = ((NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)).first)?.appending("account.data")
    
    var account:QSCAccount?
    
    //单例
    static let share = QSCAccountTool()
    
    private override init(){
        //        super.init()
        account = NSKeyedUnarchiver.unarchiveObject(withFile: kFile!) as! QSCAccount?
        
    }
    
    func saveAccount(account:QSCAccount)  {
        self.account = account
        
        NSKeyedArchiver.archiveRootObject(account, toFile: kFile!)
        
        //        UserDefaults.standard.set(self.account?.userName, forKey: "usersAccount")
        //        UserDefaults.standard.synchronize()
    }
    
    
    func QSCIsLogin() -> Bool {
        if (QSCAccountTool.share.account != nil) {
            return true
        }else{
            return false
        }
    }
    
    
    
    func logoutAccont() {
        QSCAccountTool.share.account = nil
        let pathArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let shahePath = pathArray.first;
        let defaultManager = FileManager.default
        var tmpList:[String] = []
        do {
            try tmpList = FileManager.default.contentsOfDirectory(atPath: shahePath!)
        } catch{
        }
        for filename in tmpList {
            print("沙盒文件 " + filename);
            if (!(filename.range(of: "account.data")?.isEmpty)!) {
                let fullpath = shahePath?.appending(filename)
                if defaultManager.isDeletableFile(atPath: fullpath!) {
                    do {
                        try defaultManager.removeItem(atPath: fullpath!)
                    } catch  {
                        
                    }
                }
            }
        }
        
    }

}
