//
//  AlertView.swift
//  OrthoFlex Hip
//
//  Created by SAIL L1 on 08/01/24.
//

import UIKit




class DataManager {
    
  
        static let shared = DataManager()
        
        private init() {
            // Private initialization to ensure just one instance is created.
        }
    var doctorLoginId = Int()
    var patientLoginId = Int()
    var newPatientId = Int()
    var score1DataManager = Int()
    var score2DataManager = Int()
    var score3DataManager = Int()
    var score4DataManager = Int()
    var score5DataManager = Int()
    var score6DataManager = Int()
    var score7DataManager = Int()
    var score8DataManager = Int()
    var score9DataManager = Int()
    var score10DataManager = Float()
    var score11DataManager = Float()
    var score12DataManager = Float()
    var score13DataManager = Float()
   
    func sendMessage(title:String,message:String,navigation:UINavigationController) {
        
       
        let alertController = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        navigation.present(alertController, animated: false, completion: nil)
    }
}
