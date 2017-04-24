//
//  QSCHomeFooterTableViewCell.swift
//  QSC_Swift
//
//  Created by zhangzhenwei on 17/4/24.
//  Copyright © 2017年 QSC. All rights reserved.
//

import UIKit

class QSCHomeFooterTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    class func cellWithTableView(tableView:UITableView)->(QSCHomeFooterTableViewCell){
        
        let cellID = "QSCHomeFooterTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) else {
            
            let  newCell = Bundle.main.loadNibNamed(cellID, owner: self, options: nil)?.last as? QSCHomeFooterTableViewCell
            newCell?.selectionStyle = .none
            
            return newCell!
        }
        
        return cell as! (QSCHomeFooterTableViewCell)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
