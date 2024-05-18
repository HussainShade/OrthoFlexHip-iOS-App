//
//  RecentAddedPatientTable.swift
//  OrthoFlex Hip
//
//  Created by SAIL L1 on 06/02/24.
//

import Foundation

struct RecentAddedPatientTable: Codable {
    let status: Bool
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let id, name, admittedDate, dischargeDate: String
    let profilePhoto, status: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case admittedDate = "admitted_date"
        case dischargeDate = "discharge_date"
        case profilePhoto = "profile_photo"
        case status
    }
}
