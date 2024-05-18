//
//  DoctorHomePage.swift
//  OrthoFlex Hip
//
//  Created by Sail L1 on 31/10/23.
//

import UIKit
import SideMenu
class DoctorHomePage: UIViewController,TapSide {
  
    

    @IBOutlet weak var DoctorMenu: UIButton!
    
    @IBOutlet weak var recentPatientTable: UITableView!
    
    @IBOutlet weak var doctorName: UILabel!
    
    @IBOutlet weak var doctorPhoto: UIImageView!
    
    
    var menu : SideMenuNavigationController?
    
    var recentPatientList:RecentAddedPatientTable?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doctorPhoto.clipsToBounds = true
        doctorPhoto.layer.cornerRadius = doctorPhoto.layer.frame.size.height / 2.0
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        recentPatientTable.delegate = self
        recentPatientTable.dataSource = self
        
        let cell = UINib(nibName: "RecentPatientCell", bundle: nil)
        recentPatientTable.register(cell, forCellReuseIdentifier: "cell")
        
        
        
        menu = SideMenuNavigationController(rootViewController: DoctorSideMenuTable())
        menu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: (self.view))        // Do any additional setup after loading the view.
        LoadingIndicator.shared.showLoading(on: self.view)
        recentAddedPatient()
        getDoctorName()
    }
    
    func sendNum(index: Int) {
        switch index {
        case 0:
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "DoctorProfile") as! DoctorProfile
           
            self.navigationController?.pushViewController(vc, animated:true)
        case 2:
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "LoginPage") as! LoginPage
           
            self.navigationController?.pushViewController(vc, animated:true)
        default:
            print("")
        }
    }
    @IBAction func onsidemenu() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SideMenuController") as! SideMenuController
        vc.delegate = self
        vc.doctorProfile = true
        vc.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(vc, animated: false)
        
    }
    
    func recentAddedPatient() {
        

        APIHandler().getAPIValues(type: RecentAddedPatientTable.self, apiUrl: ServiceAPI.recentlyAddedPatient, method: "GET") { result in
                 switch result {
                 case .success(let data):
                     print(data)
                    DispatchQueue.main.async {
                        LoadingIndicator.shared.hideLoading()
                        self.recentPatientList = data
                        self.recentPatientTable.reloadData()
                         }
                 case .failure(let error):
                     print(error)
                     DispatchQueue.main.async {
                         if let nav = self.navigationController {
                         DataManager.shared.sendMessage(title: "Alert", message: "Something went wrong", navigation: nav)
                         }
                     LoadingIndicator.shared.hideLoading()
                 }
             }
         }
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
                        self?.doctorName.text = "Hello! " + data.data.name
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
    
    
    
    @IBAction func dProfileTapped(_ sender: Any) {
        
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "DoctorProfile")
        as! DoctorProfile
        self.navigationController?.pushViewController(vc, animated:true)
    }
    
    
    
}

extension DoctorHomePage: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentPatientList?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecentPatientCell
        cell.patientNameLbl.text = recentPatientList?.data[indexPath.row].name
        cell.dateLbl.text = recentPatientList?.data[indexPath.row].admittedDate
        cell.statusLbl.text = recentPatientList?.data[indexPath.row].status
        cell.patientPhoto.layer.cornerRadius = 40
        loadImage(url: recentPatientList?.data[indexPath.row].profilePhoto ?? "", imageView: cell.patientPhoto)
        cell.viewRecentPatientDetails = {
            let id = self.recentPatientList?.data[indexPath.row].id
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "DoctorViewPatientPage")
            as! DoctorViewPatientPage
            vc.patientIds = Int(id ?? "") ?? 0
            self.navigationController?.pushViewController(vc, animated:true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
}
