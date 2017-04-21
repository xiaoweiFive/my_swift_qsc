//
//  QSCHomeModel.swift
//  QSC_Swift
//
//  Created by zhangzhenwei on 17/4/21.
//  Copyright © 2017年 QSC. All rights reserved.
//

import UIKit
import SwiftyJSON

class QSCHomeModel: NSObject {
    var area: String?
    var margin_bottom: String?
    var header: QSCHomeHeader?
    var list = Array<QSCHomeListDesc>()
    
    
//    var project_list: [AnyObject]?
    
    init(dict:JSON) {
        self.area = dict["area"].stringValue
        self.margin_bottom = dict["margin_bottom"].stringValue
        self.header = QSCHomeHeader.init(dict: dict["header"])

        
        var list = Array<QSCHomeListDesc>()
        for (_,subJson):(String,JSON) in dict["list"] {
            let model = QSCHomeListDesc.init(dict: subJson)
            list.append(model)
        }
        self.list = list
    }
}

class QSCHomeHeader: NSObject {
    var title: String?
    var more: QSCHomeMore?
    
    init(dict:JSON) {
        self.title = dict["title"].stringValue
        self.more = QSCHomeMore.init(dict: dict["more"])
    }
}

class QSCHomeMore: NSObject {
    var title: String?
    var url: String?
    
    init(dict:JSON) {
        self.title = dict["title"].stringValue
        self.url = dict["url"].stringValue
    }
}

class QSCHomeListDesc: NSObject {
    var title: String?
    var name: String?
    var image: String?
    var type_area: String?
    var url: String?
    
    init(dict:JSON) {
        self.title = dict["title"].stringValue
        self.name = dict["name"].stringValue
        self.image = dict["image"].stringValue
        self.type_area = dict["type_area"].stringValue
        self.url = dict["url"].stringValue
    }
    
}
