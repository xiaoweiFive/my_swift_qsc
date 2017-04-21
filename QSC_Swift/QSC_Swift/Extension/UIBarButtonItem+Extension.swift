//
//  UIBarButtonItem+Extension.swift
//  english_Demo_swift
//
//  Created by zhangzhenwei on 17/1/3.
//  Copyright © 2017年 zhangzhenwei. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    class func itemWithTarget(target: AnyObject, action: Selector, icon:String, highlightedIcon:String) -> UIBarButtonItem{
        
        let btn = UIButton(type: .custom)
        
        btn.setBackgroundImage(UIImage(named: icon), for: .normal)
        btn.setBackgroundImage(UIImage(named: highlightedIcon), for: .highlighted)
        btn.setBackgroundImage(UIImage(named: highlightedIcon), for: .selected)
        btn.addTarget(target, action: action, for:.touchUpInside)
        btn.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        let barButtonItem = UIBarButtonItem(customView: btn)
        
        return barButtonItem
        
    }
}
