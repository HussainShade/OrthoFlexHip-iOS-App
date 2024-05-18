//
//  PatientXrayPage.swift
//  OrthoFlex Hip
//
//  Created by SAIL L1 on 22/11/23.
//

import UIKit

class PatientXrayPage: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("")
    }
    
    @IBAction func PatientXrayBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    

}
