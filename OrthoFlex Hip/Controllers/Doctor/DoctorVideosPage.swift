//
//  DoctorVideosPage.swift
//  OrthoFlex Hip
//
//  Created by Sail L1 on 31/10/23.
//

import UIKit
import SideMenu



class DoctorVideosPage: UIViewController {

    @IBOutlet weak var doctorVideoTable: UITableView!
    
    @IBOutlet weak var doctorName: UILabel!
    
    @IBOutlet weak var doctorPhoto: UIImageView!
    
    var recentPatientList:RecentAddedPatientTable?
    
    var menu : SideMenuNavigationController?
    
    var videosList:GetVideosTable?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doctorVideoTable.delegate = self
        doctorVideoTable.dataSource = self
        
        doctorPhoto.clipsToBounds = true
        doctorPhoto.layer.cornerRadius = doctorPhoto.layer.frame.size.height / 2.0
        
        let cell = UINib(nibName: "videosTableView", bundle: nil)
        doctorVideoTable.register(cell, forCellReuseIdentifier: "cell")
        doctorPhoto.layer.cornerRadius = 35
        menu = SideMenuNavigationController(rootViewController: DoctorSideMenuTable())
        menu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: (self.view))
        LoadingIndicator.shared.showLoading(on: self.view)
        
        getVideoListTable()
        getDoctorName()
    }
    
    @IBAction func uploadVideoBtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "DoctorVideoUpload")
        as! DoctorVideoUpload
        self.navigationController?.pushViewController(vc, animated:true)
    }
    
    @IBAction func onSideMenuTap(_ sender: Any) {
        present(menu!,animated: true)
    }
    
    
    @IBAction func dProfileTapped(_ sender: Any) {let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "DoctorProfile")
        as! DoctorProfile
        self.navigationController?.pushViewController(vc, animated:true)
    }
    
    
    func getVideoListTable() {
        
        APIHandler().getAPIValues(type: GetVideosTable.self, apiUrl: ServiceAPI.getVideo, method: "GET") { result in
                         switch result {
                         case .success(let data):
                             print(data)
                            DispatchQueue.main.async {
                                LoadingIndicator.shared.hideLoading()
                                self.videosList = data
                                self.doctorVideoTable.reloadData()
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
}
    
    

extension DoctorVideosPage: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videosList?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! videosTableView
        cell.videoTableCellTitle.text = self.videosList?.data[indexPath.row].videoName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PlayVideoViewController")
        as! PlayVideoViewController
        vc.videoUrl = self.videosList?.data[indexPath.row].videoFile ?? ""
        vc.titles = self.videosList?.data[indexPath.row].videoName ?? ""
        self.navigationController?.pushViewController(vc, animated:true)
    }
    
}
