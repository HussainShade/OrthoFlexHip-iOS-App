//
//  DoctorViewPatientAddScore2.swift
//  OrthoFlex Hip
//
//  Created by SAIL L1 on 14/02/24.
//

import UIKit

class DoctorViewPatientAddScore2: UIViewController {

    @IBOutlet weak var score9Lbl: UILabel!
    
    @IBOutlet weak var DropDownView: UIView!
    
    var selectScore = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func DoctorAddPatientAddScore2Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }

    @IBAction func DoctorAddPatientAddScore2Next(_ sender: Any) {
        if score9Lbl.text ?? "" != "Select" {
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "DoctorViewPatientAddScore3")
            as! DoctorViewPatientAddScore3
            self.navigationController?.pushViewController(vc, animated:true)
        }else {
            DispatchQueue.main.async {
                
                if let navigation = self.navigationController {

                DataManager.shared.sendMessage(title: "Alert", message: "Select the field", navigation: navigation)
                }
            }
        }
        
    }

    @IBAction func dropDownTap(_ sender: Any) {
        DropDownView.isHidden = false
    }
    
    
    @IBAction func Yes(_ sender: Any) {
        score9Lbl.text = "Yes"
        selectScore = 4
        DataManager.shared.score9DataManager = 4
        DropDownView.isHidden = true
        
    }
    
    
    @IBAction func No(_ sender: Any) {
        score9Lbl.text = "No"
        selectScore = 0
        DataManager.shared.score9DataManager = 0
        DropDownView.isHidden = true
    }
}
