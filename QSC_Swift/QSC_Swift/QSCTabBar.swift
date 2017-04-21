//
//  QSCTabBar.swift
//  english_Demo_swift
//
//  Created by zhangzhenwei on 17/4/19.
//  Copyright © 2017年 zhangzhenwei. All rights reserved.
//

import UIKit

protocol QSCTabBarDelegate:NSObjectProtocol {
    func tabBarDidSelectButtonFrom(tabbar:QSCTabBar , from:Int , to:Int)
//    func tabBarDidDoubleSelectButtonFrom(tabbar:QSCTabBar , from:Int , to:Int)

}

class QSCTabBar: UIButton {
    
    let KTabbarNumber:Int = 5
    var tabBarButtonCount:Int = 0
    var  selectedBtn:QSCBarButton?
    var  middelButton:UIButton?
    
    
    weak var delegate:QSCTabBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 0.5))
        lineView.backgroundColor = zzwColor(red: 238, green: 239, blue: 240, alpha: 1)
        self.addSubview(lineView)
        self.backgroundColor = UIColor.white
        self.tag = 101

        
    }
    
    override func layoutSubviews() {
}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTabBarButtonWithItem(item:UITabBarItem) {
        if tabBarButtonCount >= KTabbarNumber {
            return
        }
        
        let btn = QSCBarButton()
        let btnH = self.frame.size.height
        let btnW = self.frame.size.width/(CGFloat(Float(KTabbarNumber)))
        let btnX = btnW * (CGFloat(Float(tabBarButtonCount)))
        btn.frame = CGRect(x: btnX, y: 0, width: btnW, height: btnH)
        btn.clipsToBounds = true
        if tabBarButtonCount == 2 {
            btn.frame = CGRect(x: btnX, y: -18, width: btnW, height: btnH+18)
            middelButton = btn;
        }
        btn.item = item;
        
        btn.addTarget(self, action:#selector(btnClick(_:)) , for: .touchUpInside)
        btn.addTarget(self, action:#selector(buttonRepeatClick(_:)) , for: .touchDownRepeat)
        btn.tag = tabBarButtonCount
        if tabBarButtonCount == 0 {
            self.btnClick(btn)
        }
        self.addSubview(btn)
        tabBarButtonCount += 1
    }
    
    func btnClick(_ btn:QSCBarButton)  {
        
        var from:Int = 0
        if ((selectedBtn?.tag) != nil) {
            from = (selectedBtn?.tag)!
        }
        
        self.delegate?.tabBarDidSelectButtonFrom(tabbar: self, from: from, to: Int(btn.tag))
        
        if btn.tag == 0 {
            selectedBtn?.isSelected = false
            btn.isSelected = true
            selectedBtn = btn
        }else if btn.tag == 2 {
            return;
        }else{
            //暂无登录的逻辑
//            let account = QSCAccountTool.share.account
//            if account == nil {
//                btn.isSelected = false;
//            }else{
                selectedBtn?.isSelected = false
                btn.isSelected = true
                selectedBtn = btn
//            }
        }
        
    }
    
    func buttonRepeatClick(_ btn:QSCBarButton)  {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(btnClick(_:)), object: btn)
//        delegate?.tabBarDidDoubleSelectButtonFrom(tabbar: self, from: (selectedBtn?.tag)!, to: btn.tag)
        
    }
    
    //保险tabbar 暂时搁置
    func addPolicyTabBarButtonWithItem(item:UITabBarItem) {
//        if tabBarButtonCount >= 2 {
//            return
//        }
    }
    
    func setSelectedBarButton(barButtonIndex:NSInteger) {
        var tempBtn:AnyObject?
        if barButtonIndex == 0 {
            tempBtn = self.subviews[1]
            
        }else{
            tempBtn = self.viewWithTag(barButtonIndex)
        }
        if (tempBtn != nil) && (tempBtn?.isKind(of: QSCBarButton.self))! {
            let selectedBarBtn = tempBtn as! QSCBarButton
            self.btnClick(selectedBarBtn)
        }
    }
    

    
}
