//
//  DoctorPatientListPage.swift
//  OrthoFlex Hip
//
//  Created by Sail L1 on 31/10/23.
//

import UIKit
import SideMenu

class DoctorPatientListPage: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var myPatientTable: UITableView!
    
    @IBOutlet weak var doctorName: UILabel!
    
    @IBOutlet weak var doctorPhoto: UIImageView!
    
    
    
    @IBOutlet weak var patientSearch: UISearchBar!{
    didSet {
        patientSearch.delegate = self
            }
    
     }
    
    
    var patientList : [PatientListData] = []
    var filteredPatientListData: [PatientListData] = []
    
    
    var menu : SideMenuNavigationController?
    
    var PatientList: PatientListTable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doctorPhoto.clipsToBounds = true
        doctorPhoto.layer.cornerRadius = doctorPhoto.layer.frame.size.height / 2.0
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myPatientTable.delegate = self
        myPatientTable.dataSource = self
        
        let cell = UINib(nibName: "MyPatientListCell", bundle: nil)
        myPatientTable.register(cell, forCellReuseIdentifier: "cell")
        
        menu = SideMenuNavigationController(rootViewController: DoctorSideMenuTable())
        menu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: (self.view))
        
        super.viewWillAppear(animated)
        LoadingIndicator.shared.showLoading(on: self.view)
        patientListTable()
        getDoctorName()
    }
    
    func patientListTable() {
        
        APIHandler().getAPIValues(type: PatientListTable.self, apiUrl: ServiceAPI.patientListTable, method: "GET") { result in
                         switch result {
                         case .success(let data):
                             print(data)
                            DispatchQueue.main.async {
                                LoadingIndicator.shared.hideLoading()
                                self.PatientList = data
                                self.patientList = data.data
                                self.filteredPatientListData = data.data
                                self.myPatientTable.reloadData()
                                 }
                         case .failure(let error):
                             LoadingIndicator.shared.hideLoading()
                             print(error)
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
    
    @IBAction func DoctorAddPatient(_ sender: Any) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "DoctorAddPatientPage")
        as! DoctorAddPatientPage
        vc.onceAddPatient = true
        self.navigationController?.pushViewController(vc, animated:true)
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
    
    
extension DoctorPatientListPage: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPatientListData.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyPatientListCell
        cell.patientNameLbl.text = filteredPatientListData[indexPath.row].name
        cell.patientProblemLbl.text = filteredPatientListData[indexPath.row].problem
        cell.patientAdmittedDateLbl.text = filteredPatientListData[indexPath.row].admittedDate
        cell.profileImage.layer.cornerRadius = 40
        loadImage(url: filteredPatientListData[indexPath.row].profilePhoto, imageView: cell.profileImage)
        cell.viewTap = {
            let id = self.PatientList?.data[indexPath.row].id
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "DoctorViewPatientPage")
            as! DoctorViewPatientPage
            vc.patientIds = Int(id ?? "") ?? 0
            self.navigationController?.pushViewController(vc, animated:true)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
}

extension DoctorPatientListPage: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredPatientListData = patientList
        } else {
            filteredPatientListData = patientList.filter { $0.name.lowercased().contains(searchText.lowercased()) || $0.id.lowercased().contains(searchText.lowercased()) }
        }
        
        myPatientTable.reloadData()

//        if filteredPatientListData.isEmpty {
//            showAlert(message: "The patient doesn't exist")
//        }
    }

    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)

        present(alertController, animated: true, completion: nil)
    }
}





