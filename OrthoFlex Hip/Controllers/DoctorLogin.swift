//
//  DoctorLogin.swift
//  OrthoFlex Hip
//
//  Created by SAIL L1 on 26/10/23.
//

import UIKit

class DoctorLogin: UIViewController {
    
    
    
    @IBOutlet weak var doctorIdField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    var isPasswordVisible = false
    
    @IBOutlet weak var doctorHidePassword: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    func doctorLogin() {
        
        
        let formData = ["username": doctorIdField.text ?? "",
                        "password": passwordField.text ?? ""]
        
        APIHandler().postAPIValues(type: DoctorLoginModel.self, apiUrl: ServiceAPI.doctorLoginURL, method: "POST", formData: formData) { [weak self] result in
                 switch result {
                 case .success(let data):
                     print(data)
                     if data.success == true {
                         DataManager.shared.doctorLoginId = data.id
                         DispatchQueue.main.async { [self] in
                             let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                             let vc = storyBoard.instantiateViewController(withIdentifier: "DoctorNavigationHomePage") as! DoctorNavigationHomePage
                             self?.navigationController?.pushViewController(vc, animated: true)
                         }
                     } else {
                     
                         DispatchQueue.main.async {
                             if let nav = self?.navigationController {
                             DataManager.shared.sendMessage(title: "Alert", message: "Inalid Username or Password", navigation: nav)
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
    
    @IBAction func DoctorLoginBack(_ sender: Any) {
     
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func DoctorLoginHelp(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "DoctorHelp")
        as! DoctorHelp
        self.navigationController?.pushViewController(vc, animated:true)
    }
    
    @IBAction func DoctorLoginHome(_ sender: Any) {
        if doctorIdField.text ?? "" != "" && passwordField.text ?? "" != "" {
            doctorLogin()
         
        }else {
            DispatchQueue.main.async {
                
                if let nav = self.navigationController {
                DataManager.shared.sendMessage(title: "Alert", message: "Fill all the fields", navigation: nav)
                }
            
                
            }
        }
    }
    
    @IBAction func doctorHidePasswordBtn(_ sender: Any) {
        isPasswordVisible = !isPasswordVisible
        updatePasswordVisibility()
    }
    
    
    func updatePasswordVisibility() {
                if isPasswordVisible {
                    // Show password
                    passwordField.isSecureTextEntry = false
                    doctorHidePassword.setTitle("", for: .normal)
                    doctorHidePassword.setImage(UIImage(named: "icons8-hide-30"), for: .normal)
                } else {
                    // Hide password
                    passwordField.isSecureTextEntry = true
                    doctorHidePassword.setTitle("", for: .normal)
                    doctorHidePassword.setImage(UIImage(named: "icons8-eye-30"), for: .normal)
                }
            }
    
    

}
