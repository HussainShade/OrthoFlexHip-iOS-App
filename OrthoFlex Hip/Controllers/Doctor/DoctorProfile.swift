//
//  DoctorProfile.swift
//  OrthoFlex Hip
//
//  Created by SAIL L1 on 26/10/23.
//

import UIKit

class DoctorProfile: UIViewController {
    
    
    @IBOutlet weak var doctorName: UILabel!
    
    @IBOutlet weak var doctorUsername: UILabel!
    
    @IBOutlet weak var doctorGender: UILabel!
    
    @IBOutlet weak var doctorDOB: UILabel!
    
    @IBOutlet weak var doctorAge: UILabel!
    
    @IBOutlet weak var doctorMobile: UILabel!
    
    @IBOutlet weak var doctorPhoto: UIImageView!
    
    
    
    //var doctorDetails:DoctorProfiles?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        LoadingIndicator.shared.showLoading(on: self.view)
        doctorProfile()
    }
    
    func doctorProfile() {
        
        let doctorId = DataManager.shared.doctorLoginId
        

        APIHandler().getAPIValues(type: DoctorProfileModel.self, apiUrl: ServiceAPI.doctorProfile+"?id=\(doctorId)", method: "GET") { [weak self] result in
                 switch result {
                 case .success(let data):
                    print(data)
                     LoadingIndicator.shared.hideLoading()
                    DispatchQueue.main.async {
                      //  self?.doctorDetails = data
                        self?.doctorName.text = data.data.name
                        self?.doctorUsername.text = data.data.username
                        self?.doctorGender.text = data.data.gender
                        self?.doctorDOB.text = data.data.dob
                        self?.doctorAge.text = data.data.age
                        self?.doctorMobile.text = data.data.mobile
                        self?.loadImage(url: data.data.profilePhoto, imageView: self?.doctorPhoto)
                         }
                 case .failure(let error):
                     LoadingIndicator.shared.hideLoading()
                     print(error)
                     DispatchQueue.main.async {
                         if let nav = self?.navigationController {
                         DataManager.shared.sendMessage(title: "Alert", message: "Something went wrong", navigation: nav)
                         }
                     }
                 }
             }
         }
    
    @IBAction func DoctorProfileBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    

}
