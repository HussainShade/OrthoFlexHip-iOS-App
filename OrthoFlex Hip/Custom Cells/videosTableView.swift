//
//  videosTableView.swift
//  OrthoFlex Hip
//
//  Created by Sail L1 on 22/01/24.
//

import UIKit

class videosTableView: UITableViewCell {
    
    @IBOutlet weak var videoTableCellImage: UIImageView!
    
    @IBOutlet weak var videoTableCellTitle: UILabel!
    
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
        
    let margin = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    contentView.frame = contentView.frame.inset(by: margin)
    contentView.layer.cornerRadius = 10
    }
    
}
