//
//  config_swift.swift
//  QSC_Swift
//
//  Created by zhangzhenwei on 17/4/20.
//  Copyright © 2017年 QSC. All rights reserved.
//

import UIKit
import MJRefresh

let kFileAccount =  NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first?.appending("account.data")


let SCREEN_BOUNDS = UIScreen.main.bounds
let SCREEN_WIDTH = SCREEN_BOUNDS.width
let SCREEN_HEIGHT = SCREEN_BOUNDS.height
let RATE = SCREEN_WIDTH/375.0


/// 导航栏背景色 - 绿色
let COLOR_NAV_BG = UIColor.colorWithHexString("41ca61")
/// 所有控制器背景颜色 - 偏白
let COLOR_ALL_BG = UIColor.colorWithHexString("f7f7f7")
/// 导航栏ITEM默认 - 白色
let COLOR_NAV_ITEM_NORMAL = UIColor(red:0.95, green:0.98, blue:1.00, alpha:1.00)


let ZZWGrayColor = UIColor.init(r: 245, g: 246, b: 247)
let QSCTextColor = UIColor.init(r: 67, g: 172, b: 67)




func zzwColor(red: Int, green: Int, blue: Int, alpha: CGFloat) -> (UIColor){
    return UIColor(red: CGFloat(red)/CGFloat(255), green: CGFloat(green)/CGFloat(255), blue: CGFloat(blue)/CGFloat(255), alpha: alpha)
}
