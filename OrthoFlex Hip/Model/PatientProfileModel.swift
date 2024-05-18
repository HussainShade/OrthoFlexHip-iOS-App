//
//  PatientProfileModel.swift
//  OrthoFlex Hip
//
//  Created by SAIL L1 on 06/02/24.
//

import Foundation

struct PatientProfileModel: Codable {
    let success: Bool
    let data: PatientProfileData
}

// MARK: - DataClass
struct PatientProfileData: Codable {
    let id, username, name, profilePhoto: String
    let age, gender, mobile, hospitalID: String

    enum CodingKeys: String, CodingKey {
        case id, username, name
        case profilePhoto = "profile_photo"
        case age, gender, mobile
        case hospitalID = "hospital_id"
    }
}
