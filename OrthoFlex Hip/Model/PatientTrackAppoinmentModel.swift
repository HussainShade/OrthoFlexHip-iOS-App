//
//  PatientTrackAppoinmentModel.swift
//  OrthoFlex Hip
//
//  Created by SAIL L1 on 08/02/24.
//

import Foundation

struct PatientTrackAppoinment: Codable {
    let success: Bool
    let data: [PatientTrackAppoinmentData]
}

// MARK: - Datum
struct PatientTrackAppoinmentData: Codable {
    let id, patientID, doctorID, scheduleDate: String
    let scheduleTime, reason, requestDate, status: String

    enum CodingKeys: String, CodingKey {
        case id
        case patientID = "patient_id"
        case doctorID = "doctor_id"
        case scheduleDate = "schedule_date"
        case scheduleTime = "schedule_time"
        case reason
        case requestDate = "request_date"
        case status
    }
}
