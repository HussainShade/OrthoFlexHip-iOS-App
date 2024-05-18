//
//  DoctorViewPatientAddScore1.swift
//  OrthoFlex Hip
//
//  Created by SAIL L1 on 14/02/24.
//

import UIKit

class DoctorViewPatientAddScore1: UIViewController {

    @IBOutlet weak var score1Lbl: UILabel!
    @IBOutlet weak var score2Lbl: UILabel!
    @IBOutlet weak var score3Lbl: UILabel!
    @IBOutlet weak var score4Lbl: UILabel!
    @IBOutlet weak var score5Lbl: UILabel!
    @IBOutlet weak var score6Lbl: UILabel!
    @IBOutlet weak var score7Lbl: UILabel!
    @IBOutlet weak var score8Lbl: UILabel!
    
    @IBOutlet weak var dropDownTable: UITableView!
    
    var selectScore = Int()
    var selectValues = Int()
    
    let score1DropDown = [
        "None, or ignores it",
        "Slight, occasional, no compromise in activity",
        "Mild pain, no effect on average activities, rarely moderate pain with unusual activity, may take aspirin",
        "Moderate pain, tolerable but makes concessions to pain. Some limitations of ordinary activity or work. May require occasional pain medication stronger than aspirin",
        "Marked pain, serious limitation of activities",
        "Totally disabled, crippled, pain in bed, bedridden"
    ]

    let score2DropDown = [
        "Unlimited",
        "Six blocks (30 minutes)",
        "Two or three blocks (10 - 15 minutes)",
        "Indoors only",
        "Bed and chair only"
    ]

    let score3DropDown = [
        "With ease",
        "With difficulty",
        "Unable to fit or tie"
    ]

    let score4DropDown = [
        "Able to use transportation (bus)",
        "Unable to use public transportation (bus)"
    ]

    let score5DropDown = [
        "None",
        "Cane/Walking stick for long walks",
        "Cane/Walking stick most of the time",
        "One crutch",
        "Two Canes/Walking sticks",
        "Two crutches or not able to walk"
    ]

    let score6DropDown = [
        "None",
        "Slight",
        "Moderate",
        "Severe or unable to walk"
    ]

    let score7DropDown = [
        "Normally without using a railing",
        "Normally using a railing",
        "In any manner",
        "Unable to do stairs"
    ]

    let score8DropDown = [
        "Comfortably, ordinary chair for one hour",
        "On a high chair for 30 minutes",
        "Unable to sit comfortably on any chair"
    ]
    
    let score1Values: [Int] = [
        44,
        40,
        30,
        20,
        10,
        0
    ]

    let score2Values: [Int] = [
        11,
        8,
        5,
        2,
        0
    ]

    let score3Values: [Int] = [
        4,
        2,
        0
    ]

    let score4Values: [Int] = [
        1,
        0
    ]

    let score5Values: [Int] = [
        11,
        7,
        5,
        3,
        2,
        0
    ]

    let score6Values: [Int] = [
        11,
        8,
        5,
        0
    ]

    let score7Values: [Int] = [
        4,
        2,
        1,
        0
    ]

    let score8Values: [Int] = [
        5,
        3,
        0
    ]


    
    override func viewDidLoad() {
        super.viewDidLoad()

        dropDownTable.isHidden = true
        let cell = UINib(nibName: "dropdownTVC", bundle: nil)
        dropDownTable.register(cell, forCellReuseIdentifier: "dropdownTVC")
    }
    

    
    @IBAction func DoctorAddPatientAddScore1Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func DoctorAddPatientAddScore1Next(_ sender: Any) {
      
        
                if score1Lbl.text ?? "" != "Select" && score2Lbl.text ?? "" != "Select" && score3Lbl.text ?? "" != "Select" && score4Lbl.text ?? "" != "Select" && score5Lbl.text ?? "" != "Select" && score6Lbl.text ?? "" != "Select" && score7Lbl.text ?? "" != "Select" && score8Lbl.text ?? "" != "Select" {
                    
                    
                    let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier: "DoctorViewPatientAddScore2")
                    as! DoctorViewPatientAddScore2
                    self.navigationController?.pushViewController(vc, animated:true)
                }else {
                    DispatchQueue.main.async {
                        if let nav = self.navigationController {
                        DataManager.shared.sendMessage(title: "Alert", message: "Fill all the fields", navigation: nav)
                        }
                    }
                }
    }
    

    @IBAction func painTab(_ sender: Any) {
        dropDownTable.isHidden = false
        selectScore = 0
        dropDownTable.reloadData()
    }
    
    
    @IBAction func distanceWalkedTab(_ sender: Any) {
        dropDownTable.isHidden = false
        selectScore = 1
        dropDownTable.reloadData()
    }
    
    @IBAction func activitiesTab(_ sender: Any) {
        dropDownTable.isHidden = false
        selectScore = 2
        dropDownTable.reloadData()
    }
    
    
    @IBAction func publicTransportationTab(_ sender: Any) {
        dropDownTable.isHidden = false
        selectScore = 3
        dropDownTable.reloadData()
    }
    
    @IBAction func supportTab(_ sender: Any) {
        dropDownTable.isHidden = false
        selectScore = 4
        dropDownTable.reloadData()
    }
    
    
    @IBAction func limpTab(_ sender: Any) {
        dropDownTable.isHidden = false
        selectScore = 5
        dropDownTable.reloadData()
    }
    
@IBAction func stairsTab(_ sender: Any) {
        dropDownTable.isHidden = false
        selectScore = 6
        dropDownTable.reloadData()
    }
    
    @IBAction func sittingTab(_ sender: Any) {
        dropDownTable.isHidden = false
        selectScore = 7
        dropDownTable.reloadData()
    }

   
}

extension DoctorViewPatientAddScore1: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectScore {
        case 0:
            return score1DropDown.count
        case 1:
            return score2DropDown.count
        case 2:
            return score3DropDown.count
        case 3:
            return score4DropDown.count
        case 4:
            return score5DropDown.count
        case 5:
            return score6DropDown.count
        case 6:
            return score7DropDown.count
        case 7:
            return score8DropDown.count
        default:
            return 0
        }
        
    }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cel = tableView.dequeueReusableCell(withIdentifier: "dropdownTVC", for: indexPath) as! dropdownTVC
    
            cel.backgroundColor = .lightGray
            switch selectScore {
            case 0:
                cel.listnameLbl.text = score1DropDown[indexPath.row]
            case 1:
                cel.listnameLbl.text = score2DropDown[indexPath.row]
            case 2:
                cel.listnameLbl.text = score3DropDown[indexPath.row]
            case 3:
                cel.listnameLbl.text = score4DropDown[indexPath.row]
            case 4:
                cel.listnameLbl.text = score5DropDown[indexPath.row]
            case 5:
                cel.listnameLbl.text = score6DropDown[indexPath.row]
            case 6:
                cel.listnameLbl.text = score7DropDown[indexPath.row]
            case 7:
                cel.listnameLbl.text = score8DropDown[indexPath.row]
            default:
                print("")
            }
    
            return cel
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            switch selectScore {
            case 0:
                score1Lbl.text = score1DropDown[indexPath.row]
                selectValues = score1Values[indexPath.row]
                DataManager.shared.score1DataManager = Int(score1Values[indexPath.row])
              
            case 1:
                score2Lbl.text = score2DropDown[indexPath.row]
                selectValues = score2Values[indexPath.row]
                DataManager.shared.score2DataManager = Int(score2Values[indexPath.row])
                
            case 2:
                score3Lbl.text = score3DropDown[indexPath.row]
                selectValues = score3Values[indexPath.row]
                DataManager.shared.score3DataManager = Int(score3Values[indexPath.row])
            case 3:
                score4Lbl.text = score4DropDown[indexPath.row]
                selectValues = score4Values[indexPath.row]
                DataManager.shared.score4DataManager = Int(score4Values[indexPath.row])
            case 4:
                score5Lbl.text = score5DropDown[indexPath.row]
                selectValues = score5Values[indexPath.row]
                DataManager.shared.score5DataManager = Int(score5Values[indexPath.row])
            case 5:
                score6Lbl.text = score6DropDown[indexPath.row]
                selectValues = score6Values[indexPath.row]
                DataManager.shared.score6DataManager = Int(score6Values[indexPath.row])
            case 6:
                score7Lbl.text = score7DropDown[indexPath.row]
                selectValues = score7Values[indexPath.row]
                DataManager.shared.score7DataManager = Int(score7Values[indexPath.row])
            case 7:
                score8Lbl.text = score8DropDown[indexPath.row]
                selectValues = score8Values[indexPath.row]
                DataManager.shared.score8DataManager = Int(score8Values[indexPath.row])
            default:
               print("")
            }
            dropDownTable.isHidden = true
        }
}
