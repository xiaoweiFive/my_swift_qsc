
//
//  UIImage+Extension.swift
//  english_Demo_swift
//
//  Created by zhangzhenwei on 17/4/20.
//  Copyright © 2017年 zhangzhenwei. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func createImageWithColor(color : UIColor) -> UIImage {
        
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
         context?.setFillColor(color.cgColor)
        context?.addRect(rect)
        let theImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return theImage!
        
    }
    
}
