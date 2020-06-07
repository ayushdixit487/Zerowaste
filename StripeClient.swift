//
//  StripeClient.swift
//  ZeroWasteProject
//
//  Created by MAC on 05/07/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import Foundation
import Alamofire
import Stripe
import SwiftyJSON
enum Result {
    case success
    case failure(Error)
}

final class StripeClient {
    
    static let shared = StripeClient()
    
    private init() {
        // private
    }
    
    private lazy var baseURL: URL = {
        guard let url = URL(string: Constants.baseURLString) else {
            fatalError("Invalid URL")
        }
        return url
    }()
    
    func completeCharge(with token: STPToken, amount: String, email : String){
        // 1
//        let url = baseURL
//        // 2
//        let params: [String: String] = [
//            "stripeToken": token.tokenId,
//            "amount": amount,
//            "stripeEmail" : email]
//        
//        Alamofire.request(url, method: .post, parameters: params)
//            .validate(statusCode: 200..<300)
//            .responseString { response in
//                switch response.result {
//                case .success:
//                let alertController = UIAlertController(title: "Congrats", message: "Your payment was successful!", preferredStyle: .alert)
//                
//                
//                let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
//                    addCardViewController.dismiss(animated: true, completion: nil)
//                    self.tfname.text = ""
//                    self.tfCrdno.text = ""
//                    self.tfEmail.text = ""
//                }
//                
//                alertController.addAction(OKAction)
//                
//                addCardViewController.present(alertController, animated: true, completion:nil)
//                  //  completion(Result.success)
//                case .failure(let error): break
//                   // completion(Result.failure(error))
//                }
//        }
    }
       
            
        }
    

