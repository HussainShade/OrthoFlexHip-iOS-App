//
//  LoginModel.swift
//  OrthoFlex Hip
//
//  Created by SAIL L1 on 08/01/24.
//

import Foundation

struct AddNewPatientdetails: Codable {
    let status: Bool
    let data: String
    let patientID: Int

    enum CodingKeys: String, CodingKey {
        case status, data
        case patientID = "patient_id"
    }
}


struct NewPatientAddMedication:Codable {
    let status:Bool
    let message:String
}

struct NewPatientAddScore:Codable {
    let success: Bool
    let message: String
    let score:Int
    let score_result:String
}



struct BookAppoinmentModel:Codable {
    let success:Bool
    let data:String

}


struct BookAppoinmentSatus:Codable {
    let success:Bool
    let message:String

}



struct ImageXray: Codable {
    let status: String
    let data: ImageXrayData
}

// MARK: - DataClass
struct ImageXrayData: Codable {
    let preXrayImage, postXrayImage: String

    enum CodingKeys: String, CodingKey {
        case preXrayImage = "pre_xray_image"
        case postXrayImage = "post_xray_image"
    }
}

struct AddFeedback: Codable {
    let status: Bool
    let message: String
}
