//
//  DoctorViewPatientAddScore3.swift
//  OrthoFlex Hip
//
//  Created by SAIL L1 on 14/02/24.
//

import UIKit

class DoctorViewPatientAddScore3: UIViewController {

    @IBOutlet weak var score10Lbl: UILabel!
    
    @IBOutlet weak var score11Lbl: UILabel!
    
    @IBOutlet weak var score12Lbl: UILabel!
    
    @IBOutlet weak var score13Lbl: UILabel!
    
    @IBOutlet weak var dropDownTable: UITableView!
    
    
    @IBOutlet weak var totalScore: UITextField!
    
    @IBOutlet weak var conditionLbl: UITextField!
    
    var selectScore = Int()
    var selectValue10 = Float()
    var selectValue11 = Float()
    var selectValue12 = Float()
    var selectValue13 = Float()
    
    let score10DropDown = [
        "None",
        "0 > 8",
        "8 > 16",
        "16 > 24",
        "24 > 32",
        "32 > 40",
        "40 > 45",
        "45 > 55",
        "55 > 65",
        "65 > 70",
        "70 > 75",
        "75 > 80",
        "80 > 90",
        "90 > 100",
        "100 > 110"
    ]

    let score11DropDown = [
        "None",
        "0 > 5",
        "5 > 10",
        "10 > 15",
        "15 > 20"
    ]

    let score12DropDown = [
        "None",
        "0 > 5",
        "5 > 10",
        "10 > 15"
    ]

    let score13DropDown = [
        "None",
        "0 > 5",
        "5 > 10",
        "10 > 15"
    ]
    
    let score10Values: [Float] = [
        0,
        0.4,
        0.8,
        1.2,
        1.6,
        2,
        2.25,
        2.55,
        2.85,
        3,
        3.15,
        3.3,
        3.6,
        3.75,
        3.9
    ]

    let score11Values: [Float] = [
        0,
        0.2,
        0.4,
        0.6,
        0.65
    ]

    let score12Values: [Float] = [
        0,
        0.1,
        0.2,
        0.3
    ]

    let score13Values: [Float] = [
        0,
        0.05,
        0.1,
        0.15
    ]


    
    override func viewDidLoad() {
        super.viewDidLoad()

        dropDownTable.isHidden = true
        let cell = UINib(nibName: "dropdownTVC", bundle: nil)
        dropDownTable.register(cell, forCellReuseIdentifier: "dropdownTVC")
        dropDownTable.delegate = self
        dropDownTable.dataSource = self
        
        
    }
    
    func addScore() {
    
                let patientId =  DataManager.shared.patientLoginId
    
        let formData = [
            "patient_id": "\(patientId)" ,
            "pain":"\(DataManager.shared.score1DataManager)",
            "distance_walked": "\(DataManager.shared.score2DataManager)",
            "activities": "\(DataManager.shared.score3DataManager)",
            "public_transportation": "\(DataManager.shared.score4DataManager)",
            "support": "\(DataManager.shared.score5DataManager)",
            "limp": "\(DataManager.shared.score6DataManager)",
            "stairs": "\(DataManager.shared.score7DataManager)",
            "sitting": "\(DataManager.shared.score8DataManager)",
            "section_2": "\(DataManager.shared.score9DataManager)",
            "total_degree_of_flexion": selectValue10,
            "total_degree_of_abduction": selectValue11,
            "total_degree_of_ext_rotation": selectValue12,
            "total_degree_of_adduction": selectValue13
        ] as [String : Any]


                APIHandler().postAPIValues(type: NewPatientAddScore.self, apiUrl: ServiceAPI.addScoreURL, method: "POST", formData: formData) { [weak self] result in
                         switch result {
                         case .success(let data):
                             print(data)
                             DispatchQueue.main.async {
                             if data.success == true {
                                 self?.totalScore.text = "\(data.score)"
                                 self?.conditionLbl.text = data.score_result
                                 
                                 let alertController = UIAlertController(title: "Alert", message: data.message, preferredStyle: .alert)
                                     let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                                         if let viewController = self?.navigationController?.viewControllers.first(where: { $0 is DoctorViewPatientPage }) {
                                             self?.navigationController?.popToViewController(viewController, animated: true)
                                         }
                                                  
                                              }
                                              alertController.addAction(okAction)
                                 let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                                 self?.dismiss(animated: false, completion: nil)
                                         
                                              }
                                     alertController.addAction(cancelAction)
                                      self?.present(alertController, animated: true, completion: nil)
                                
                             } else {
                                 if let nav = self?.navigationController {
                                 DataManager.shared.sendMessage(title: "Alert", message: "Something went wrong", navigation: nav)
                                 }
                               }
                             }
                         case .failure(let error):
                             print(error)
                             // Handle failure scenarios (e.g., network error)
                             DispatchQueue.main.async {
                                 if let nav = self?.navigationController {
                                 DataManager.shared.sendMessage(title: "Alert", message: "Something went wrong", navigation: nav)
                                 }
                             }
                         }
                     }
                 }
    
    
    @IBAction func DoctorAddPatientAddScore3Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    
    
    @IBAction func calculateTapped(_ sender: Any) {
        
        if score10Lbl.text ?? "" != "Select" && score11Lbl.text ?? "" != "Select" && score12Lbl.text ?? "" != "Select" && score13Lbl.text ?? "" != "Select" {
            addScore()
        }else {
            DispatchQueue.main.async {
                
                if let navigation = self.navigationController {

                DataManager.shared.sendMessage(title: "Alert", message: "Fill all the fields", navigation: navigation)
                }
            }
        }
        
        
    }
    
    
    @IBAction func totalDegreeOfFlexionTab(_ sender: Any) {
        dropDownTable.isHidden = false
        selectScore = 0
        dropDownTable.reloadData()
    }
    
    @IBAction func totalDegreeOfAbductionTab(_ sender: Any) {
        dropDownTable.isHidden = false
        selectScore = 1
        dropDownTable.reloadData()
    }
    
    @IBAction func totalDegreeOfExtRotationTab(_ sender: Any) {
        dropDownTable.isHidden = false
        selectScore = 2
        dropDownTable.reloadData()
    }
    
    @IBAction func totalDegreeOfAdductionTab(_ sender: Any) {
        dropDownTable.isHidden = false
        selectScore = 3
        dropDownTable.reloadData()
    }
    
}

extension DoctorViewPatientAddScore3: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectScore {
        case 0:
            return score10DropDown.count
        case 1:
            return score11DropDown.count
        case 2:
            return score12DropDown.count
        case 3:
            return score13DropDown.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cel = tableView.dequeueReusableCell(withIdentifier: "dropdownTVC", for: indexPath) as! dropdownTVC
    
                cel.backgroundColor = .lightGray
                switch selectScore {
                case 0:
                    cel.listnameLbl.text = score10DropDown[indexPath.row]
                case 1:
                    cel.listnameLbl.text = score11DropDown[indexPath.row]
                case 2:
                    cel.listnameLbl.text = score12DropDown[indexPath.row]
                case 3:
                    cel.listnameLbl.text = score13DropDown[indexPath.row]
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
            score10Lbl.text = score10DropDown[indexPath.row]
            selectValue10 = Float(score10Values[indexPath.row])
            DataManager.shared.score10DataManager = Float(score10Values[indexPath.row])
        case 1:
            score11Lbl.text = score11DropDown[indexPath.row]
            selectValue11 = Float(score11Values[indexPath.row])
            DataManager.shared.score11DataManager = Float(score11Values[indexPath.row])
        case 2:
            score12Lbl.text = score12DropDown[indexPath.row]
            selectValue12 = Float(score12Values[indexPath.row])
            DataManager.shared.score12DataManager = Float(score12Values[indexPath.row])
        case 3:
            score13Lbl.text = score13DropDown[indexPath.row]
            selectValue13 = Float(score13Values[indexPath.row])
            DataManager.shared.score13DataManager = Float(score13Values[indexPath.row])
        default:
           print("")
        }
        dropDownTable.isHidden = true
    }
    
}
