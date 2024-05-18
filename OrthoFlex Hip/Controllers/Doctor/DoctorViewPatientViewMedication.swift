//
//  DoctorViewPatientViewMedication.swift
//  OrthoFlex Hip
//
//  Created by SAIL L1 on 13/02/24.
//

import UIKit

class DoctorViewPatientViewMedication: UIViewController {

    @IBOutlet weak var Medication1Field: UITextField!

    @IBOutlet weak var Medication2Field: UITextField!

    @IBOutlet weak var Medication3Field: UITextField!

    @IBOutlet weak var Medication4Field: UITextField!

    @IBOutlet weak var Medication5Field: UITextField!

    @IBOutlet weak var Medication6Field: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        LoadingIndicator.shared.showLoading(on: self.view)
        patientMedications()
        // Do any additional setup after loading the view.
    }

    func patientMedications() {

        APIHandler().getAPIValues(type: PatientViewMedicationModel.self, apiUrl: ServiceAPI.patientViewMedication+"?patient_id=\(DataManager.shared.patientLoginId)", method: "GET") { [weak self] result in
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
