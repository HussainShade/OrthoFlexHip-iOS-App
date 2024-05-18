//
//  PendingAppoinmentTable.swift
//  OrthoFlex Hip
//
//  Created by SAIL L1 on 08/02/24.
//

import Foundation

struct PendingAppoinmentTable: Codable {
    let success: Bool
    let data: [PendingAppoinmentData]
}

// MARK: - Datum
struct PendingAppoinmentData: Codable {
    let appointmentDetails: AppointmentDetails
    let patientDetails: PatientDetails
}

// MARK: - AppointmentDetails
struct AppointmentDetails: Codable {
    let id, patientID, reason, requestDate: String
    let scheduleDate, scheduleTime, status: String

    enum CodingKeys: String, CodingKey {
        case id
        case patientID = "patient_id"
        case reason
        case requestDate = "request_date"
        case scheduleDate = "schedule_date"
        case scheduleTime = "schedule_time"
       
        case status
    }
}

// MARK: - PatientDetails
struct PatientDetails: Codable {
    let id, name,profile_photo: String
    
   
}
