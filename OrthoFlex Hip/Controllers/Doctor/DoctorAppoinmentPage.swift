//
//  DoctorAppoinmentPage.swift
//  OrthoFlex Hip
//
//  Created by Sail L1 on 31/10/23.
//

import UIKit
import SideMenu

class DoctorAppoinmentPage: UIViewController {
    
    
    
    @IBOutlet weak var doctorAppoinmentTable: UITableView!
    
    @IBOutlet weak var segmentController: UISegmentedControl!
    
    @IBOutlet weak var doctorName: UILabel!
    
    @IBOutlet weak var doctorPhoto: UIImageView!
    
    var menu : SideMenuNavigationController?
    
    var recentPatientList: RecentAddedPatientTable?
    
    var approved = false
    var appoinmentpending:PendingAppoinmentTable?
    var appoinmentApproved:PendingAppoinmentTable?

    override func viewDidLoad() {
        super.viewDidLoad()
        doctorPhoto.clipsToBounds = true
        doctorPhoto.layer.cornerRadius = doctorPhoto.layer.frame.size.height / 2.0
        LoadingIndicator.shared.showLoading(on: self.view)
        let cell = UINib(nibName: "MyPatientListCell", bundle: nil)
        doctorAppoinmentTable.register(cell, forCellReuseIdentifier: "cell")
        doctorPhoto.layer.cornerRadius = 35
        
        menu = SideMenuNavigationController(rootViewController: DoctorSideMenuTable())
        menu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: (self.view))

        pedningApi()
        getDoctorName()
    }
    
    func getDoctorName() {
        
        let doctorId = DataManager.shared.doctorLoginId
        

        APIHandler().getAPIValues(type: DoctorProfileModel.self, apiUrl: ServiceAPI.doctorProfile+"?id=\(doctorId)", method: "GET") { [weak self] result in
                 switch result {
                 case .success(let data):
                    print(data)
                     LoadingIndicator.shared.hideLoading()
                    DispatchQueue.main.async {
                      //  self?.doctorDetails = data
                        self?.doctorName.text = data.data.name
                        self?.loadImage(url: data.data.profilePhoto, imageView: self?.doctorPhoto)
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
    func pedningApi() {



        APIHandler().getAPIValues(type: PendingAppoinmentTable.self, apiUrl: ServiceAPI.pendingAppoinmentTable, method: "GET") { [weak self] result in
                 switch result {
                 case .success(let data):
                     LoadingIndicator.shared.hideLoading()
                     print(data)
                    DispatchQueue.main.async {
                        self?.appoinmentpending = data
                       
                        self?.doctorAppoinmentTable.reloadData()
                         }
                 case .failure(let error):
                     LoadingIndicator.shared.hideLoading()
                     print(error)
                     DispatchQueue.main.async {
                         self?.appoinmentpending = nil
                         self?.doctorAppoinmentTable.reloadData()
                         if let nav = self?.navigationController {
                         DataManager.shared.sendMessage(title: "Alert", message: "No data found", navigation: nav)
                         }
                     }
                 }
             }
         }
    
    func addApproved(id:String,status:String) {
        
        
        let formData = [
            "appointment_id": id,
            "status": status,
          
        ]
        
        APIHandler().postAPIValues(type: BookAppoinmentSatus.self, apiUrl: ServiceAPI.appoinmentStatus, method: "POST", formData: formData) { [weak self] result in
                 switch result {
                 case .success(let data):
                     print(data)
                     if data.success == true {
                             DispatchQueue.main.async {
                                 self?.pedningApi()
                                 if let nav = self?.navigationController {
                                 DataManager.shared.sendMessage(title: "Alert", message: data.message, navigation: nav)
                                 }
                                
                             }
                        
                     } else {
                     
                         DispatchQueue.main.async {
//                             if let nav = self?.navigationController {
//                             DataManager.shared.sendMessage(title: "Alert", message: "Something went wrong", navigation: nav)
//                             }
                         }
                     }
                 case .failure(let error):
                     print(error)
                     // Handle failure scenarios (e.g., network error)
                     DispatchQueue.main.async {
//                         if let nav = self?.navigationController {
//                         DataManager.shared.sendMessage(title: "Alert", message: "Something went wrong", navigation: nav)
//                         }
                     }
                 }
             }
         }

    func approvedApi() {



        APIHandler().getAPIValues(type: PendingAppoinmentTable.self, apiUrl: ServiceAPI.approvedAppoinmentTable, method: "GET") { [weak self] result in
                 switch result {
                 case .success(let data):
                     LoadingIndicator.shared.hideLoading()
                     print(data)
                    DispatchQueue.main.async {
                        self?.appoinmentApproved = data
                        self?.doctorAppoinmentTable.reloadData()
                         }
                 case .failure(let error):
                     LoadingIndicator.shared.hideLoading()
                     print(error)
                     DispatchQueue.main.async {
                         self?.appoinmentApproved = nil
                         self?.doctorAppoinmentTable.reloadData()
                         if let nav = self?.navigationController {
                         DataManager.shared.sendMessage(title: "Alert", message: "No data found", navigation: nav)
                         }
                     }
                 }
             }
         }

    
    
    @IBAction func clickSegment(_ sender: Any) {
        
        if segmentController.selectedSegmentIndex == 0 {
            approved = false
           pedningApi()
           
        }
        else {
            approved = true
            approvedApi()
        }
    
    }
    
    @IBAction func onSideMenuTap(_ sender: Any) {
        present(menu!,animated: true)
    }
    
    @IBAction func dProfileTapped(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "DoctorProfile")
        as! DoctorProfile
        self.navigationController?.pushViewController(vc, animated:true)
    }
    
    
}

extension DoctorAppoinmentPage: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if approved == false {
            return self.appoinmentpending?.data.count ?? 0
        }else {
        return self.appoinmentApproved?.data.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyPatientListCell
        
        if approved == false {
            cell.viewBtn.setTitle("Approve", for: .normal)
            let val = self.appoinmentpending?.data[indexPath.row].appointmentDetails
            let value = self.appoinmentpending?.data[indexPath.row].patientDetails
            cell.patientNameLbl.text = value?.name
            cell.patientProblemLbl.text = val?.reason
            cell.patientAdmittedDateLbl.text = val?.scheduleDate
            cell.timeLbl.text = val?.scheduleTime
            cell.rejectBtn.isHidden = false
            cell.profileImage.layer.cornerRadius = 40
            loadImage(url: value?.profile_photo ?? "", imageView: cell.profileImage)
            cell.viewTap = {
                self.addApproved(id:val?.id ?? "",status:"Approved")
            }
            cell.rejectTap = {
                
                self.addApproved(id:val?.id ?? "",status:"Rejected")
            }
        }else {
          
            let val = self.appoinmentApproved?.data[indexPath.row].appointmentDetails
            let value = self.appoinmentApproved?.data[indexPath.row].patientDetails
            cell.patientNameLbl.text = value?.name
            cell.patientProblemLbl.text = val?.reason
            cell.timeLbl.text = ""
            cell.patientAdmittedDateLbl.text = val?.scheduleDate
            cell.viewBtn.setTitle(val?.scheduleTime, for: .normal)
            cell.rejectBtn.isHidden = true
            cell.profileImage.layer.cornerRadius = 40
            loadImage(url: value?.profile_photo ?? "", imageView: cell.profileImage)
            cell.viewTap = {
                
            }
        }
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
}
