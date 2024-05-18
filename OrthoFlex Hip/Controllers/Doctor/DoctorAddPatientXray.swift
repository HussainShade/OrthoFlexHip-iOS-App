//
//  DoctorAddPatientXray.swift
//  OrthoFlex Hip
//
//  Created by SAIL L1 on 08/12/23.
//

import UIKit

class DoctorAddPatientXray: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    @IBOutlet weak var preOperativeXrayImage: UIImageView!
    
    @IBOutlet weak var postpOperativeXrayImage: UIImageView!
    
    var preOperativeXrayCheck = false
    
    var imagePicker = UIImagePickerController()
    
    var selectedImage = [UIImage]()
    
    var xrayType = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }
    
    @IBAction func DoctorAddPatientViewXrayBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func preOperativeXray(_ sender: Any) {
        preOperativeXrayCheck =  true
        presentImagePicker()
    }
    

    @IBAction func postOperativeXray(_ sender: Any) {
        preOperativeXrayCheck = false
        presentImagePicker()
    }
    
    
    
    func presentImagePicker() {
             let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
             alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                 self.openCamera()
             }))
             alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                 self.openGallery()
             }))
             alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
             present(alert, animated: true, completion: nil)
         }
         
         
      
         
         func openCamera() {
             if UIImagePickerController.isSourceTypeAvailable(.camera) {
                 imagePicker.sourceType = .camera
                 present(imagePicker, animated: true, completion: nil)
             } else {
                 print("Camera not available")
             }
         }
         
         func openGallery() {
             imagePicker.sourceType = .photoLibrary
             present(imagePicker, animated: true, completion: nil)
         }

         func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
               if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                   if preOperativeXrayCheck {
                   preOperativeXrayImage.image = pickedImage
                   selectedImage.append(pickedImage)
                 
                       addImage(url:ServiceAPI.preXrayUpload,type:"pre_xray_image")
                   }else {
                       postpOperativeXrayImage.image = pickedImage
                       selectedImage.append(pickedImage)
                     
                       addImage(url:ServiceAPI.postXrayUpload,type:"post_xray_image")
                   }
                  
               }
               
               picker.dismiss(animated: true, completion: nil)
           }
         func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
             picker.dismiss(animated: true, completion: nil)
         }
    
    
    
    
    func addImage(url:String,type:String) {
               
               let apiURL = url
               print("API URL:", apiURL)

               let boundary = UUID().uuidString
               var request = URLRequest(url: URL(string: apiURL)!)
               request.httpMethod = "POST"
               request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
               var body = Data()
               let formData: [String: String] = [
                "patient_id": "\(DataManager.shared.newPatientId)",
                 
               ]
                 print("formData : \(formData)")
               for (key, value) in formData {
                   body.append(contentsOf: "--\(boundary)\r\n".utf8)
                   body.append(contentsOf: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".utf8)
                   body.append(contentsOf: "\(value)\r\n".utf8)
               }


            let fieldNames = [type]

            for (index, image) in selectedImage.enumerated() {
                let fieldName = fieldNames[index]

                let imageData = image.jpegData(compressionQuality: 0.8)!
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(UUID().uuidString).jpg\"\r\n".data(using: .utf8)!)
                body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
                body.append(imageData)
                body.append("\r\n".data(using: .utf8)!)
            }




               // Add closing boundary
               body.append(contentsOf: "--\(boundary)--\r\n".utf8) // Close the request body

               request.httpBody = body

               let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                   if let error = error {
                       print("Error: \(error)")
                       // Handle the error, e.g., show an alert to the user
                       return
                   }
                   self.selectedImage.removeAll()
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
