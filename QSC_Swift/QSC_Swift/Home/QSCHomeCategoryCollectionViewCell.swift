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
            self.imageView.sd_setImage(with: URL.init(string: (desc?.image!)!), placeholderImage: UIImage.init(named: "Homenav_cattegory"), options: .retryFailed)
            self.nameLbl.text = desc?.name
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
}
