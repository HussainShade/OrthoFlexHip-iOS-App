//
//  PatientMedicationPage.swift
//  OrthoFlex Hip
//
//  Created by Sail L1 on 31/10/23.
//

import UIKit

class PatientMedicationPage: UIViewController {
    
    
    @IBOutlet weak var Medication1Field: UITextField!
    
    @IBOutlet weak var Medication2Field: UITextField!
    
    @IBOutlet weak var Medication3Field: UITextField!
    
    @IBOutlet weak var Medication4Field: UITextField!
    
    @IBOutlet weak var Medication5Field: UITextField!
    
    @IBOutlet weak var Medication6Field: UITextField!
    
    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        LoadingIndicator.shared.showLoading(on: self.view)
        patientMedications()
        // Do any additional setup after loading the view.
    }
    
    func patientMedications() {
        

        let patientID = DataManager.shared.patientLoginId
        

        APIHandler().getAPIValues(type: PatientViewMedicationModel.self, apiUrl: ServiceAPI.patientViewMedication+"?patient_id=\(patientID)", method: "GET") { [weak self] result in
                 switch result {
                 case .success(let data):
                     LoadingIndicator.shared.hideLoading()
                     print(data)
                    DispatchQueue.main.async {
                        self?.Medication1Field.text = data.data.antibiotics
                        self?.Medication2Field.text = data.data.analgesics
                        self?.Medication3Field.text = data.data.antacids
                        self?.Medication4Field.text = data.data.antiEdemaDrugs
                        self?.Medication5Field.text = data.data.tromboprophylaxis
                        self?.Medication6Field.text = data.data.supportiveDrugs
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
    
    @IBAction func PatientMedicationBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
}
