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
        
        QSC_MJRefreshGifTool.MJRefreshGifCustomBlock(tableView:tableView) { 
            sleep(2)
            self.requestData()
            print("010010101010010101010101001010")
        }
        self.view.addSubview(tableView)

        
        self.circleView = CirCleView(frame: CGRect(x: 0, y: -0.5, width: self.view.frame.size.width, height: 160*RATE))
        circleView.delegate = self
        self.view.addSubview(circleView)
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
                    self.bannerImageArray.removeAll()
                    self.bannerModel = header
                    for desc in header{
                        self.bannerImageArray.append(desc.image!)
                    }
                    self.circleView.urlImageArray = self.bannerImageArray
                }
            }
            
            self.tableView.reloadData()
            self.tableView.mj_header.endRefreshing()

        }) { (error) in
            print(error)
            self.tableView.mj_header.endRefreshing()

        }
    }

}


extension QSCHomeNavigationViewController:CirCleViewDelegate{
    func clickCurrentImage(_ currentIndxe: Int) {
        
        let model = self.bannerModel[currentIndxe]
        print(model.url ?? "无url");
    }
    
}

extension QSCHomeNavigationViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !scrollView.isKind(of: UITableView.self) {
            return
        }
        
        let offsetY = scrollView.contentOffset.y
        
        
//        if offsetY < 0 {
//            UIApplication.shared.statusBarStyle = .lightContent
//        }else  {
//            UIApplication.shared.statusBarStyle = .default
//        }
        
        if offsetY > -TYPE_BANNER_HEIGHT {
            self.circleView.y = -TYPE_BANNER_HEIGHT - offsetY
            
        }else if offsetY < -TYPE_BANNER_HEIGHT {
            self.circleView.y = 0
        }
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
        
        let margin_height = String.StringToFloat(str: homeNavModel.margin_bottom!)
        
        if (indexPath.row == 1 && homeNavModel.area != "recommend-love-project"){
            return margin_height
        }
        
        if homeNavModel.area == "nav" {
            return 100
        }
        if homeNavModel.area == "banner" {
            return 0;
        }
        if homeNavModel.area == "insurance" {
            return 135;
        }
        if homeNavModel.area == "recommend" || homeNavModel.area == "sale-recommend" || homeNavModel.area == "love-recommend" || homeNavModel.area == "dream-recommend"  {
            return 207;
        }
        else if homeNavModel.area == "sale-nav" || homeNavModel.area == "dream-nav" {
            return 90
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
                let cell =  QSCHomeCategoryTableViewCell.cellWithTableView(tableView: tableView)
                cell.homeNavModel = homeNavModel
                return cell
            
            }else if homeNavModel.area == "sale-nav" || homeNavModel.area == "dream-nav" {
                let cell =  QSCHomeNavTableViewCell.cellWithTableView(tableView: tableView)
                cell.homeNavModel = homeNavModel
                return cell
            }else if homeNavModel.area == "insurance" {
                let cell =  QSCHomeInsuranceTableViewCell.cellWithTableView(tableView: tableView)
                cell.homeNavModel = homeNavModel
                return cell
            }else if homeNavModel.area == "recommend" || homeNavModel.area == "dream-recommend" || homeNavModel.area == "sale-recommend" || homeNavModel.area == "love-recommend" {
                let cell =  QSCHomeRecommendTableViewCell.cellWithTableView(tableView: tableView)
                cell.homeNavModel = homeNavModel
                return cell
            }
                
                
            else if homeNavModel.area == "banner" {
                return UITableViewCell()
                
            }
        }else if (indexPath.row == 1 && homeNavModel.area != "recommend-love-project"){
            
            let heigh = String.StringToFloat(str: homeNavModel.margin_bottom!)
            let footerView =  QSCHomeFooterTableViewCell.cellWithTableView(tableView: tableView)
            if heigh == 1 {
                footerView.contentView.backgroundColor = UIColor.white
                footerView.backView.backgroundColor = zzwColor(red: 229, green: 229, blue: 229, alpha: 1)
            }else{
                footerView.backView.backgroundColor = ZZWGrayColor
                footerView.contentView.backgroundColor = ZZWGrayColor
            }
            return footerView
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
