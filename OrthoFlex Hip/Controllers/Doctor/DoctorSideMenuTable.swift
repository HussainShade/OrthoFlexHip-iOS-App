    import UIKit
    struct Menu2 {
        let imagelist : UIImage?
        let namelist : String?
    }
    class DoctorSideMenuTable: UITableViewController {

        var menuList1 : [Menu2] = []
        override func viewDidLoad() {
            super.viewDidLoad()
            tableView.register(UINib(nibName: "DoctorMyProfile", bundle: nil), forCellReuseIdentifier: "DoctorMyProfile")
                tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
            //tableView.tableHeaderView?.backgroundColor = UIColor.init(coder: <#T##NSCoder#>)
            
            menuList1.append(Menu2(imagelist: UIImage(named: "MyProfile"), namelist: "My Profile"))
//            menuList1.append(Menu2(imagelist: UIImage(named: "AboutUs"), namelist: "About Us"))
//            menuList1.append(Menu2(imagelist: UIImage(named: "FAQ"), namelist: "FAQ"))
            menuList1.append(Menu2(imagelist: UIImage(named: "Logout"), namelist: "Log Out"))
            tableView.reloadData()
        }
        

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return menuList1.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorMyProfile", for: indexPath) as! DoctorMyProfile
            let dict = menuList1[indexPath.row]
            cell.namelist.text = dict.namelist
            cell.imagelist.image = dict.imagelist
            return cell
        }
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 50.0
        }
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if indexPath.row == 0 {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "DoctorProfile")
                as! DoctorProfile
                self.navigationController?.pushViewController(vc, animated:true)
            
            
        }
//            else if indexPath.row == 1 {
//                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                let vc = storyBoard.instantiateViewController(withIdentifier: "DoctorProfile")
//                as! DoctorProfile
//                self.navigationController?.pushViewController(vc, animated:true)
//
//
//        }
//            else if indexPath.row == 2 {
//                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                let vc = storyBoard.instantiateViewController(withIdentifier: "DoctorProfile")
//                as! DoctorProfile
//                self.navigationController?.pushViewController(vc, animated:true)
////
//
//        }
            else if indexPath.row == 1 {
//                if let viewcontrollers = navigationController?.viewControllers {
//                    for currentVC in viewcontrollers {
//                        if currentVC.isKind(of: LoginPage.self) {
//                            self.navigationController?.popToViewController(currentVC, animated: true)
//                        }
//                    }
//                }
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "LoginPage")
                as! LoginPage
                self.navigationController?.pushViewController(vc, animated:true)
            
            
        }
    }

}


