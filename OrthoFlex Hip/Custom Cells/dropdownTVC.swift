//
//  dropdownTVC.swift
//  OrthoFlex Hip
//
//  Created by SAIL L1 on 28/12/23.
//

import UIKit

class dropdownTVC: UITableViewCell {

    @IBOutlet weak var listnameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    let margin = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    contentView.frame = contentView.frame.inset(by: margin)
    contentView.layer.cornerRadius = 10
    }
    
}
