//
//  DoctorViewPatientPage.swift
//  OrthoFlex Hip
//
//  Created by Sail L1 on 31/10/23.
//

import UIKit
import MobileCoreServices

class DoctorViewPatientPage: UIViewController,UIDocumentPickerDelegate {
    
    @IBOutlet weak var hospitalLabel: UILabel!
    
    @IBOutlet weak var patientUsername: UILabel!
    
    @IBOutlet weak var patientPassword: UILabel!
    
    @IBOutlet weak var patientName: UILabel!

    @IBOutlet weak var patientMobile: UILabel!
    
    @IBOutlet weak var patientAge: UILabel!
    
    @IBOutlet weak var patientGender: UILabel!
    
    @IBOutlet weak var patientHeight: UILabel!
    
    @IBOutlet weak var patientWeight: UILabel!
    
    @IBOutlet weak var patientProblem: UILabel!
    
    @IBOutlet weak var patientAdmittedDate: UILabel!
    
    @IBOutlet weak var patientDischargeDate: UILabel!
    
    @IBOutlet weak var patientScore: UILabel!
    
    @IBOutlet weak var patientCondition: UILabel!
    
    @IBOutlet weak var patientFeedback: UITextView!
    
    var patientIds = Int()
    
    
    let imagePicker = UIImagePickerController()
   
   var selectedImage = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        patientMedicalDetails()
    }
    
    func patientMedicalDetails() {
        
        LoadingIndicator.shared.showLoading(on: self.view)
        
        APIHandler().getAPIValues(type: PatientViewDetailsModel.self, apiUrl: ServiceAPI.patientMedicalDetail+"?id=\(patientIds)", method: "GET") { [weak self] result in
            LoadingIndicator.shared.hideLoading()
                 switch result {
                 case .success(let data):
                    
                     print(data)
                    DispatchQueue.main.async {
                        self?.hospitalLabel.text = data.data.patientdetails.first?.hospitalID
                        self?.patientPassword.text = data.data.patientdetails.first?.password
                        self?.patientName.text = data.data.patientdetails.first?.name
                        self?.patientUsername.text = data.data.patientdetails.first?.username
                        self?.patientGender.text = data.data.patientdetails.first?.gender
                        self?.patientAge.text = data.data.patientdetails.first?.age
                        self?.patientMobile.text = data.data.patientdetails.first?.mobile
                        self?.patientHeight.text = data.data.patientdetails.first?.height
                        self?.patientWeight.text = data.data.patientdetails.first?.weight
                        self?.patientProblem.text = data.data.patientdetails.first?.problem
                        self?.patientAdmittedDate.text = data.data.patientdetails.first?.admittedDate
                        self?.patientDischargeDate.text = data.data.patientdetails.first?.dischargeDate
                        self?.patientScore.text = data.data.patientscore.first?.score
                        self?.patientCondition.text = data.data.patientscore.first?.scoreResult
                        self?.patientFeedback.text = data.data.patientdetails.first?.feedback
                         }
                 case .failure(let error):
                     print(error)
                     DispatchQueue.main.async {
                         if let nav = self?.navigationController {
                         DataManager.shared.sendMessage(title: "Alert", message: "Something went wrong", navigation: nav)
                         }
                     }
                 }
             }
         }
    
    @IBAction func DoctorViewPatientBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    @IBAction func DoctorViewPatientAddMedication(_ sender: Any) {
        DataManager.shared.patientLoginId = patientIds
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "DoctorViewPatientAddMedication")
        as! DoctorViewPatientAddMedication
        self.navigationController?.pushViewController(vc, animated:true)
    }
    
    
    @IBAction func DoctorViewPatientViewMedication(_ sender: Any) {
        DataManager.shared.patientLoginId = patientIds
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "DoctorViewPatientViewMedication")
        as! DoctorViewPatientViewMedication
        self.navigationController?.pushViewController(vc, animated:true)
    }
    
    
    @IBAction func DoctorViewPatientAddScore(_ sender: Any) {
        DataManager.shared.patientLoginId = patientIds
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "DoctorViewPatientAddScore1")
        as! DoctorViewPatientAddScore1
        self.navigationController?.pushViewController(vc, animated:true)
    }
    
    @IBAction func viewPatientAddXrayTap(_ sender: Any) {
        
        DataManager.shared.patientLoginId = patientIds
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "DoctorViewPatientXray")
        as! DoctorViewPatientXray
        vc.formPatient = false
        self.navigationController?.pushViewController(vc, animated:true)
        
    }
    
    @IBAction func viewPatientViewDS(_ sender: Any) {
        DataManager.shared.patientLoginId = patientIds
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "DoctorViewPatientDS")
        as! DoctorViewPatientDS
        self.navigationController?.pushViewController(vc, animated:true)
    }
    
    
    @IBAction func viewPatientSaveBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    @IBAction func viewPatientuploadDS(_ sender: Any) {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypePDF as String], in: .import)
                documentPicker.delegate = self
                documentPicker.modalPresentationStyle = .formSheet
                present(documentPicker, animated: true, completion: nil)
        
    }
    
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
          guard let url = urls.first else { return }
          print("Selected PDF file URL: \(url)")
        self.addPDF(url: ServiceAPI.uploadDischargeSummary, patientID: "\(DataManager.shared.patientLoginId)", pdfURL: "\(url)", fieldName: "discharge_summary_pdf")

      }
    
    
    func addPDF(url: String, patientID: String, pdfURL: String, fieldName: String) {
        let apiURL = url
        print("API URL:", apiURL)

        let boundary = UUID().uuidString
        var request = URLRequest(url: URL(string: apiURL)!)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        var body = Data()

        let formData: [String: String] = [
            "patient_id": patientID
        ]
        print("formData : \(formData)")
        for (key, value) in formData {
            body.append(contentsOf: "--\(boundary)\r\n".utf8)
            body.append(contentsOf: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".utf8)
            body.append(contentsOf: "\(value)\r\n".utf8)
        }

        if let pdfData = try? Data(contentsOf: URL(string: pdfURL)!) {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(UUID().uuidString).pdf\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: application/pdf\r\n\r\n".data(using: .utf8)!)
            body.append(pdfData)
            body.append("\r\n".data(using: .utf8)!)
        } else {
            print("Error: Unable to get PDF data from URL")
            return
        }

        body.append("--\(boundary)--\r\n".data(using: .utf8)!) // Close the request body

        request.httpBody = body

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                // Handle the error, e.g., show an alert to the user
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")

                if let data = data {
                   
                   // print("Response Data:", String(data: data, encoding: .utf8) ?? "")
                    
                    if let responseData = String(data: data, encoding: .utf8) {
                        if let jsonData = responseData.data(using: .utf8) {
                            do {
                                if let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                                    if let status = json["status"] as? String, let message = json["message"] as? String {
                                       
                                        DispatchQueue.main.async {
                                            if let nav = self.navigationController {
                                                DataManager.shared.sendMessage(title: "Message", message: message, navigation: nav)
                                            }
                                        }
                                    }
                                }
                            } catch {
                                print("Error parsing JSON: \(error)")
                            }
                        }
                    }



                }
            }
        }

        task.resume()
    }
    
    
}
