//
//  QSCHomeNavigationViewController.swift
//  QSC_Swift
//
//  Created by zhangzhenwei on 17/4/20.
//  Copyright © 2017年 QSC. All rights reserved.
//

import UIKit
import SwiftyJSON
import MJRefresh


class QSCHomeNavigationViewController: UIViewController{

    let homeCategoryCellID = "QSCHomeCategoryTableViewCell"

    var  middelButton:UIButton?
    var  circleView: CirCleView!
    var  bannerModel = Array<QSCHomeListDesc>()
    var  bannerCell:ZZWHomeBannerTableViewCell?
    //imageArray
    var idleImages:NSMutableArray = []
    var objectArr = [String]()
    var refreshingImages:NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(tableView)

        //下拉过程时的图片集合(根据下拉距离自动改变)
        var idleImages = [UIImage]()
        for i in 1...2 {
            idleImages.append(UIImage(named:"load_\(i)")!)
        }
        
        for i in 1...10 {
            self.objectArr.append("\(i)")
        }
        
        // 设置普通状态的动画图片
      for i in 1...10 {
        let image:UIImage = UIImage(named: "load_\(i)")! as UIImage
        idleImages.append(image)
        }

        let header:MJRefreshGifHeader = MJRefreshGifHeader.init {
            
            sleep(2)
           
            //结束刷新
            self.tableView.mj_header.endRefreshing()
        }
        //设置普通状态动画图片
        header.setImages(idleImages as [AnyObject], for: MJRefreshState.idle)
        //设置下拉操作时动画图片
//        header.setImages(idleImages as [AnyObject], for: MJRefreshState.pulling)
        //设置正在刷新时动画图片
        header.setImages(idleImages as [AnyObject], for: MJRefreshState.refreshing)
        
        header.lastUpdatedTimeLabel.isHidden = true
//        header.stateLabel.isHidden = true
        header.setTitle("1111", for: MJRefreshState.idle)
        header.setTitle("", for: MJRefreshState.pulling)
        header.setTitle("333333333", for: MJRefreshState.refreshing)
        
        self.tableView.mj_header = header
        
        
        self.circleView = CirCleView(frame: CGRect(x: 0, y: -0.5, width: self.view.frame.size.width, height: 160*RATE))
        circleView.delegate = self
        self.view.addSubview(circleView)
        //创建一个重用的单元格
        self.tableView.register(UINib(nibName:"QSCHomeCategoryTableViewCell", bundle:nil), forCellReuseIdentifier:homeCategoryCellID)
        
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true

        self.requestData()
    }
    
    
    lazy var tableView:UITableView = {
        
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-49), style: .plain)
        tableView.backgroundColor = ZZWGrayColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.scrollsToTop = true
        tableView.contentInset = UIEdgeInsetsMake(160*RATE, 0, 0, 0 )
        return tableView
    }()
    
    lazy var indexModelArray:NSMutableArray = {
        let indexmodelArray:NSMutableArray = []
        return indexmodelArray
    }()
    lazy var bannerImageArray:[String] = {
        let indexmodelArray:[String] = []
        return indexmodelArray
    }()
    
    func requestData()  {
        ZZWHttpTools.share.getWithPath(path: "http://index.qschou.com/v2.1.1/home", parameters: nil, success: { (json) in
            
            print(json)
            
            if(self.indexModelArray.count > 0){
                self.indexModelArray.removeAllObjects()
            }
                        
            for (_,subJosn):(String,JSON) in json["data"]{
                let topic = QSCHomeModel.init(dict: subJosn)
                self.indexModelArray.add(topic)
                
                if topic.area == "banner" {
                    let header = topic.list
                    self.bannerModel = header
                    for desc in header{
                        self.bannerImageArray.append(desc.image!)
                    }
                    self.circleView.urlImageArray = self.bannerImageArray
                }
            }
            
            self.tableView.reloadData()
        }) { (error) in
            print(error)
        }
    }

}


extension QSCHomeNavigationViewController:CirCleViewDelegate{
    func clickCurrentImage(_ currentIndxe: Int) {
        
        let model = self.bannerModel[currentIndxe]
        print(model.url ?? "无url");
    }
    
}


// MARK: - UITableViewDataSource, UITableViewDelegate
extension QSCHomeNavigationViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.indexModelArray.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let homeNavModel = self.indexModelArray[indexPath.section] as! QSCHomeModel
        if homeNavModel.area == "nav" {
            return 100
        }
        if homeNavModel.area == "banner" {
            return 0;
        }

        
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let homeNavModel = self.indexModelArray[indexPath.section] as! QSCHomeModel
        
        if indexPath.row == 0 && homeNavModel.area != "recommend-project" && indexPath.section>0 {
            
            if homeNavModel.area == "nav" {
                
                let cell =  tableView.dequeueReusableCell(withIdentifier: homeCategoryCellID) as! QSCHomeCategoryTableViewCell
                cell.selectionStyle = .none
                cell.homeNavModel = homeNavModel
                cell.updateStyle()
                return cell
            }else if homeNavModel.area == "banner" {
                return UITableViewCell()
                
            }
            
        }
        
        let identifier="identtifier";
        var cell=tableView.dequeueReusableCell(withIdentifier: identifier)
        if(cell == nil){
            cell=UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: identifier);
        }
        cell?.selectionStyle = .none
        cell?.textLabel?.text = "3243242342\(indexPath)";
        cell?.detailTextLabel?.text = "待添加内容";
        cell?.detailTextLabel?.font = UIFont .systemFont(ofSize: CGFloat(13))
        cell?.accessoryType=UITableViewCellAccessoryType.disclosureIndicator
        return cell!
    }
}
