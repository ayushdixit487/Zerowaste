//
//  PaymentVC.swift
//  ZeroWasteProject
//
//  Created by MAC on 07/05/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

class PaymentVC: HeaderVC {
    var Amount : String = ""
    var Email : String = ""
    @IBOutlet var webVw: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        hlabel.text = "Pay for Services"
        btnright.isHidden = true
        btnleft.setTitle("Cancel", for: .normal)
        btnleft.addTarget(self, action: #selector(btnHomeAct(_:)), for: .touchUpInside)
        // Do any additional setup after loading the view.
        let myUrl = URL(string: "https://ljwinc.company/zero-waste/payeezy-payment.php")
        
        var request = URLRequest(url:myUrl!)
        
        request.httpMethod = "POST"// Compose a query string
        
        let postString = "amount=\(Amount)&auth_token=alkfsjo4834fjfe43rfjr&email=\(Email)"
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        webVw.loadRequest(request as URLRequest)
    }
    func btnHomeAct(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
