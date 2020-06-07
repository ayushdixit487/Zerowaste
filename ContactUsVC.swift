//
//  ContactUsVC.swift
//  ZeroWasteProject
//
//  Created by Apple on 05/03/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

class ContactUsVC: HeaderVC {

    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var lblGet: UILabel!
    @IBOutlet weak var txtV: UITextView!
    var header: String = ""
    var detail = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        btnright.isHidden = true
       // btnleft.setTitle("Glossary", for: .normal)
        txtV.text = detail
        btnleft.addTarget(self, action: #selector(btnGlory(_:)), for: .touchUpInside)
        self.automaticallyAdjustsScrollViewInsets = false
        DispatchQueue.main.async {

            self.txtV.setContentOffset(CGPoint.zero, animated: false)
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        lblGet.text = header
        hlabel.text = header
    }
    override func viewWillAppear(_ animated: Bool){
        self.navigationController?.topViewController?.title = header
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func btnGlory(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnHome(_ sender: Any) {
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
