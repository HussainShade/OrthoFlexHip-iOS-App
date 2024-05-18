//
//  PatientVideosPage.swift
//  OrthoFlex Hip
//
//  Created by Sail L1 on 31/10/23.
//

import UIKit

class PatientVideosPage: UIViewController {

    @IBOutlet weak var patientVideoTable: UITableView!
    
    var videosList: GetVideosTable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        patientVideoTable.delegate = self
        patientVideoTable.dataSource = self
        
        let cell = UINib(nibName: "videosTableView", bundle: nil)
        patientVideoTable.register(cell, forCellReuseIdentifier: "cell")
        LoadingIndicator.shared.showLoading(on: self.view)
        
        getVideoListTable()
    }
    
        func getVideoListTable() {
    
            APIHandler().getAPIValues(type: GetVideosTable.self, apiUrl: ServiceAPI.getVideo, method: "GET") { result in
                             switch result {
                             case .success(let data):
                                 LoadingIndicator.shared.hideLoading()
                                 print(data)
                                DispatchQueue.main.async {
                                    self.videosList = data
                                    self.patientVideoTable.reloadData()
                                     }
                             case .failure(let error):
                                 LoadingIndicator.shared.hideLoading()
                                 print(error)
                             }
                         }
                     }
    

    @IBAction func PatientVideosBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    

}

extension PatientVideosPage: UITableViewDelegate,UITableViewDataSource {
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
