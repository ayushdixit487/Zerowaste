//
//  TabBar.swift
//  ZeroWasteProject
//
//  Created by MACBOOK on 28/02/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.barTintColor  = UIColor(netHex: COLORS.THEMECOLOR.rawValue)
        self.tabBar.tintColor = UIColor.white
        self.tabBar.unselectedItemTintColor = UIColor(white: 0.9, alpha: 1)
        // Do any additional setup after loading the view.
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
