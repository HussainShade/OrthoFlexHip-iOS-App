//
//  AddMedicationPage.swift
//  OrthoFlex Hip
//
//  Created by SAIL L1 on 27/12/23.
//

import UIKit

class AddMedicationPage: UIViewController {

    @IBOutlet weak var med1Lbl: UILabel!
    @IBOutlet weak var med2Lbl: UILabel!
    @IBOutlet weak var med3Lbl: UILabel!
    @IBOutlet weak var med4Lbl: UILabel!
    @IBOutlet weak var med5Lbl: UILabel!
    @IBOutlet weak var med6Lbl: UILabel!
    
    
    @IBOutlet weak var dropDownTable: UITableView!
    
    var selectMedication = Int()
    
    var med1DropDown = [
        "INJ.TAXIM 1GM",
        "INJ.CEFGLOBE FORTE 1.5GM",
        "INJ REFLIN 1GM",
        "INJ.GENTAMYCIN 80MG",
        "INJ.AMKACIN 500MG",
        "INJ METRO 500MG",
        "TAB.TAXIM O 200MG",
        "TAB.CEFRAN 500MG"
    ]
    var med2DropDown = [
        "TAB.ZERODOL-P",
        "TAB.ZERODOL TH MAX",
        "CAPMYORIL 4MG",
        "CAPMYORIL 8MG",
        "TAB.TOLYDOL",
        "TAB.TAPENAX ER",
        "TAB.PARA 500MG",
        "TAB DOLO 650MG",
        "TAB.BRUFEN",
        "INJ.NEOMOL 1GM IV",
        "INJ.DICLO 75MG IM",
        "INJ.TRAMADOL 10OMG IV"
    ]
    var med3DropDown = [
        "TAB.PAN 40MG",
        "TAB.PAN D",
        "INJ.PAN 40MG",
        "CAP.OMEZ",
        "TAB RANTAC 15OMG"
    ]
    var med4DropDown = [
        "TAB.CHYMORAL FORTE",
        "TAB.PHLOGAM",
        "TAB.ENZITRA-DS",
        "TAB.LYMPEDIM"
    ]
    var med5DropDown = [
        "INJ CLEXANE 0.4 CC",
        "INJ HEPARIN 5000 IU",
        "TAB.APIXABAN",
        "TAB.RIVAROXABAN"
    ]
    var med6DropDown = [
        "TAB.LIMCEE",
        "TAB.CALCIMAX K2",
        "TAB.CISS-Q",
        "TAB.TENDOCARE FORTE",
        "OTAB.COBUILT PLUS",
        "TAB.SHELCAL",
        "TAB.JOINTACE-DN",
        "SACHET VIT D3",
        "TAB.NEUROBION FORTE",
        "TAB GABANTIN",
        "CAPPREGABA-M 75MG"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dropDownTable.isHidden = true
        let cell = UINib(nibName: "dropdownTVC", bundle: nil)
        dropDownTable.register(cell, forCellReuseIdentifier: "dropdownTVC")
    }
    
    
    
    func addMedication() {
        
        let patientId = DataManager.shared.newPatientId
        
        let formData = ["patient_id": "\(patientId)",
                        "antibiotics": med1Lbl.text ?? "",
                        "analgesics": med2Lbl.text ?? "",
                        "antacids": med3Lbl.text ?? "",
                        "anti_edema_drugs": med4Lbl.text ?? "",
                        "tromboprophylaxis": med5Lbl.text ?? "",
                        "supportive_drugs": med6Lbl.text ?? ""
                        
        ]
        
        APIHandler().postAPIValues(type: NewPatientAddMedication.self, apiUrl: ServiceAPI.addMedicationUrl, method: "POST", formData: formData) { [weak self] result in
                 switch result {
                 case .success(let data):
                     print(data)
                     DispatchQueue.main.async {
                     if data.status == true {
          
                    let alertController = UIAlertController(title: "Alert", message: data.message, preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                                     self?.navigationController?.popViewController(animated: false)
                                     
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
    
    
    @IBAction func DoctorAddPatientMedicationBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    @IBAction func DoctorAddPatientMedicationSave(_ sender: Any) {
        
        if med1Lbl.text ?? "" != "Select" && med2Lbl.text ?? "" != "Select"  && med3Lbl.text ?? "" != "Select" && med4Lbl.text ?? "" != "Select" && med5Lbl.text ?? "" != "Select" && med6Lbl.text ?? "" != "Select" {
            addMedication()
         
           
        }else {
            DispatchQueue.main.async {
                
                if let nav = self.navigationController {
                DataManager.shared.sendMessage(title: "Alert", message: "Fill all the fields", navigation: nav)
                }
            
                
            }
        }
        
    }
    
    @IBAction func antibioticsTab(_ sender: Any) {
        dropDownTable.isHidden = false
        selectMedication = 0
        dropDownTable.reloadData()
    }
    
    
    
    @IBAction func analgesicsTab(_ sender: Any) {
        dropDownTable.isHidden = false
        selectMedication = 1
        dropDownTable.reloadData()
    }
    
    
    @IBAction func antacidsTab(_ sender: Any) {
        dropDownTable.isHidden = false
        selectMedication = 2
        dropDownTable.reloadData()
    }
    
    
    
    @IBAction func antiEdemaTab(_ sender: Any) {
        dropDownTable.isHidden = false
        selectMedication = 3
        dropDownTable.reloadData()
    }
    
    
    @IBAction func tromboprophylaxisTab(_ sender: Any) {
        dropDownTable.isHidden = false
        selectMedication = 4
        dropDownTable.reloadData()
    }
    
    
    
    @IBAction func supportiveDrugTab(_ sender: Any) {
        dropDownTable.isHidden = false
        selectMedication = 5
        dropDownTable.reloadData()
    }

   
}

extension AddMedicationPage: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectMedication {
        case 0:
            return med1DropDown.count
        case 1:
            return med2DropDown.count
        case 2:
            return med3DropDown.count
        case 3:
            return med4DropDown.count
        case 4:
            return med5DropDown.count
        case 5:
            return med6DropDown.count
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cel = tableView.dequeueReusableCell(withIdentifier: "dropdownTVC", for: indexPath) as! dropdownTVC
       
        cel.backgroundColor = .lightGray
        switch selectMedication {
        case 0:
            cel.listnameLbl.text = med1DropDown[indexPath.row]
        case 1:
            cel.listnameLbl.text = med2DropDown[indexPath.row]
        case 2:
            cel.listnameLbl.text = med3DropDown[indexPath.row]
        case 3:
            cel.listnameLbl.text = med4DropDown[indexPath.row]
        case 4:
            cel.listnameLbl.text = med5DropDown[indexPath.row]
        case 5:
            cel.listnameLbl.text = med6DropDown[indexPath.row]
        default:
            print("")
        }
        
        return cel
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch selectMedication {
        case 0:
            med1Lbl.text = med1DropDown[indexPath.row]
        case 1:
            med2Lbl.text = med2DropDown[indexPath.row]
        case 2:
            med3Lbl.text = med3DropDown[indexPath.row]
        case 3:
            med4Lbl.text = med4DropDown[indexPath.row]
        case 4:
            med5Lbl.text = med5DropDown[indexPath.row]
        case 5:
            med6Lbl.text = med6DropDown[indexPath.row]
        default:
           print("")
        }
        dropDownTable.isHidden = true
    }
    
}
