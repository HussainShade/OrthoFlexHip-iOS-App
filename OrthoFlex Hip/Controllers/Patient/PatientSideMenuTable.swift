import UIKit
struct Menu1 {
    let imagelist : UIImage?
    let namelist : String?
}
class PatientSideMenuTable: UITableViewController {

    var menuList1 : [Menu1] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "PatientCell", bundle: nil), forCellReuseIdentifier: "PatientCell")
            tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        //tableView.tableHeaderView?.backgroundColor = UIColor.init(coder: <#T##NSCoder#>)
        
        menuList1.append(Menu1(imagelist: UIImage(named: "MyProfile"), namelist: "My Profile"))
//        menuList1.append(Menu1(imagelist: UIImage(named: "AboutUs"), namelist: "About Us"))
//        menuList1.append(Menu1(imagelist: UIImage(named: "FAQ"), namelist: "FAQ"))
        menuList1.append(Menu1(imagelist: UIImage(named: "Logout"), namelist: "Log Out"))
        tableView.reloadData()
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList1.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PatientCell", for: indexPath) as! PatientCell
        let dict = menuList1[indexPath.row]
        cell.patientsidelabel.text = dict.namelist
        cell.imageList.image = dict.imagelist
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "PatientProfile")
            as! PatientProfile
            self.navigationController?.pushViewController(vc, animated:true)
        
        
    }
//        else if indexPath.row == 1 {
//            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyBoard.instantiateViewController(withIdentifier: "PatientProfile")
//            as! PatientProfile
//            self.navigationController?.pushViewController(vc, animated:true)
//
//
//    }
//        else if indexPath.row == 2 {
//            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyBoard.instantiateViewController(withIdentifier: "PatientProfile")
//            as! PatientProfile
//            self.navigationController?.pushViewController(vc, animated:true)
//
//
//    }
        else if indexPath.row == 1 {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "LoginPage")
            as! LoginPage
            self.navigationController?.pushViewController(vc, animated:true)
        
        
    }
}

}


