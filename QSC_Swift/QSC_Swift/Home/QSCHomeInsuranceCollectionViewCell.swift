//
//  QSCHomeInsuranceCollectionViewCell.swift
//  QSC_Swift
//
//  Created by zhangzhenwei on 17/4/24.
//  Copyright © 2017年 QSC. All rights reserved.
//

import UIKit

class QSCHomeInsuranceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var desc:QSCHomeListDesc?{
        
        didSet{
            
            self.imageView.kf.setImage(with: URL(string: (desc?.image)!), placeholder: UIImage.init(named: "Homenav_Insurance"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
