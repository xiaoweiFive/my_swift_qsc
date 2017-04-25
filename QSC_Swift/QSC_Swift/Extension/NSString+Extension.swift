//
//  NSString+Extension.swift
//  LXFFM
//
//  Created by Rainy on 2016/11/25.
//  Copyright © 2016年 LXF. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    
    func getTextSize(font:UIFont,size:CGSize) -> CGSize {
        let attributes = [NSFontAttributeName: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = self.boundingRect(with: size, options: option, attributes: attributes, context: nil)
        return rect.size;
    }
    
    func getTextRectSize(text:NSString,font:UIFont,size:CGSize) -> CGRect {
        let attributes = [NSFontAttributeName: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = text.boundingRect(with: size, options: option, attributes: attributes, context: nil)
        //        println("rect:\(rect)");
        return rect;
        
    }
    
    
    //根据开始位置和长度截取字符串
    func subString(start:Int, length:Int = -1)->String {
        var len = length
        if len == -1 {
            len = characters.count - start
        }
        let st = characters.index(startIndex, offsetBy:start)
        let en = characters.index(st, offsetBy:len)
        let range = st ..< en
        
        return substring(with:range)
    }
    
   static func StringToFloat(str:String)->(CGFloat){
        
        let string = str
        var cgFloat: CGFloat = 0
        
    
        if let doubleValue = Double(string)
        {
            cgFloat = CGFloat(doubleValue)
        }
        return cgFloat
    }
    
   static func stringToInt(str:String)->(Int){
        
        let string = str
        var int: Int?
        if let doubleValue = Int(string) {
            int = Int(doubleValue)
        }
        if int == nil
        {
            return 0
        }
        return int!
    }
}
