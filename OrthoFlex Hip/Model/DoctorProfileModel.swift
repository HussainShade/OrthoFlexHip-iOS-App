//
//  DoctorProfileModel.swift
//  OrthoFlex Hip
//
//  Created by SAIL L1 on 06/02/24.
//

import Foundation

struct DoctorProfileModel: Codable {
    let success: Bool
    let data: DoctorProfileData
}

// MARK: - DataClass
struct DoctorProfileData: Codable {
    let id, username, name, profilePhoto: String
    let age, gender, dob, mobile: String

    enum CodingKeys: String, CodingKey {
        case id, username, name
        case profilePhoto = "profile_photo"
        case age, gender, dob, mobile
    }
}
