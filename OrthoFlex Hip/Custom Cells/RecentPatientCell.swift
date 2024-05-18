//
//  RecentPatientCell.swift
//  OrthoFlex Hip
//
//  Created by Sail L1 on 22/01/24.
//

import UIKit

class RecentPatientCell: UITableViewCell {
    
    
    @IBOutlet weak var patientNameLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var patientPhoto: UIImageView!
    
    @IBOutlet weak var tapRecentPatient: UIButton!
    
    
    var viewRecentPatientDetails:(() ->())?

    override func awakeFromNib() {
        super.awakeFromNib()
        
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
    
    @IBAction func tapRecentPatient(_ sender: Any) {
        viewRecentPatientDetails?()
    }
    
    
    
}
