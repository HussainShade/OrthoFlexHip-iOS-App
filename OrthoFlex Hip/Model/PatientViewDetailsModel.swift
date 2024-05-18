//
//  PatientViewDetailsModel.swift
//  OrthoFlex Hip
//
//  Created by SAIL L1 on 06/02/24.
//

import Foundation

struct PatientViewDetailsModel: Codable {
    let success: Bool
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let patientdetails: [Patientdetail]
    let patientscore: [Patientscore]
}

// MARK: - Patientdetail
struct Patientdetail: Codable {
    let id, username, password, name: String
    let age, gender, mobile, hospitalID: String
    let height, weight, problem, admittedDate: String
    let dischargeDate, feedback: String

    enum CodingKeys: String, CodingKey {
        case id, username, password, name, age, gender, mobile
        case hospitalID = "hospital_id"
        case height, weight, problem, feedback
        case admittedDate = "admitted_date"
        case dischargeDate = "discharge_date"
    }
}

// MARK: - Patientscore
struct Patientscore: Codable {
    let id, patientID, score, scoreResult: String

    enum CodingKeys: String, CodingKey {
        case id
        case patientID = "patient_id"
        case score
        case scoreResult = "score_result"
    }
}


struct DischargeSummmary: Codable {
    let status: Bool
    let data: String
}


struct UploadPDF: Codable {
    let status: String
    let message: String
}
