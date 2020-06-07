//
//  COLORS.swift
//  ZeroWasteProject
//
//  Created by Apple on 06/03/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

enum COLORS : Int{
    case THEMECOLOR = 0x45AB53,
    LIGHTGRAY = 0xE7E7E7,
    IGCOLOR = 0x919191
}

let BASE_URL = "http://ljwinc.company/zero-waste/schedule-service-mail.php"
let BASE_URL2 = "http://ljwinc.company/zero-waste/service-mail.php"
func loadingOnScreen(_ mainViewFrame:CGRect) -> UIView{
    let loadingView = UIView(frame : CGRect(x: 0, y: 0, width: mainViewFrame.width, height: mainViewFrame.height))
    loadingView.backgroundColor = UIColor.black
    loadingView.alpha = 0.6

    let laodingFrame = SpinnerView(frame: CGRect(x: mainViewFrame.width/2 - 20, y: mainViewFrame.height/2 - 20, width: 40, height: 40))
    loadingView.addSubview(laodingFrame)

    return loadingView
}
