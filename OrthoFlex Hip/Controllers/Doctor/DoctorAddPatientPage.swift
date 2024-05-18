//
//  DoctorAddPatientPage.swift
//  OrthoFlex Hip
//
//  Created by Sail L1 on 31/10/23.
//

import UIKit
import MobileCoreServices

class DoctorAddPatientPage: UIViewController,UIDocumentPickerDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var AddPatientHospitalID: UITextField!
    @IBOutlet weak var AddPatientUsername: UITextField!
    @IBOutlet weak var AddPatientPassword: UITextField!
    @IBOutlet weak var AddPatientName: UITextField!
    @IBOutlet weak var AddPatientMobile: UITextField!
    @IBOutlet weak var AddPatientAge: UITextField!
    @IBOutlet weak var AddPatientGender: UITextField!
    @IBOutlet weak var AddPatientHeight: UITextField!
    @IBOutlet weak var AddPatientWeight: UITextField!
    @IBOutlet weak var AddPatientProblem: UITextField!
    @IBOutlet weak var AddPatientAdmittedDate: UITextField!
    @IBOutlet weak var AddPatientDischargeDate: UITextField!
    
    @IBOutlet weak var calenderView: UIView!

    let userDefaults = UserDefaults.standard
    let imagePicker = UIImagePickerController()
    var isAdded = false
    
    var selectedImage = [UIImage]()
    
    
    var AddPatientAdmittedDateYes = true
    
    let datePicker : UIDatePicker = UIDatePicker()
    let toolbar = UIToolbar()
    
    var onceAddPatient = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AddPatientAdmittedDate.isUserInteractionEnabled = true
      
        AddPatientAdmittedDate.delegate = self
        AddPatientDischargeDate.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        calenderView.isHidden = true
    }
    
    
    func addpatient() {
        
        let formData:[String:String] = [
            "username": AddPatientUsername.text ?? "",
            "password": AddPatientPassword.text ?? "",
            "name": AddPatientName.text ?? "",
            "age":AddPatientAge.text ?? "",
            "gender":AddPatientGender.text ?? "",
            "height":AddPatientHeight.text ?? "",
            "weight":AddPatientWeight.text ?? "",
            "problem":AddPatientProblem.text ?? "",
            "admitted_date":AddPatientAdmittedDate.text ?? "",
            "discharge_date":AddPatientDischargeDate.text ?? "",
            "hospital_id":AddPatientHospitalID.text ?? "",
            "mobile":AddPatientMobile.text ?? ""
        ]
        
        APIHandler().postAPIValues(type:AddNewPatientdetails.self, apiUrl: ServiceAPI.addNewPatient, method: "POST",formData: formData) { [weak self] result in
            switch result {
            case .success(let data):
                print(data)
                if data.status == true {
                    DataManager.shared.newPatientId = data.patientID
                    DispatchQueue.main.async {
                      
                        if let nav = self?.navigationController {
                            DataManager.shared.sendMessage(title: "Alert", message: data.data, navigation: nav)
                            self?.AddPatientAdmittedDate.delegate = nil
                            self?.AddPatientDischargeDate.delegate = nil
                            
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        if let nav = self?.navigationController {
                        DataManager.shared.sendMessage(title: "Alert", message: data.data, navigation: nav)
                        }
                    }
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
    
    
    @IBAction func addPatientBtn(_ sender: Any) {
        
       
        
        if AddPatientUsername.text ?? "" != "" &&
            AddPatientPassword.text ?? "" != "" &&
            AddPatientName.text ?? "" != "" &&
            AddPatientAge.text ?? "" != "" &&
            AddPatientGender.text ?? "" != "" &&
            AddPatientHeight.text ?? "" != "" &&
            AddPatientWeight.text ?? "" != "" &&
            AddPatientProblem.text ?? "" != "" &&
            AddPatientAdmittedDate.text ?? "" != "" &&
            AddPatientDischargeDate.text ?? "" != "" &&
            AddPatientHospitalID.text ?? "" != "" &&
            AddPatientMobile.text ?? "" != ""
        {
            if !onceAddPatient {
                DispatchQueue.main.async {
                    if let nav = self.navigationController {
                        DataManager.shared.sendMessage(title: "Alert", message: "Patient already added", navigation: nav)
                    }
                }
            }else {
                onceAddPatient = false
                addpatient()
            }
            
        }else {
            DispatchQueue.main.async {
                if let nav = self.navigationController {
                    DataManager.shared.sendMessage(title: "Alert", message: "Fill all the empty fields", navigation: nav)
                }
            }
            
        }
    }
    
    
    @IBAction func DoctorAddPatientBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    @IBAction func DoctorAddPatientMedication(_ sender: Any) {
        
        
        if AddPatientUsername.text ?? "" != "" &&
            AddPatientPassword.text ?? "" != "" &&
            AddPatientName.text ?? "" != "" &&
            AddPatientAge.text ?? "" != "" &&
            AddPatientGender.text ?? "" != "" &&
            AddPatientHeight.text ?? "" != "" &&
            AddPatientWeight.text ?? "" != "" &&
            AddPatientProblem.text ?? "" != "" &&
            AddPatientAdmittedDate.text ?? "" != "" &&
            AddPatientDischargeDate.text ?? "" != "" &&
            AddPatientHospitalID.text ?? "" != "" &&
            AddPatientMobile.text ?? "" != ""
        {
            UserDefaults.standard.set(AddPatientUsername.text ?? "", forKey: "newPatientId")
            
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "AddMedicationPage")
            as! AddMedicationPage
            self.navigationController?.pushViewController(vc, animated:true)
        }else {
            DispatchQueue.main.async {
                if let nav = self.navigationController {
                    DataManager.shared.sendMessage(title: "Alert", message: "You should add patient details", navigation: nav)
                }
            }
            
        }
        
    }
    
    
    @IBAction func DoctorAddPatientViewMedication(_ sender: Any) {
        UserDefaults.standard.set(AddPatientUsername.text ?? "", forKey: "newPatientId")
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "DoctorAddPatientViewMedication")
        as! DoctorAddPatientViewMedication
        self.navigationController?.pushViewController(vc, animated:true)
        
    }
    
    
    @IBAction func DoctorAddPatientAddScore(_ sender: Any) {
        
        if AddPatientUsername.text ?? "" != "" &&
            AddPatientPassword.text ?? "" != "" &&
            AddPatientName.text ?? "" != "" &&
            AddPatientAge.text ?? "" != "" &&
            AddPatientGender.text ?? "" != "" &&
            AddPatientHeight.text ?? "" != "" &&
            AddPatientWeight.text ?? "" != "" &&
            AddPatientProblem.text ?? "" != "" &&
            AddPatientAdmittedDate.text ?? "" != "" &&
            AddPatientDischargeDate.text ?? "" != "" &&
            AddPatientHospitalID.text ?? "" != "" &&
            AddPatientMobile.text ?? "" != ""
        {
            UserDefaults.standard.set(AddPatientUsername.text ?? "", forKey: "newPatientId")
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "AddScore1Vc")
            as! AddScore1Vc
            self.navigationController?.pushViewController(vc, animated:true)
        }else {
            DispatchQueue.main.async {
                if let nav = self.navigationController {
                    DataManager.shared.sendMessage(title: "Alert", message: "You should add patient details", navigation: nav)
                }
            }
            
        }
    }
    
    
    @IBAction func DoctorAddPatientViewDS(_ sender: Any) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "DoctorAddPatientViewDS")
        as! DoctorAddPatientViewDS
        self.navigationController?.pushViewController(vc, animated:true)
    }
    
    
    @IBAction func addPatientAddXray(_ sender: Any) {
        
        
        
        if AddPatientUsername.text ?? "" != "" &&
            AddPatientPassword.text ?? "" != "" &&
            AddPatientName.text ?? "" != "" &&
            AddPatientAge.text ?? "" != "" &&
            AddPatientGender.text ?? "" != "" &&
            AddPatientHeight.text ?? "" != "" &&
            AddPatientWeight.text ?? "" != "" &&
            AddPatientProblem.text ?? "" != "" &&
            AddPatientAdmittedDate.text ?? "" != "" &&
            AddPatientDischargeDate.text ?? "" != "" &&
            AddPatientHospitalID.text ?? "" != "" &&
            AddPatientMobile.text ?? "" != ""
        {
            UserDefaults.standard.set(AddPatientUsername.text ?? "", forKey: "newPatientId")
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "DoctorAddPatientXray")
            as! DoctorAddPatientXray
            self.navigationController?.pushViewController(vc, animated:true)
        }else {
            DispatchQueue.main.async {
                if let nav = self.navigationController {
                    DataManager.shared.sendMessage(title: "Alert", message: "You should add patient details", navigation: nav)
                }
            }
            
        }
    }
    
    
    @IBAction func doneBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    
    @IBAction func uploadDisTapped(_ sender: Any) {
        
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypePDF as String], in: .import)
                documentPicker.delegate = self
                documentPicker.modalPresentationStyle = .formSheet
                present(documentPicker, animated: true, completion: nil)
        
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
          guard let url = urls.first else { return }
          print("Selected PDF file URL: \(url)")
        self.addPDF(url: ServiceAPI.uploadDischargeSummary, patientID: "\(DataManager.shared.newPatientId)", pdfURL: "\(url)", fieldName: "discharge_summary_pdf")

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


extension DoctorAddPatientPage {
    
    
   
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == AddPatientAdmittedDate {
            AddPatientAdmittedDateYes = true
            showDatePicker()
        }else if textField == AddPatientDischargeDate {
            AddPatientAdmittedDateYes = false
            showDatePicker()
        }
        
    }
    
    
        func showDatePicker() {
               
               datePicker.isHidden = false
               calenderView.isHidden = false
               datePicker.datePickerMode = .date
            
            
             

               if #available(iOS 13.4, *) {
                   datePicker.preferredDatePickerStyle = .inline
               } else {
                   datePicker.preferredDatePickerStyle = .wheels
               }
           
               toolbar.sizeToFit()
              toolbar.isHidden = false

               // done button & cancel button
               let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donedatePicker(_:)))

               let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)

               let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelDatePicker(_:)))

               toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)


               view.addSubview(datePicker)
               view.addSubview(toolbar)

               // Add constraints or frame as needed
               datePicker.translatesAutoresizingMaskIntoConstraints = false
               toolbar.translatesAutoresizingMaskIntoConstraints = false

               NSLayoutConstraint.activate([
                   // Adjust the constraints as per your layout requirements
                datePicker.topAnchor.constraint(equalTo: calenderView.topAnchor),
                datePicker.leadingAnchor.constraint(equalTo: calenderView.leadingAnchor),
                datePicker.trailingAnchor.constraint(equalTo: calenderView.trailingAnchor),
                datePicker.bottomAnchor.constraint(equalTo: calenderView.bottomAnchor,constant: -10),

                   toolbar.topAnchor.constraint(equalTo: datePicker.bottomAnchor),
                   toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                   toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               ])
           }

           @objc func cancelDatePicker(_ sender: UIButton) {
               datePicker.isHidden = true
               toolbar.isHidden = true
               calenderView.isHidden = true
           }

           @objc func donedatePicker(_ sender: UIButton) {
               let formatter = DateFormatter()
               formatter.dateFormat = "yyyy-MM-dd"
               if AddPatientAdmittedDateYes == true {
                   AddPatientAdmittedDate.text = formatter.string(from: datePicker.date)
                   calenderView.isHidden = true
               }else {
                   AddPatientDischargeDate.text = formatter.string(from: datePicker.date)
                   calenderView.isHidden = true
               }
               
              
               print(formatter.string(from: datePicker.date))
               datePicker.isHidden = true
               toolbar.isHidden = true
             
             

              
           }
    
}




