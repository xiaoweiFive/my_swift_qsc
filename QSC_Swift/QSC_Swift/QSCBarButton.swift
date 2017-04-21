//
//  QSCBarButton.swift
//  english_Demo_swift
//
//  Created by zhangzhenwei on 17/4/19.
//  Copyright © 2017年 zhangzhenwei. All rights reserved.
//

import UIKit

class QSCBarButton: UIButton {
    
    let QSCTabBarButtonImageRatio:CGFloat = 0.65

    var badgeValueBtn:UIButton?
    var item:UITabBarItem?{
        
       didSet{
            item?.addObserver(self, forKeyPath: "title", options: .new, context: nil)
            item?.addObserver(self, forKeyPath: "image", options: .new, context: nil)
            item?.addObserver(self, forKeyPath: "selectedImage", options: .new, context: nil)
            item?.addObserver(self, forKeyPath: "badgeValue", options: .new, context: nil)
            self.observeValue(forKeyPath: nil, of: nil, change: nil, context: nil)
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 1.图片居中
        self.imageView?.contentMode = .center
        
        // 2.文字居中
        self.titleLabel?.textAlignment = .center;
        self.titleLabel?.font = UIFont.systemFont(ofSize: 11.0)
        
        // 3.设置选中时的背景图片
        badgeValueBtn?.setBackgroundImage(UIImage.init(named: "tabbar_slider"), for: .selected)
        
        // 4.添加一个显示红色提醒数字的按钮
        badgeValueBtn = UIButton(type: .custom)
        badgeValueBtn?.setBackgroundImage(UIImage.init(named: "main_badge"), for: .normal)
        badgeValueBtn?.isUserInteractionEnabled = false
        badgeValueBtn?.isHidden = true
        badgeValueBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
        badgeValueBtn?.titleLabel?.textAlignment = .center
        self.addSubview((badgeValueBtn)!)
        
        // 5.设置问题状态颜色
        self.setTitleColor(zzwColor(red: 153, green: 153, blue: 153, alpha: 1), for: .normal)
        self.setTitleColor(QSCTextColor, for: .selected)
    }
    
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let titleH = contentRect.size.height * (1 - QSCTabBarButtonImageRatio);
        let titleW = contentRect.size.width;
        let titleY = contentRect.size.height * QSCTabBarButtonImageRatio;
        return CGRect(x: 0, y: titleY, width: titleW, height: titleH)
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let imageW = contentRect.size.width;
        let imageH = contentRect.size.height * 0.75;
        return CGRect(x: 0, y: 0, width: imageW, height: imageH)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.setTitle(item?.title, for: .normal)
        self.setImage(item?.image, for: .normal)
        self.setImage(item?.selectedImage, for: .selected)
        
        if self.tag == 3 {
            if Int((item?.badgeValue)!)!  > 0 {
                badgeValueBtn?.isHidden = false
                var tempString:String?
                if Int((item?.badgeValue)!)! > 99 {
                    tempString = "99+"
                }else{
                    tempString = item?.badgeValue
                }
                
                badgeValueBtn?.setTitle(tempString, for: .normal)
                
                let size = tempString?.getTextSize(font: UIFont.systemFont(ofSize: 13), size: CGSize(width: 1000, height: 1000))
                let btnW = Int((size?.width)!) > 10 ? (size?.width)!+6:16
                var btnX:CGFloat = 0
                if tempString == "99+" {
                    btnX = self.frame.size.width/2
                }else{
                    btnX = self.frame.size.width/2+5
                }
                let btnH:CGFloat = size!.height;
                let btnY:CGFloat = 4;
                badgeValueBtn?.frame = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
                badgeValueBtn?.backgroundColor = UIColor.red
                badgeValueBtn?.layer.cornerRadius = btnH/2
                badgeValueBtn?.layer.masksToBounds = true
            }else{
                badgeValueBtn?.isHidden = true
            }
        }else{
            
            if ((item?.badgeValue) != nil){
                badgeValueBtn?.isHidden = false
                let  btnW:CGFloat = 10;
                let  btnX:CGFloat = self.frame.size.width/2+11;
                let  btnH:CGFloat = 10;
                let  btnY:CGFloat = 8;
                badgeValueBtn?.frame = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
                badgeValueBtn?.backgroundColor = UIColor.red
                badgeValueBtn?.layer.cornerRadius = btnH/2
                badgeValueBtn?.layer.masksToBounds = true
                
            }else{
                badgeValueBtn?.isHidden = true
            }
        }
    }
    
    deinit {
        item?.removeObserver(self, forKeyPath: "title")
        item?.removeObserver(self, forKeyPath: "image")
        item?.removeObserver(self, forKeyPath: "selectedImage")
        item?.removeObserver(self, forKeyPath: "badgeValue")
    }
    
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return true
    }
    
    /**
     处理tabBar子控件的事件响应
     */
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print("111打印打印打印11打印打印打印11打印打印打印11打印打印打印11打印打印打印")
        
        for subView:UIView in self.subviews {
            let newPoint =  self.imageView?.convert(point, to: self)
            if (subView.point(inside: newPoint!, with: event)) {
                return subView
            }
        }
        return super.hitTest(point, with: event)
        
        
        if self.isHidden == false {
            let newPoint =  self.convert(point, to: self)
            if (self.point(inside: newPoint, with: event)) {
                return self
            }else{
                return super.hitTest(point, with: event)
            }
        }
        return super.hitTest(point, with: event)
    }
    
}
