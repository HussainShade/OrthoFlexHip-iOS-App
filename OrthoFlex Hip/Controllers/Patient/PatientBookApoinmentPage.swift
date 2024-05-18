//
//  PatientBookApoinmentPage.swift
//  OrthoFlex Hip
//
//  Created by Sail L1 on 31/10/23.
//

import UIKit

class PatientBookApoinmentPage: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var calenderView: UIView!
    
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var bookAppoinmentReason: UITextField!
    
    @IBOutlet weak var selecttime: UITextField!
    
    @IBOutlet weak var dropDown: UIView!
    
    
    let datePicker : UIDatePicker = UIDatePicker()
    let toolbar = UIToolbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateTextField.isUserInteractionEnabled = true

        dateTextField.delegate = self
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        showDatePicker()
    }
    
    
        func showDatePicker() {
               
               datePicker.isHidden = false
               calenderView.isHidden = false
               datePicker.datePickerMode = .date
            
            
              datePicker.minimumDate = Date()

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

               dateTextField.text = formatter.string(from: datePicker.date)
              
               print(formatter.string(from: datePicker.date))
               datePicker.isHidden = true
               toolbar.isHidden = true
               calenderView.isHidden = true
               dateTextField.isUserInteractionEnabled = false

              
           }
    
    func patientBookAppoinment() {
        
        
        let formData = [
            "patient_id": "\(DataManager.shared.patientLoginId)",
            "doctor_id": "1",
            "schedule_date": dateTextField.text ?? "",
            "schedule_time": selecttime.text ?? "",
            "reason": bookAppoinmentReason.text ?? ""
        ]
        
        APIHandler().postAPIValues(type: BookAppoinmentModel.self, apiUrl: ServiceAPI.bookAppoinment, method: "POST", formData: formData) { [weak self] result in
                 switch result {
                 case .success(let data):
                     print(data)
                     DispatchQueue.main.async {
                     if data.success == true {
                       
                         
                         
                         let alertController = UIAlertController(title: "Alert", message: data.data, preferredStyle: .alert)
                             let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                                          self?.navigationController?.popViewController(animated: false)
                                          
                                      }
                                      alertController.addAction(okAction)
                         let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                         self?.dismiss(animated: false, completion: nil)
                                 
                                      }
                             alertController.addAction(cancelAction)
                              self?.present(alertController, animated: true, completion: nil)
                         
                          
                     } else {
                             DataManager.shared.sendMessage(title: "Alert", message: data.data, navigation: (self?.navigationController)!)
                         }
                     }
                 
                 case .failure(let error):
                     print(error)
                     // Handle failure scenarios (e.g., network error)
                     DispatchQueue.main.async {
                         if let nav = self?.navigationController {
                         DataManager.shared.sendMessage(title: "Alert", message: "Something went wrong", navigation: nav)
                         }
                     }
                 }
             }
         }
    

    @IBAction func PatientBookAppoinmentBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    @IBAction func TAPDROP(_ sender: Any) {
        dropDown.isHidden = false
    }
    
    @IBAction func S1(_ sender: Any) {
        selecttime.text = "08:00:00"
        dropDown.isHidden = true
    }
    

    @IBAction func S2(_ sender: Any) {
        selecttime.text = "09:00:00"
        dropDown.isHidden = true

    }
    

    @IBAction func S3(_ sender: Any) {
        selecttime.text = "10:00:00"
        dropDown.isHidden = true

    }

    
    @IBAction func S4(_ sender: Any) {
        selecttime.text = "12:00:00"
        dropDown.isHidden = true

    }

    @IBAction func S5(_ sender: Any) {
        selecttime.text = "02:00:00"
        dropDown.isHidden = true

    }
    
    
    @IBAction func BookAppoinmentBtn(_ sender: Any) {
        patientBookAppoinment()
        
    }
    
    
}
