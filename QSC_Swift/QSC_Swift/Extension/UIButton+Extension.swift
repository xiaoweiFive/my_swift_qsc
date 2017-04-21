//
//  UIButton+Extension.swift
//  english_Demo_swift
//
//  Created by zhangzhenwei on 17/1/16.
//  Copyright © 2017年 zhangzhenwei. All rights reserved.
//

import UIKit

extension UIButton {
    
    class func sizeOfLabel(customMaxWidth: CGFloat,systemFontSize: CGFloat,filledTextString: String) -> CGSize {
        
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: customMaxWidth, height: 0))
        label.text = filledTextString
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: systemFontSize)
        label.sizeToFit()
        
        let size = label.frame.size
        
        return size
    }
    
}
