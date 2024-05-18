//
//  LoginPage.swift
//  OrthoFlex Hip
//
//  Created by SAIL on 04/10/23.
//

import UIKit

class LoginPage: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func DoctorLogin(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "DoctorLogin")
        as! DoctorLogin
        self.navigationController?.pushViewController(vc, animated:true)
        
    }
    
    @IBAction func PatientLogin(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PatientLogin")
        as! PatientLogin
        self.navigationController?.pushViewController(vc, animated:true)
    }
    
}
