//
//  QSCHomeCategoryTableViewCell.swift
//  QSC_Swift
//
//  Created by zhangzhenwei on 17/4/21.
//  Copyright © 2017年 QSC. All rights reserved.
//

import UIKit

let  TYPE_BANNER_HEIGHT = 160*RATE
let  TYPE_INSURANCE_HEIGHT = 135*RATE
let  TYPE_RECOMMEND_HEIGHT = 207*RATE
let  TYPE_Category_HEIGHT = 100 * RATE
let  TYPE_NAV_HEIGHT = 90 * RATE


class QSCHomeCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var KKcollectionView: UICollectionView!
    
    
    
    
    class func cellWithTableView(tableView:UITableView)->(QSCHomeCategoryTableViewCell){
        let cellID = "QSCHomeCategoryTableViewCell"
        var cell =   tableView.dequeueReusableCell(withIdentifier: cellID) as! QSCHomeCategoryTableViewCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed(cellID, owner: self, options: nil)?.last as! QSCHomeCategoryTableViewCell
            cell.selectionStyle = .none
            cell .updateStyle()
        }
        return cell
    }
    
    
    var homeNavModel:QSCHomeModel?{
        didSet{
            self.KKcollectionView.reloadData()
        }
    }
    
    
    
    func updateStyle()  {
        self.KKcollectionView.backgroundColor = UIColor.clear
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = .horizontal
        let maxImageW = (SCREEN_WIDTH-20)/5
        let maxImageH = TYPE_Category_HEIGHT; // 固定高
        flowLayout.itemSize = CGSize(width: maxImageW, height: maxImageH)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        self.KKcollectionView.collectionViewLayout = flowLayout
        self.KKcollectionView.showsHorizontalScrollIndicator = false
        self.KKcollectionView.register(UINib.init(nibName: "QSCHomeCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "QSCHomeCategoryCollectionViewCell")
        self.KKcollectionView.delegate = self
        self.KKcollectionView.dataSource = self
        
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension QSCHomeCategoryTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.homeNavModel?.list.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QSCHomeCategoryCollectionViewCell", for: indexPath) as! QSCHomeCategoryCollectionViewCell
                
        cell.desc = self.homeNavModel?.list[indexPath.item]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("0-0-0-0-0-0-0-0-0-0-0")
    }
    
    
}
