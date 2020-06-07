//
//  ViewController.swift
//  ZeroWasteProject
//
//  Created by MACBOOK on 28/02/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class ViewController: HeaderVC {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var lblMain: UILabel!
    @IBOutlet weak var lblsevcReq: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hlabel.text = "Home"
        btnright.setTitle("Glossary", for: .normal)
        btnleft.isHidden = true
        self.view.backgroundColor = UIColor(red: 0/255, green: 180/255, blue: 68/255, alpha: 1)
        lblsevcReq.text = "Customer\nService Request"
        lblMain.attributedText = sendAttString(.boldSystemFont(ofSize: 43), color1: .black, text1: "Zero", font2: .boldSystemFont(ofSize: 43), color2: UIColor(red: 253/255, green: 180/255, blue: 94/255, alpha: 1), text2: "Waste")
        btnright.addTarget(self, action: #selector(BtnGlosry(_:)), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.title = "Home"
    }

    @IBAction func btnContnue(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TabBar") as! TabBar
        self.navigationController?.pushViewController(vc, animated: true)
    }
//    @IBAction func btnGlossry(_ sender: Any) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "GlossaryVc") as! GlossaryVc
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    
    func BtnGlosry(_ sender : UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "GlossaryVc") as! GlossaryVc
        self.navigationController?.pushViewController(vc, animated: true)
    }
   
    @IBAction func btnGlossry(_ sender: Any) {
      
    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func sendAttString(_ font1: UIFont, color1: UIColor, text1: String, font2: UIFont, color2: UIColor, text2: String) -> NSMutableAttributedString{
        let attributes1 = [NSFontAttributeName: font1, NSForegroundColorAttributeName: color1]
        let myAttrString1 = NSAttributedString(string: text1, attributes: attributes1)
        let attributes2 = [NSFontAttributeName: font2, NSForegroundColorAttributeName: color2]
        let myAttrString2 = NSAttributedString(string: text2, attributes: attributes2)
        let attString : NSMutableAttributedString = NSMutableAttributedString(attributedString: myAttrString1)
        attString.append(myAttrString2)
        return attString
    }
}

