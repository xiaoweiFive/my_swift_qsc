//
//  QSCHomeRecommendTableViewCell.swift
//  QSC_Swift
//
//  Created by zhangzhenwei on 17/4/24.
//  Copyright © 2017年 QSC. All rights reserved.
//

import UIKit

let COLLECTIONVIEW_HEIGHT = 161*RATE

class QSCHomeRecommendTableViewCell: UITableViewCell {

    @IBOutlet weak var KKcollectionView: UICollectionView!
    
    @IBOutlet weak var moreBtn: UIButton!
    
    @IBOutlet weak var collectionHCons: NSLayoutConstraint!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    class func cellWithTableView(tableView:UITableView)->(QSCHomeRecommendTableViewCell){
        
        let cellID = "QSCHomeRecommendTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) else {
            
            let  newCell = Bundle.main.loadNibNamed(cellID, owner: self, options: nil)?.last as? QSCHomeRecommendTableViewCell
            newCell?.selectionStyle = .none
            newCell?.updateStyle()
            
            return newCell!
        }
        
        return cell as! (QSCHomeRecommendTableViewCell)
    }

    
    var homeNavModel:QSCHomeModel?{
        
        didSet{
            self.nameLbl.text = homeNavModel?.header?.title
            self.moreBtn.setTitle(homeNavModel?.header?.more?.title, for: .normal)
            
            self.KKcollectionView.reloadData()
        }
    }
    
    func updateStyle()  {
        self.KKcollectionView.backgroundColor = UIColor.white
        self.KKcollectionView.contentInset = UIEdgeInsetsMake(0, 2, 0, 10);
        
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = .horizontal
        
        let maxImageW = SCREEN_WIDTH*0.44
        let maxImageH = COLLECTIONVIEW_HEIGHT; // 固定高
        flowLayout.itemSize = CGSize(width: maxImageW, height: maxImageH)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        collectionHCons.constant = COLLECTIONVIEW_HEIGHT;

        self.KKcollectionView.collectionViewLayout = flowLayout
        self.KKcollectionView.showsHorizontalScrollIndicator = false
        self.KKcollectionView.register(UINib.init(nibName: "QSCHomeRecommendCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "QSCHomeRecommendCollectionViewCell")
        self.KKcollectionView.delegate = self
        self.KKcollectionView.dataSource = self
    }

    @IBAction func moreBtnClick(_ sender: Any) {
        
        
    }

}



extension QSCHomeRecommendTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.homeNavModel?.list.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QSCHomeRecommendCollectionViewCell", for: indexPath) as! QSCHomeRecommendCollectionViewCell
        
        cell.desc = self.homeNavModel?.list[indexPath.item]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("0-0-0-0-0-0-0-0-0-0-0")
    }
    
    
}

