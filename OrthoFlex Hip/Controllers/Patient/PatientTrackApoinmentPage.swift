//
//  PatientTrackApoinmentPage.swift
//  OrthoFlex Hip
//
//  Created by Sail L1 on 31/10/23.
//

import UIKit

class PatientTrackApoinmentPage: UIViewController {
    
    
    @IBOutlet weak var trackAppoinmentTable: UITableView!
    
    var PatientTrackAppoinmentList: PatientTrackAppoinment?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadingIndicator.shared.showLoading(on: self.view)
        let cell = UINib(nibName: "trackAppoinmentCell", bundle: nil)
        trackAppoinmentTable.register(cell, forCellReuseIdentifier: "cell")
        
        patientTrackAppinmentTable()
        // Do any additional setup after loading the view.
    }
    
    func patientTrackAppinmentTable() {
        
        let patientId = DataManager.shared.patientLoginId
        
    APIHandler().getAPIValues(type: PatientTrackAppoinment.self, apiUrl: ServiceAPI.trackAppoinment+"?patient_id=\(patientId)", method: "GET") { result in
                     switch result {
                     case .success(let data):
                         LoadingIndicator.shared.hideLoading()
                         print(data)
                        DispatchQueue.main.async {
                            self.PatientTrackAppoinmentList = data
                            self.trackAppoinmentTable.reloadData()
                             }
                     case .failure(let error):
                         LoadingIndicator.shared.hideLoading()
                         print(error)
                         DispatchQueue.main.async {
                             if let nav = self.navigationController {
                             DataManager.shared.sendMessage(title: "Alert", message: "No Appoinment Found", navigation: nav)
                             }
                         }
                     }
                 }
             }
    
    @IBAction func PatientTrackAppoinmentBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
}

extension PatientTrackApoinmentPage: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return PatientTrackAppoinmentList?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! trackAppoinmentCell
    cell.doctorNameLbl.text = "Dr.Sajith"
    cell.reasonLbl.text =  PatientTrackAppoinmentList?.data[indexPath.row].reason
    cell.raisedDateLbl.text = PatientTrackAppoinmentList?.data[indexPath.row].requestDate
    cell.scheduleDateLbl.text = PatientTrackAppoinmentList?.data[indexPath.row].scheduleDate
    cell.scheduleTimeLbl.text = PatientTrackAppoinmentList?.data[indexPath.row].scheduleTime
    cell.statusBbl.text = PatientTrackAppoinmentList?.data[indexPath.row].status
    return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 170.0
    }
}
