//
//  QSCBezierView.swift
//  QSC_Swift
//
//  Created by zhangzhenwei on 17/4/25.
//  Copyright © 2017年 QSC. All rights reserved.
//

import UIKit

// 查看更多LBL 宽度
let MORE_LBL_WIDTH:CGFloat = 33
let CONTROL_WIDTH:CGFloat = 110
let BACKGROUNDCOLOR = zzwColor(red: 245, green: 246, blue: 247, alpha: 1)

class QSCBezierView: UIView {

    
    var leftView:UIView?
    var offsetX:CGFloat? = 0
    var shapeL:CAShapeLayer?
    var label:UILabel?
    
    var leftViewFrame:CGRect?{
        didSet{
            self.frame = leftViewFrame!
            DispatchQueue.main.async { 
                self.leftView?.frame = CGRect(x: 0, y: 0, width: self.width - MORE_LBL_WIDTH, height: self.height)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.creatUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func creatUI()  {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: self.width - MORE_LBL_WIDTH, height: self.height))
        leftView.backgroundColor = UIColor.clear
        self.addSubview(leftView)
        self.leftView = leftView
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: MORE_LBL_WIDTH, height: self.height))
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = zzwColor(red: 102, green: 102, blue: 102, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 13)
        label.backgroundColor = BACKGROUNDCOLOR
        self.label = label
        self.addSubview(label)
    }
    
    
    override func draw(_ rect: CGRect) {
        if Int(self.offsetX!) > Int(MORE_LBL_WIDTH) {
            self.label?.x = self.offsetX!-MORE_LBL_WIDTH
        }
        
        let ref = UIGraphicsGetCurrentContext()
        let kRadius = MORE_LBL_WIDTH
        let centerY = self.height/2 - kRadius/2;
        
        ref?.addEllipse(in: CGRect(x: 0, y: centerY, width: kRadius, height: kRadius))
        BACKGROUNDCOLOR.set()
        ref?.fillPath()
        
        
        if (self.shapeL != nil) {
            self.shapeL?.removeFromSuperlayer()
        }
        let shapeL = CAShapeLayer()
        
        self.shapeL = shapeL
        let path =  UIBezierPath()
        let kY =  centerY;
        let startY =  kY; //- kRadius/2;
        let bWidth = self.width - MORE_LBL_WIDTH;
        let moveX = (bWidth - kRadius)/2 + self.offsetX!/2;
        let startX = self.label?.x;
        
        //初始点
        path.move(to: CGPoint(x: kRadius/2, y: startY))
        // CurveToPoint  终点  control 控制点
        
        
        let  controlY = self.offsetX! > CONTROL_WIDTH ? CONTROL_WIDTH/4 : self.offsetX!/4;
        
        path.addQuadCurve(to: CGPoint(x: startX!, y: startY - self.offsetX!/5), controlPoint: CGPoint(x: moveX, y: startY + controlY))
        
        path.addLine(to: CGPoint(x: startX!, y: startY + kRadius + self.offsetX!/5))
        
        path.addQuadCurve(to: CGPoint(x: kRadius/2, y: startY + kRadius), controlPoint: CGPoint(x: moveX, y: startY + kRadius -  controlY))
        path.close()
        
        shapeL.path = path.cgPath
        
        shapeL.fillColor = BACKGROUNDCOLOR.cgColor
        self.leftView?.layer.addSublayer(shapeL)
        
        
    }
    
    
    func insertLinefeeds(text:String)->String {
        let newStr = NSMutableString()
        
        for i in 0..<text.characters.count{
            
            let str = text.subString(start: i, length: 1)
            newStr.append(str)
            if i != text.characters.count-1 {
                newStr.append("\n")
            }
        }
        return newStr as String
    }
}
