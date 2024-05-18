//
//  PatientHomePage.swift
//  OrthoFlex Hip
//
//  Created by SAIL L1 on 26/10/23.
//

import UIKit
import SideMenu

class PatientHomePage: UIViewController,TapSide {
  
    var menu : SideMenuNavigationController?
    
    
    @IBOutlet weak var patientName: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menu = SideMenuNavigationController(rootViewController: PatientSideMenuTable())
        menu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: (self.view))
        
        getPatientName()
    }
    
    func getPatientName() {
        
        let patientId = DataManager.shared.patientLoginId

        APIHandler().getAPIValues(type: PatientProfileModel.self, apiUrl: ServiceAPI.patientProfile+"?id=\(patientId)", method: "GET") { [weak self] result in
            switch result {
                 case .success(let data):
                    print(data)
                     LoadingIndicator.shared.hideLoading()
                    DispatchQueue.main.async {
                      //  self?.doctorDetails = data
                        self?.patientName.text = "Hello! " + data.data.name
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
    
    
    func sendNum(index: Int) {
        switch index {
        case 1:
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "PatientProfile")
            as! PatientProfile
            self.navigationController?.pushViewController(vc, animated:true)
        case 2:
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "LoginPage")
            as! LoginPage
            self.navigationController?.pushViewController(vc, animated:true)
        default:
            print("")
        }
    }
    
    
    @IBAction func PatientViewMedicalDetail(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PatientMedicalDetailPage")
        as! PatientMedicalDetailPage
        self.navigationController?.pushViewController(vc, animated:true)
    }
    
    @IBAction func PatientBookAppoinment(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PatientBookApoinmentPage")
        as! PatientBookApoinmentPage
        self.navigationController?.pushViewController(vc, animated:true)
    }
    
    
    @IBAction func PatientTrackAppoinment(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PatientTrackApoinmentPage")
        as! PatientTrackApoinmentPage
        self.navigationController?.pushViewController(vc, animated:true)
    }
    
    @IBAction func PatientExerciseVideos(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PatientVideosPage")
        as! PatientVideosPage
        self.navigationController?.pushViewController(vc, animated:true)
        
    
    }
    
    @IBAction func feedbackBtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PatientFeedbackVc")
        as! PatientFeedbackVc
        self.navigationController?.pushViewController(vc, animated:true)
    }
    
    
    @IBAction func PatientSideMenu() {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "SideMenuController") as! SideMenuController
                vc.delegate = self
                vc.doctorProfile = false
                
        vc.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(vc, animated: false)
        

        
    }
    
}
