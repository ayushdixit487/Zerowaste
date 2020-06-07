//
//  ServiceRequestVC.swift
//  ZeroWasteProject
//
//  Created by MACBOOK on 28/02/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

class ServiceRequestVC: HeaderVC{

//    var delegate1 : delegate!

    @IBOutlet weak var UpperView: UIView!
    @IBOutlet weak var tblview: UITableView!
     var mange : WasteMngmntVC!
    var selected : [Bool] = [false,false,false,false,false,false]
    let imgName : [String] = ["ic_bin","ic_valet","ic_recycling","ic_snow_removal","ic_icon","ic_truck"]
    let lblname : [String] = ["Request Dumpster","Valet Service","Trash recycling","Snow Removal","Dumpster Rental","Dump Truck Rental"]
    let varData : [String] = ["Schedule your service: All types of waste removal.","Description: We send truck and labor to clean your site","Description: Our own processing facility","Description: Salt spreading in plowing.","""
Description: value size of dumpsters for rental:
•    10 Yard - 10 ft long, 4 ft tall, 7 ft wide
•    15 Yard - 10 ft long, 5.5 ft tall, 7 ft wide
•    20 Yard -  22 ft long, 4.5 ft tall, 7 ft wide
•    30 Yard -  22 ft long, 6 ft tall, 7 ft wide
•    40 Yard -  22 ft long, 7 ft tall, 7 ft wide
""","Description: various sizes of dump trucks for rental with drivers"]

    override func viewDidLoad() {
        super.viewDidLoad()

        btnright.isHidden = true
        btnleft.setTitle("Home", for: .normal)
        btnleft.addTarget(self, action: #selector(btnHomeAct(_:)), for: .touchUpInside)
        hlabel.text = "Services"
//        self.title = "Service Request"
        self.tblview.estimatedRowHeight = 60
        self.tblview.rowHeight = UITableViewAutomaticDimension
        self.tblview.reloadData()
        self.tblview.separatorStyle = .none
        print(varData.count)
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool){
//        self.navigationController?.topViewController?.title = "Service Request"
//        self.navigationItem.leftBarButtonItem?.title = "Settings"
//        self.navigationItem.backBarButtonItem?.title = "Settings"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func btnHomeAct(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnActHome(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
    }
  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


}
extension ServiceRequestVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lblname.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "servicerqCell", for: indexPath) as! servicerqCell
        if selected[indexPath.row]{
            //cell.btmSpace2.constant = 200

            cell.lblDis.text = varData[indexPath.row]

            let height = varData[indexPath.row].height(withConstrainedWidth: self.view.frame.width - 32, font: UIFont.systemFont(ofSize: 15))
            cell.topSpace2.constant = height + 40

            cell.DiscriptionVw.isHidden = false


        }
        else{
            //cell.btmSpace2.constant = 0
            cell.topSpace2.constant = 9
            cell.DiscriptionVw.isHidden = true
        }
        cell.imgV.image = UIImage(named: self.imgName[indexPath.row])
        cell.lblName.text = lblname[indexPath.row]
        cell.btnOpnVw.tag = indexPath.row
        cell.btnOpnVw.addTarget(self, action: #selector(openVC(_sender:)), for: .touchUpInside)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        if selected[indexPath.row] == false{
            selected = [false,false,false,false,false,false]
            selected[indexPath.row] = !selected[indexPath.row]
        }else{
            selected[indexPath.row] = !selected[indexPath.row]
        }
//        let topVC = self.navigationController?.topViewController as! TabBar
//        topVC.selectedIndex = 1
//        topVC.tabBar.items?[1].title = lblname[indexPath.row]
//        
//        let wasteManagement = topVC.viewControllers![1] as! WasteMngmntVC
//        wasteManagement.header = lblname[indexPath.row]
        
//        delegate1.getName(lblname[indexPath.row])
//        mange.lblGet.text = lblname[indexPath.row]
//        self.navigationController?.topViewController?.title = lblname[indexPath.row]


        tblview.reloadData()
    }
    func openVC(_sender : UIButton){
        if _sender.tag == 0{
        let topVC = self.navigationController?.topViewController as! TabBar
        topVC.selectedIndex = 1
        topVC.tabBar.items?[1].title = lblname[_sender.tag]

        let wasteManagement = topVC.viewControllers![1] as! WasteMngmntVC
        wasteManagement.header = "Schedule Services"
        }
        else{
            let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "ServicesVC") as! ServicesVC
            
            secondVC.header = lblname[_sender.tag]
            self.navigationController?.pushViewController(secondVC, animated: true)
        }
    }
}


extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)

        return ceil(boundingBox.width)
    }
}
