//
//  PatientCell.swift
//  OrthoFlex Hip
//
//  Created by SAIL L1 on 22/11/23.
//

import UIKit

class PatientCell: UITableViewCell {

    @IBOutlet weak var patientsidelabel: UILabel!
    @IBOutlet weak var imageList: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
