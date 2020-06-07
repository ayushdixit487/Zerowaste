//
//  servicerqCell.swift
//  ZeroWasteProject
//
//  Created by MACBOOK on 28/02/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

class servicerqCell: UITableViewCell {

    @IBOutlet var lblDis: UILabel!
    @IBOutlet var topSpace2: NSLayoutConstraint!
    @IBOutlet var topSpace: NSLayoutConstraint!
    @IBOutlet var btmSpace2: NSLayoutConstraint!
    @IBOutlet var btmSpace: NSLayoutConstraint!
    @IBOutlet var DiscriptionVw: UIView!
    @IBOutlet var btnOpnVw: UIButton!
    @IBOutlet weak var imgV: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

