//
//  HeaderVC.swift
//  ZeroWasteProject
//
//  Created by Apple on 06/03/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

class HeaderVC: UIViewController {

    let hView = UIView()
    let hlabel = UILabel()
    let btnleft = UIButton()
    let btnright = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        hView.frame = CGRect(x: 0, y: 20, width: self.view.frame.width, height: 64)
        hlabel.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64)
        hlabel.textAlignment = .center
        hlabel.textColor = .white
        hView.backgroundColor = UIColor(netHex: COLORS.THEMECOLOR.rawValue)
        btnleft.frame = CGRect(x: 0, y: 0, width: 120, height: 64)
        btnleft.contentHorizontalAlignment = .left
        btnright.frame = CGRect(x: self.view.frame.width-120, y: 0, width: 120, height: 64)
        btnright.contentHorizontalAlignment = .right
        btnleft.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        btnright.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        btnleft.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        hlabel.font = UIFont(name:"OpenSans", size: 18)
        btnleft.titleLabel?.font = UIFont(name:"OpenSans", size: 18)
        btnright.titleLabel?.font = UIFont(name:"OpenSans", size: 18)
        let image = UIImage(named: "ic_keyboard_arrow_left")
        let tintcolr = image?.withRenderingMode(.alwaysTemplate)
        btnleft.setImage(tintcolr, for: .normal)
        btnleft.tintColor = UIColor.white        
        btnleft.tintColor = .white
        btnright.tintColor = .white
        self.hView.addSubview(hlabel)
        self.hView.addSubview(btnleft)
        self.hView.addSubview(btnright)
        self.view.addSubview(hView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
