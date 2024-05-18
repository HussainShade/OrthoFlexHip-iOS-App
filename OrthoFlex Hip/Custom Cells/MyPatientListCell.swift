//
//  MyPatientListCell.swift
//  OrthoFlex Hip
//
//  Created by Sail L1 on 22/01/24.
//

import UIKit

class MyPatientListCell: UITableViewCell {
    
    @IBOutlet weak var patientNameLbl: UILabel!
    @IBOutlet weak var patientProblemLbl: UILabel!
    @IBOutlet weak var patientAdmittedDateLbl: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var viewBtn: UIButton!
    @IBOutlet weak var rejectBtn: UIButton!
    
    var viewTap:(() ->())?
    var rejectTap:(() ->())?

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
    
    @IBAction func viewBtn(_ sender: Any) {
        viewTap?()
    }
    
    
    @IBAction func rejectTap(_ sender: Any) {
        rejectTap?()
    }
    
    
}
