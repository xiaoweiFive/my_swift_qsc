//
//  QSCHomeNavigationViewController.swift
//  QSC_Swift
//
//  Created by zhangzhenwei on 17/4/20.
//  Copyright © 2017年 QSC. All rights reserved.
//

import UIKit
import SwiftyJSON

class QSCHomeNavigationViewController: UIViewController{

    
    var  middelButton:UIButton?
    var  circleView: CirCleView!
    var  bannerModel = Array<QSCHomeListDesc>()

    var  bannerCell:ZZWHomeBannerTableViewCell?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        
        let cellID:String = "ZZWHomeBannerTableViewCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = Bundle.main.loadNibNamed("ZZWHomeBannerTableViewCell", owner: self, options: nil)?.last as! ZZWHomeBannerTableViewCell
            cell?.selectionStyle = .none
        }
        
        cell?.frame = CGRect(x: 0, y: -0.5, width: SCREEN_WIDTH, height: 160*RATE)
        bannerCell = cell as! ZZWHomeBannerTableViewCell?;
        self.view.addSubview(cell!)
        
        
        //创建一个重用的单元格
        self.tableView.register(UINib(nibName:"QSCHomeCategoryTableViewCell", bundle:nil),
                                 forCellReuseIdentifier:"QSCHomeCategoryTableViewCell")
        

        
        self.automaticallyAdjustsScrollViewInsets = false
        
        
        self.circleView = CirCleView(frame: CGRect(x: 0, y: 64, width: self.view.frame.size.width, height: 200))
        circleView.delegate = self
        self.view.addSubview(circleView)
  
        
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.requestData()
    }
    
    
    lazy var tableView:UITableView = {
        
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 160*RATE, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-49), style: .grouped)
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

        if homeNavModel.area == "nav" {
//            let cell = QSCHomeCategoryTableViewCell.cellWithTableView(tableView: tableView)
            
            let cellID = "QSCHomeCategoryTableViewCell"
            var cell =  tableView.dequeueReusableCell(withIdentifier: cellID) as! QSCHomeCategoryTableViewCell
            if cell == nil {
                cell = Bundle.main.loadNibNamed(cellID, owner: self, options: nil)?.last as! QSCHomeCategoryTableViewCell
                cell.selectionStyle = .none
            }
            cell.homeNavModel = homeNavModel
            cell.updateStyle()

            return cell
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
