
//
//  QSCHomeRecommendCollectionViewCell.swift
//  QSC_Swift
//
//  Created by zhangzhenwei on 17/4/24.
//  Copyright © 2017年 QSC. All rights reserved.
//

import UIKit

class QSCHomeRecommendCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var iconW: NSLayoutConstraint!
    @IBOutlet weak var iconH: NSLayoutConstraint!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconH.constant = 100*RATE;
        iconW.constant = 162*RATE;
        nameLbl.font = UIFont.systemFont(ofSize: 14*RATE)
    }
    
    
    var desc:QSCHomeListDesc?{
        
        didSet{
            self.imageView.kf.setImage(with: URL(string: (desc?.image)!), placeholder: UIImage.init(named: "Homenav_Insurance"), options: nil, progressBlock: nil, completionHandler: nil)

            self.nameLbl.text = desc?.name;

        }
    }
}
