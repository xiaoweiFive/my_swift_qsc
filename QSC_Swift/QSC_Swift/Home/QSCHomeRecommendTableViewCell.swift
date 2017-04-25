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
            
            //临时方法
//            self.KKcollectionView.delegate = self;
            let maxImageW = SCREEN_WIDTH*0.44
            let W = maxImageW * CGFloat((self.homeNavModel?.list.count)!) + 10;
            let H = COLLECTIONVIEW_HEIGHT - 61*RATE;
//            self.headerConsH.constant = 46*RATE;
            
            self.KKcollectionView.addFooterRefreshContentSize(W: W, H: H)
          
            self.KKcollectionView.didRefreshBlock =  { () in
                
                print("didRefreshBlock-----didRefreshBlock------didRefreshBlock------didRefreshBlock")
            }
            
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

    
    deinit {
        self.KKcollectionView.endFooterRefresh()
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

