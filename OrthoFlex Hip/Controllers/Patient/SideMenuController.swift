//
//  SideMenuController.swift
//  OrthoFlex Hip
//
//  Created by SAIL on 16/05/24.
//

import UIKit

protocol TapSide {
    func sendNum(index:Int)
}


class SideMenuController: UIViewController {
    
    
    var delegate:TapSide?
    
    var doctorProfile = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func profileTap(_ sender: Any) {
        
        if doctorProfile == true {
            delegate?.sendNum(index: 0)
            
        }else {
            delegate?.sendNum(index: 1)
        }
        self.dismiss(animated: false)
    }
    
    @IBAction func logouTAp(_ sender: Any) {
        
        delegate?.sendNum(index: 2)
        self.dismiss(animated: false)
    }
    
    @IBAction func sideMenuBackBtn(_ sender: Any) {
        delegate?.sendNum(index: 3)
        self.dismiss(animated: false)
    }
    
    
}

