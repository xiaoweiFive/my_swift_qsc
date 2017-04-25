//
//  QSCRefreshComponent.swift
//  QSC_Swift
//
//  Created by zhangzhenwei on 17/4/25.
//  Copyright © 2017年 QSC. All rights reserved.
//

import UIKit


let  MJRefreshLabelLeftInset:CGFloat = 25;
let  MJRefreshHeaderHeight:CGFloat = 54.0;
let  MJRefreshFooterHeight:CGFloat = 44.0;
let  MJRefreshFastAnimationDuration:CGFloat = 0.25;
let  MJRefreshSlowAnimationDuration:CGFloat = 0.4;

let MJRefreshKeyPathContentOffset:String = "contentOffset";
let MJRefreshKeyPathContentInset:String = "contentInset";
let MJRefreshKeyPathContentSize:String = "contentSize";
let MJRefreshKeyPathPanState:String = "state";

let MJRefreshHeaderLastUpdatedTimeKey:String = "MJRefreshHeaderLastUpdatedTimeKey";

let MJRefreshHeaderIdleText:String = "MJRefreshHeaderIdleText";
let MJRefreshHeaderPullingText:String = "MJRefreshHeaderPullingText";
let MJRefreshHeaderRefreshingText:String = "MJRefreshHeaderRefreshingText";

let MJRefreshAutoFooterIdleText:String = "MJRefreshAutoFooterIdleText";
let MJRefreshAutoFooterRefreshingText:String = "MJRefreshAutoFooterRefreshingText";
let MJRefreshAutoFooterNoMoreDataText:String = "MJRefreshAutoFooterNoMoreDataText";

let MJRefreshBackFooterIdleText:String = "MJRefreshBackFooterIdleText";
let MJRefreshBackFooterPullingText:String = "MJRefreshBackFooterPullingText";
let MJRefreshBackFooterRefreshingText:String = "MJRefreshBackFooterRefreshingText";
let MJRefreshBackFooterNoMoreDataText:String = "MJRefreshBackFooterNoMoreDataText";

let MJRefreshHeaderLastTimeText:String = "MJRefreshHeaderLastTimeText";
let MJRefreshHeaderDateTodayText:String = "MJRefreshHeaderDateTodayText";
let MJRefreshHeaderNoneLastDateText:String = "MJRefreshHeaderNoneLastDateText";

enum QSCRefreshState {
    /** 普通闲置状态 */
  case  QSCRefreshStateIdle
    /** 松开就可以进行刷新的状态 */
  case  QSCRefreshStatePulling
    /** 正在刷新中的状态 */
   case QSCRefreshStateRefreshing
    /** 即将刷新的状态 */
   case QSCRefreshStateWillRefresh
    /** 所有数据加载完毕，没有更多的数据了 */
   case  QSCRefreshStateNoMoreData
}

/** 进入刷新状态的回调 */
typealias QSCRefreshComponentRefreshingBlock = ()->()
/** 开始刷新后的回调(进入刷新状态后的回调) */
typealias QSCRefreshComponentbeginRefreshingCompletionBlock = ()->()
/** 结束刷新后的回调 */
typealias QSCRefreshComponentEndRefreshingCompletionBlock = ()->()


/** 刷新控件的基类 */
class QSCRefreshComponent: UIView {
    
    var scrollViewOriginalInset:UIEdgeInsets?
    var scrollView:UIScrollView?
    var refreshingBlock:QSCRefreshComponentRefreshingBlock?
    var pan:UIPanGestureRecognizer?

    
    
    var state:QSCRefreshState? {
        didSet{
            DispatchQueue.main.async {
                self.setNeedsLayout()
            }
        }
    }

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.prepare()
        self.state = QSCRefreshState.QSCRefreshStateIdle
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func prepare()  {
        self.autoresizingMask = UIViewAutoresizing.flexibleWidth
        self.backgroundColor = UIColor.clear
    }
    
    override func layoutSubviews() {
        self.placeSubviwes()
        super.layoutSubviews()
    }
    
    func placeSubviwes() {
    
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if (newSuperview != nil) && !(newSuperview?.isKind(of: UIScrollView.self))! {
            return
        }
        self.removeObservers()
        if (newSuperview != nil) {
            self.width  = (newSuperview?.width)!
            self.x = 0;
            
            // 记录UIScrollView
           scrollView = newSuperview as? UIScrollView
            scrollView?.alwaysBounceVertical = true
            scrollViewOriginalInset = scrollView?.contentInset
            self.addObservers()
        }
        
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if self.state == QSCRefreshState.QSCRefreshStateWillRefresh {
            self.state = QSCRefreshState.QSCRefreshStateRefreshing

        }
    }
    
    //MARK: - KVO监听
    func addObservers() {
        let option: NSKeyValueObservingOptions = [.new, .old]
        scrollView?.addObserver(self, forKeyPath: MJRefreshKeyPathContentOffset, options: option, context: nil)
        scrollView?.addObserver(self, forKeyPath: MJRefreshKeyPathContentSize, options: option, context: nil)
        self.pan = self.scrollView?.panGestureRecognizer
        self.pan?.addObserver(self, forKeyPath: MJRefreshKeyPathPanState, options: option, context: nil)
    }

    func removeObservers()  {
        self.superview?.removeObserver(self, forKeyPath: MJRefreshKeyPathContentOffset)
        self.superview?.removeObserver(self, forKeyPath: MJRefreshKeyPathContentSize)
        self.pan?.removeObserver(self, forKeyPath: MJRefreshKeyPathPanState)
        self.pan = nil
    }
    
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if self.isUserInteractionEnabled == false  || self.isHidden == true{
            return
        }
        if  keyPath == MJRefreshKeyPathContentSize {
            self.scrollViewContentSizeDidChange(change: change!)
        }
        if  keyPath == MJRefreshKeyPathContentOffset {
            self.scrollViewContentOffsetDidChange(change: change!)
        }else if  keyPath == MJRefreshKeyPathPanState {
            self.scrollViewPanStateDidChange(change: change!)
        }
        
    }
    
    func scrollViewContentOffsetDidChange(change:[NSKeyValueChangeKey:Any]) {
    }
    func scrollViewContentSizeDidChange(change:[NSKeyValueChangeKey:Any]) {
    }
    func scrollViewPanStateDidChange(change:[NSKeyValueChangeKey:Any]) {
    }
    
    
    func beginRefreshing()  {
        UIView.animate(withDuration: 0.25) { 
            self.alpha = 1.0
        }
        
        if self.window != nil {
            self.state = QSCRefreshState.QSCRefreshStateRefreshing
        }else{
            // 预防正在刷新中时，调用本方法使得header inset回置失败
            if (self.state != QSCRefreshState.QSCRefreshStateRefreshing) {
                self.state = QSCRefreshState.QSCRefreshStateWillRefresh;
                // 刷新(预防从另一个控制器回到这个控制器的情况，回来要重新刷新一下)
                self.setNeedsDisplay()
            }
        }
        
    }
    
    
    func endRefresing()  {
        self.state = QSCRefreshState.QSCRefreshStateIdle
    }
    
    
    func isRefreshing() -> Bool {
        if self.state == QSCRefreshState.QSCRefreshStateRefreshing  ||  self.state == QSCRefreshState.QSCRefreshStateWillRefresh{
            return true
        }
        return false
    }
    
    
    
    
    
}
