//
//  MenuItemTableCell.swift
//  SideMenu
//
//  Created by Hiroshi Takemoto on 3/2/18.
//

import UIKit

class MenuItemTableCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    // MARK: Life Cycles
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
