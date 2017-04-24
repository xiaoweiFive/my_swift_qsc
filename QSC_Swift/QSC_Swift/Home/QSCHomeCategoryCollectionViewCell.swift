//
//  QSCHomeCategoryCollectionViewCell.swift
//  QSC_Swift
//
//  Created by zhangzhenwei on 17/4/21.
//  Copyright © 2017年 QSC. All rights reserved.
//

import UIKit

class QSCHomeCategoryCollectionViewCell: UICollectionViewCell {
    

    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var nameLbl: UILabel!
    
    var desc:QSCHomeListDesc?{
        
        didSet{
            
            self.imageView.kf.setImage(with: URL.init(string: (desc?.image)!), placeholder: UIImage.init(named: "Homenav_cattegory"), options: nil, progressBlock: nil, completionHandler: nil)
            
            self.nameLbl.text = desc?.name
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
}
