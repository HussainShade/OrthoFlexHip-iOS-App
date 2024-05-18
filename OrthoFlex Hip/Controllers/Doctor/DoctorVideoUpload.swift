//
//  DoctorVideoUpload.swift
//  OrthoFlex Hip
//
//  Created by SAIL L1 on 23/02/24.
//

import UIKit
import AVFoundation
import MobileCoreServices


class DoctorVideoUpload: UIViewController,UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var videoTitleField: UITextField!
    
 
    @IBOutlet weak var uploadBtn: UIButton!
    
    
    var videoURLName: URL?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func videoUploadBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func videoUploadBtntap(_ sender: Any) {
        
        
        
        if videoTitleField.text ?? "" != "" {
      
        DispatchQueue.main.async{ [self] in
            let videoPicker = UIImagePickerController()
            videoPicker.sourceType = .photoLibrary
             videoPicker.mediaTypes = [kUTTypeMovie as String]
            videoPicker.videoExportPreset = AVAssetExportPreset1280x720
            videoPicker.delegate = self
            present(videoPicker, animated: true, completion: nil)
        }
        
    }
    else {
        
        if let nav = self.navigationController {
        DataManager.shared.sendMessage(title: "Alert", message: "Give video ttile", navigation: nav)
        }
    }
    }
    
}

extension DoctorVideoUpload {


        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            LoadingIndicator.shared.showLoading(on: self.view)

            if let videoURL = info[.mediaURL] as? URL {
                // You can use the selected video URL here
                print("Selected video URL: \(videoURL)")
                self.uploadVideo(videoURL: videoURL,info: info)
            }
            picker.dismiss(animated: true, completion: nil)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
        func uploadVideo(videoURL:URL,info: [UIImagePickerController.InfoKey : Any]){
            if let fileSize = try? FileManager.default.attributesOfItem(atPath: videoURL.path)[.size] as? Int {
                let sizeInMegabytes = Double(fileSize) / (1024 * 1024)
                if sizeInMegabytes <= 100 {
                    self.videoURLName = videoURL
                    if let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
                        let videoName = videoUrl.lastPathComponent
//                        uploadBtn.setTitle("Video Added", for: .normal)
//                        uploadBtn.setImage(UIImage(systemName: "checkmark.seal.fill"), for: .normal)
                    
                        postAPI()
                    }
                } else{
                    if let nav = self.navigationController {
                        DataManager.shared.sendMessage(title: "Alert", message: "The video size must be under 100MB", navigation: nav)
                    }
                    print("Video Size: \(sizeInMegabytes) MB")
                }
            }
            
                }
            func postAPI(){
                let apiURL = ServiceAPI.uploadVideo
                print("API URL:", apiURL)
                print("API URL:", apiURL)
                let boundary = UUID().uuidString
                var request = URLRequest(url: URL(string: apiURL)!)
                request.httpMethod = "POST"
                request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
                
                var body = Data()
                let formData: [String: Any] = [
                    "video_name": videoTitleField.text ?? ""
                ]
                for (key, value) in formData {
                    body.append(contentsOf: "--\(boundary)\r\n".utf8)
                    body.append(contentsOf: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".utf8)
                    body.append(contentsOf: "\(value)\r\n".utf8)
                }
                print("formData :", formData)
                let videoData = try! Data(contentsOf: videoURLName!)
                body.append(contentsOf: "--\(boundary)\r\n".utf8)
                body.append(contentsOf: "Content-Disposition: form-data; name=\"video_file\"; filename=\"\(UUID().uuidString).mov\"\r\n".utf8)
                body.append(contentsOf: "Content-Type: video/quicktime\r\n\r\n".utf8)
                body.append(contentsOf: videoData)
                body.append(contentsOf: "\r\n".utf8)
                body.append(contentsOf: "--\(boundary)--\r\n".utf8) // Close the request body
                request.httpBody = body
                print("body :", body)
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    if let error = error {
                        LoadingIndicator.shared.hideLoading()
                        print("Error: \(error)")
                        return
                    }
                    
                    if let httpResponse = response as? HTTPURLResponse {
                        print("Status code: \(httpResponse.statusCode)")
                        LoadingIndicator.shared.hideLoading()
                        
                        if let data = data {
                            LoadingIndicator.shared.hideLoading()
                           // print("Response Data:", String(data: data, encoding: .utf8) ?? "")
                            
                            if let responseData = String(data: data, encoding: .utf8) {
                                if let jsonData = responseData.data(using: .utf8) {
                                    do {
                                        if let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                                            if let status = json["status"] as? Bool, let message = json["message"] as? String {
                                               
                                                DispatchQueue.main.async {
                                                    let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
                                                        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                                                                     self.navigationController?.popViewController(animated: false)
                                                                     
                                                                 }
                                                                 alertController.addAction(okAction)
                                                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                                                    self.dismiss(animated: false, completion: nil)
                                                            
                                                                 }
                                                        alertController.addAction(cancelAction)
                                                         self.present(alertController, animated: true, completion: nil)
                                                    
                                                }
                                            }
                                        }
                                    } catch {
                                        print("Error parsing JSON: \(error)")
                                    }
                                }
                            }



                        }
                        LoadingIndicator.shared.hideLoading()
                    }
                }
                
                task.resume()
            }
    
    }









