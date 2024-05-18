//
//  PatientMedicalDetailPage.swift
//  OrthoFlex Hip
//
//  Created by Sail L1 on 31/10/23.
//

import UIKit

class PatientMedicalDetailPage: UIViewController {
    
    
    @IBOutlet weak var hospitalLabel: UILabel!
    
    @IBOutlet weak var patientUsername: UILabel!
    
    @IBOutlet weak var patientPassword: UILabel!
    
    @IBOutlet weak var patientName: UILabel!

    @IBOutlet weak var patientMobile: UILabel!
    
    @IBOutlet weak var patientAge: UILabel!
    
    @IBOutlet weak var patientGender: UILabel!
    
    @IBOutlet weak var patientHeight: UILabel!
    
    @IBOutlet weak var patientWeight: UILabel!
    
    @IBOutlet weak var patientProblem: UILabel!
    
    @IBOutlet weak var patientAdmittedDate: UILabel!
    
    @IBOutlet weak var patientDischargeDate: UILabel!
    
    @IBOutlet weak var patientHipScore: UILabel!
    
    @IBOutlet weak var patientCondition: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadingIndicator.shared.showLoading(on: self.view)
        patientMedicalDetails()
    }
    
    func patientMedicalDetails() {
        
        let patientID = DataManager.shared.patientLoginId
        
        APIHandler().getAPIValues(type: PatientViewDetailsModel.self, apiUrl: ServiceAPI.patientMedicalDetail+"?id=\(patientID)", method: "GET") { [weak self] result in
                 switch result {
                 case .success(let data):
                     LoadingIndicator.shared.hideLoading()
                     print(data)
                    DispatchQueue.main.async {
                        self?.hospitalLabel.text = data.data.patientdetails.first?.hospitalID
                        self?.patientPassword.text = data.data.patientdetails.first?.password
                        self?.patientName.text = data.data.patientdetails.first?.name
                        self?.patientUsername.text = data.data.patientdetails.first?.username
                        self?.patientGender.text = data.data.patientdetails.first?.gender
                        self?.patientAge.text = data.data.patientdetails.first?.age
                        self?.patientMobile.text = data.data.patientdetails.first?.mobile
                        self?.patientHeight.text = data.data.patientdetails.first?.height
                        self?.patientWeight.text = data.data.patientdetails.first?.weight
                        self?.patientProblem.text = data.data.patientdetails.first?.problem
                        self?.patientAdmittedDate.text = data.data.patientdetails.first?.admittedDate
                        self?.patientDischargeDate.text = data.data.patientdetails.first?.dischargeDate
                        self?.patientHipScore.text = data.data.patientscore.first?.score
                        self?.patientCondition.text = data.data.patientscore.first?.scoreResult
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
    
    @IBAction func PatientMedicalDetailsBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func PatientViewMedication(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PatientMedicationPage")
        as! PatientMedicationPage
        self.navigationController?.pushViewController(vc, animated:true)
    }
    
    @IBAction func PatientViewXray(_ sender: Any) {
      
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "DoctorViewPatientXray")
            as! DoctorViewPatientXray
            vc.formPatient = true
            self.navigationController?.pushViewController(vc, animated:true)
        }
  
    @IBAction func PatientViewDS(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PatientDischargeSummary")
        as! PatientDischargeSummary
        self.navigationController?.pushViewController(vc, animated:true)
    }
}

