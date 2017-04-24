//
//  QSCHomeNavTableViewCell.swift
//  QSC_Swift
//
//  Created by zhangzhenwei on 17/4/24.
//  Copyright © 2017年 QSC. All rights reserved.
//

import UIKit

class QSCHomeNavTableViewCell: UITableViewCell {

    @IBOutlet weak var KKcollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    class func cellWithTableView(tableView:UITableView)->(QSCHomeNavTableViewCell){
        
        let cellID = "QSCHomeNavTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) else {
            
            let  newCell = Bundle.main.loadNibNamed(cellID, owner: self, options: nil)?.last as? QSCHomeNavTableViewCell
            newCell?.selectionStyle = .none
            newCell?.updateStyle()
            
            return newCell!
        }
        
        return cell as! (QSCHomeNavTableViewCell)
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
        
        let maxImageW = SCREEN_WIDTH/4.5
        let maxImageH = TYPE_NAV_HEIGHT; // 固定高
        flowLayout.itemSize = CGSize(width: maxImageW, height: maxImageH)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        self.KKcollectionView.collectionViewLayout = flowLayout
        self.KKcollectionView.showsHorizontalScrollIndicator = false
        self.KKcollectionView.register(UINib.init(nibName: "QSCHomeNavCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "QSCHomeNavCollectionViewCell")
        self.KKcollectionView.delegate = self
        self.KKcollectionView.dataSource = self
    }

    
}



extension QSCHomeNavTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.homeNavModel?.list.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QSCHomeNavCollectionViewCell", for: indexPath) as! QSCHomeNavCollectionViewCell
        
        cell.desc = self.homeNavModel?.list[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("0-0-0-0-0-0-0-0-0-0-0")
    }
    
}

