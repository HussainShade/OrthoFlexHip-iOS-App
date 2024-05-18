//
//  Constant.swift
//  OrthoFlex Hip
//
//  Created by SAIL L1 on 08/01/24.
//

import Foundation

struct ServiceAPI {

static let baseURL = "https://b609-180-235-121-242.ngrok-free.app/orthoflex_hip/"

static let doctorLoginURL = baseURL+"doctorlogin.php"
static let PatientLoginURL = baseURL+"patientlogin.php"
static let doctorProfile = baseURL+"doctorprofile.php"
static let patientProfile = baseURL+"patientprofile.php"
static let patientMedicalDetail = baseURL+"patientviewdetails.php"
static let patientViewMedication = baseURL+"patientviewmedication.php"
static let recentlyAddedPatient = baseURL+"recentlyaddedpatient.php"
static let patientListTable = baseURL+"patientliststable.php"
static let addMedicationUrl = baseURL+"addmedication.php"
static let addScoreURL = baseURL+"hipscorecalculation.php"
static let addNewPatient = baseURL+"addpatientdetails.php"
static let bookAppoinment = baseURL+"bookappoinment.php"
static let trackAppoinment = baseURL+"trackappoinment.php"
static let pendingAppoinmentTable = baseURL+"pendingappoinmenttable.php"
static let approvedAppoinmentTable = baseURL+"approvedappoinmenttable.php"
static let appoinmentStatus = baseURL+"appoinmentstatuschange.php"
static let preXrayUpload = baseURL+"prexrayupload.php"
static let postXrayUpload = baseURL+"postxrayupload.php"
static let retImage = baseURL+"retrieveimage.php"
static let uploadVideo = baseURL+"uploadvideo.php"
static let getVideo = baseURL+"retrievevideo.php"
static let uploadDischargeSummary = baseURL+"uploaddischargesummary.php"
static let getDischargeSummary = baseURL+"fetchdischargesummary.php"
static let uploadPatientPhoto = baseURL+"patientimageupload.php"
static let AddFeedback = baseURL+"addfeedback.php"
}
