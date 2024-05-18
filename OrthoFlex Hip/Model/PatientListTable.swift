//
//  PatientListTable.swift
//  OrthoFlex Hip
//
//  Created by SAIL L1 on 06/02/24.
//

import Foundation

struct PatientListTable: Codable {
    let status: Bool
    let data: [PatientListData]
}

// MARK: - Datum
struct PatientListData: Codable {
    let id, name, problem, admittedDate: String
    let profilePhoto: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, problem
        case admittedDate = "admitted_date"
        case profilePhoto = "profile_photo"
    }
}




