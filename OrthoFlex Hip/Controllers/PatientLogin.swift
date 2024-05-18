//
//  PatientLogin.swift
//  OrthoFlex Hip
//
//  Created by SAIL L1 on 26/10/23.
//

import UIKit

class PatientLogin: UIViewController {
    
    
    @IBOutlet weak var patientidField: UITextField!
    
    @IBOutlet weak var patientpasswordField: UITextField!
    
    @IBOutlet weak var patientHidePasswordBtn: UIButton!
    
    let userDefaults = UserDefaults.standard
    
    var isPasswordVisible = false
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func patientLogin() {
        
        
        let formData = ["username": patientidField.text ?? "",
                        "password": patientpasswordField.text ?? ""]
        
        APIHandler().postAPIValues(type: PatientLoginModel.self, apiUrl: ServiceAPI.PatientLoginURL, method: "POST", formData: formData) { [weak self] result in
                 switch result {
                 case .success(let data):
                     print(data)
                     if data.success == true {
                         DataManager.shared.patientLoginId = data.id
                         DispatchQueue.main.async {
                             let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                             let vc = storyBoard.instantiateViewController(withIdentifier: "PatientHomePage") as! PatientHomePage
                             self?.navigationController?.pushViewController(vc, animated: true)
                         }
                     } else {
                     
                         DispatchQueue.main.async {
                             if let nav = self?.navigationController {
                             DataManager.shared.sendMessage(title: "Alert", message: "Something went wrong", navigation: nav)
                             }
                         }
                     }
                 case .failure(let error):
                     print(error)
                     // Handle failure scenarios (e.g., network error)
                     DispatchQueue.main.async {
                         if let nav = self?.navigationController {
                         DataManager.shared.sendMessage(title: "Alert", message: "Something went wrong", navigation: nav)
                         }
                     }
                 }
             }
         }
   
    @IBAction func PatientHomeLogin(_ sender: Any) {
        if patientidField.text ?? "" != "" && patientpasswordField.text ?? "" != "" {
            patientLogin()
         
        }else {
            DispatchQueue.main.async {
                
                if let nav = self.navigationController {
                DataManager.shared.sendMessage(title: "Alert", message: "Fill all the fields", navigation: nav)
                }
            
                
            }
        }
    }
    
    
    @IBAction func PatientHelp(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "DoctorHelp")
        as! DoctorHelp
        self.navigationController?.pushViewController(vc, animated:false)
    }
    
    @IBAction func PatientLoginBack(_ sender: Any) {
      
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func patientHidePassword(_ sender: Any) {
        isPasswordVisible = !isPasswordVisible
        updatePasswordVisibility()
    }
    
    func updatePasswordVisibility() {
                if isPasswordVisible {
                    // Show password
                    patientpasswordField.isSecureTextEntry = false
                    patientHidePasswordBtn.setTitle("", for: .normal)
                    patientHidePasswordBtn.setImage(UIImage(named: "icons8-hide-30"), for: .normal)
                } else {
                    // Hide password
                    patientpasswordField.isSecureTextEntry = true
                    patientHidePasswordBtn.setTitle("", for: .normal)
                    patientHidePasswordBtn.setImage(UIImage(named: "icons8-eye-30"), for: .normal)
                }
            }
    
}
