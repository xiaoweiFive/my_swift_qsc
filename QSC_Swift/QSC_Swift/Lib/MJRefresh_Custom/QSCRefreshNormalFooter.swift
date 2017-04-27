//
//  QSCRefreshNormalFooter.swift
//  QSC_Swift
//
//  Created by zhangzhenwei on 17/4/27.
//  Copyright © 2017年 QSC. All rights reserved.
//

import UIKit

class QSCRefreshNormalFooter: QSCRefreshFooter {

    var activityIndicatorViewStyle:UIActivityIndicatorViewStyle? = nil
    
    lazy var loadingView:UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        loading.hidesWhenStopped = true
        return loading
    }()
    
    lazy var stateLabel:UILabel = {
        let stateLabel = UILabel()
        stateLabel.text = "松开加载更多..."

        return stateLabel
    }()

    
    override func placeMySubviwes() {
        let textWidth = self.stateLabel.text?.getTextSize(font: UIFont.systemFont(ofSize: 12), size: CGSize(width: 1000, height: 1000)).width
        
        let loadingCenterX = (self.width - textWidth!)/2 - 10
        let loadingCenterY = self.height/2
        self.loadingView.center = CGPoint(x: loadingCenterX, y: loadingCenterY)
        
        self.stateLabel.frame = CGRect(x: loadingCenterX+self.loadingView.width, y: 0, width: 100, height: self.height)

        self.loadingView.backgroundColor = UIColor.red
        self.stateLabel.backgroundColor = UIColor.green
        self.addSubview(loadingView)
        self.addSubview(stateLabel)

    }
    
    
    override var state: QSCRefreshState?{
        didSet{
            if (state == QSCRefreshState.QSCRefreshStateIdle) {
                self.stateLabel.text = "松开刷新..."
                self.loadingView.stopAnimating()
                print("80394802384023---\(self.scrollView?.contentInset.bottom)")
                print("803333---\(self.y)")
                print("3333333---\(scrollView?.contentSize.height)")
                
                if ((self.scrollView?.contentInset.bottom) != nil) {
                    self.scrollView?.contentInset.bottom -= self.height
                    self.y = (scrollView?.contentSize.height)!
                }


            }else if(state == QSCRefreshState.QSCRefreshStateRefreshing ){
                self.stateLabel.text = "松开刷新.32423.."

                self.loadingView.startAnimating()
                
                if ((self.scrollView?.contentInset.bottom) == nil) {
                    self.scrollView?.contentInset.bottom += self.height
                    self.y = (scrollView?.contentSize.height)!
                }
                

            }
        }
    }
    
    
}
