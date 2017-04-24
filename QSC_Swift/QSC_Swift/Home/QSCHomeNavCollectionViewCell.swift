//
//  QSCHomeNavCollectionViewCell.swift
//  QSC_Swift
//
//  Created by zhangzhenwei on 17/4/24.
//  Copyright © 2017年 QSC. All rights reserved.
//

import UIKit
import Kingfisher

class QSCHomeNavCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var topL: NSLayoutConstraint!
    
    @IBOutlet weak var iconW: NSLayoutConstraint!
    @IBOutlet weak var iconH: NSLayoutConstraint!
    
    @IBOutlet weak var textH: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLbl.font = UIFont.systemFont(ofSize: 12*RATE)
        topL.constant = 15*RATE;
        iconH.constant = 42*RATE;
        iconW.constant = 42*RATE;
        textH.constant = 12*RATE;
    }
    
    var desc:QSCHomeListDesc?{
        
        didSet{
            self.imageView.kf.setImage(with: URL(string: (desc?.image)!), placeholder: UIImage.init(named: "Homenav_cattegory"), options: nil, progressBlock: nil, completionHandler: nil)
            self.nameLbl.text = desc?.name;
            
        }
    }

}
