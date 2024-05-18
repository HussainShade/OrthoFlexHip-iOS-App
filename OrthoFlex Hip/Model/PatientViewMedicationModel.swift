//
//  PatientViewMedicationModel.swift
//  OrthoFlex Hip
//
//  Created by SAIL L1 on 06/02/24.
//

import Foundation

struct PatientViewMedicationModel: Codable {
    let success: Bool
    let data: PatientViewMedicationData
}

// MARK: - DataClass
struct PatientViewMedicationData: Codable {
    let id, patientID: Int
    let antibiotics, analgesics, antacids, antiEdemaDrugs: String
    let tromboprophylaxis, supportiveDrugs: String

    enum CodingKeys: String, CodingKey {
        case id
        case patientID = "patient_id"
        case antibiotics, analgesics, antacids
        case antiEdemaDrugs = "anti_edema_drugs"
        case tromboprophylaxis
        case supportiveDrugs = "supportive_drugs"
    }
}
