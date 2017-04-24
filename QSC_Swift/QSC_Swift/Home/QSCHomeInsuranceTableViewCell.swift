//
//  QSCHomeInsuranceTableViewCell.swift
//  QSC_Swift
//
//  Created by zhangzhenwei on 17/4/24.
//  Copyright © 2017年 QSC. All rights reserved.
//

import UIKit

class QSCHomeInsuranceTableViewCell: UITableViewCell {
    @IBOutlet weak var KKcollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    class func cellWithTableView(tableView:UITableView)->(QSCHomeInsuranceTableViewCell){
        
        let cellID = "QSCHomeInsuranceTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) else {
            
            let  newCell = Bundle.main.loadNibNamed(cellID, owner: self, options: nil)?.last as? QSCHomeInsuranceTableViewCell
            newCell?.selectionStyle = .none
            newCell?.updateStyle()
            
            return newCell!
        }
        
        return cell as! (QSCHomeInsuranceTableViewCell)
    }
    
    var homeNavModel:QSCHomeModel?{
        didSet{
            self.KKcollectionView.reloadData()
        }
    }
    
    
    func updateStyle()  {
        self.KKcollectionView.backgroundColor = ZZWGrayColor
        self.KKcollectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 10);

        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = .horizontal
        
        let maxImageW = SCREEN_WIDTH-(SCREEN_WIDTH*0.13)
        let maxImageH = TYPE_INSURANCE_HEIGHT; // 固定高
        flowLayout.itemSize = CGSize(width: maxImageW, height: maxImageH)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        self.KKcollectionView.collectionViewLayout = flowLayout
        self.KKcollectionView.showsHorizontalScrollIndicator = false
        self.KKcollectionView.register(UINib.init(nibName: "QSCHomeInsuranceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "QSCHomeInsuranceCollectionViewCell")
        self.KKcollectionView.delegate = self
        self.KKcollectionView.dataSource = self
        
    }
}


extension QSCHomeInsuranceTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.homeNavModel?.list.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QSCHomeInsuranceCollectionViewCell", for: indexPath) as! QSCHomeInsuranceCollectionViewCell
        
        cell.desc = self.homeNavModel?.list[indexPath.item]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("0-0-0-0-0-0-0-0-0-0-0")
    }
    
}
