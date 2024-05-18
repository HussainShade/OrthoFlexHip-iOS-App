//
//  DoctorViewPatientDS.swift
//  OrthoFlex Hip
//
//  Created by SAIL L1 on 08/12/23.
//

import UIKit
import WebKit

class DoctorViewPatientDS: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadingIndicator.shared.showLoading(on: self.view)
          getPDF()
        }
   
    
    
    func getPDF() {
        APIHandler().getAPIValues(type: DischargeSummmary.self, apiUrl: ServiceAPI.getDischargeSummary+"?patient_id=\(DataManager.shared.patientLoginId)", method: "GET") { [weak self] result in
                 switch result {
                 case .success(let data):
                     LoadingIndicator.shared.hideLoading()
                     print(data)
                    DispatchQueue.main.async {
                       
                        if let pdfUrl = URL(string: ServiceAPI.baseURL+data.data) {
                        let request = URLRequest(url: pdfUrl)
                            self?.webView.load(request)
                            }
                         }
                 case .failure(let error):
                     LoadingIndicator.shared.hideLoading()
                     print(error)
                     DispatchQueue.main.async {
                         if let nav = self?.navigationController {
                         DataManager.shared.sendMessage(title: "Alert", message: "Something went wrong", navigation: nav)
                         }
                     }
                 }
             }
         }
    
    @IBAction func viewPatientviewDSBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
}
