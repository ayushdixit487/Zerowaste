//
//  PayScreenVC.swift
//  ZeroWasteProject
//
//  Created by Apple on 01/03/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import PayeezySDK
import IQKeyboardManager
import PassKit
import Stripe
import SwiftyJSON
import Alamofire
import DropDown
class PayScreenVC: HeaderVC,UITextFieldDelegate, UIAlertViewDelegate {
    
    
    @IBOutlet var btnServices: UIButton!
    @IBOutlet var DrrpDwnVw: UIView!
    var url : String = "http://localhost/zero-waste/web/charge.php"
    let myUrl = URL(string: "http://localhost/zero-waste/web/charge.php")
    var authStatusMessage = ""
    var paymntReq : PKPaymentRequest!
    
    @IBOutlet var webVw: UIWebView!
    @IBOutlet weak var btnPay: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tfCrdno: SkyFloatingLabelTextField!
    @IBOutlet weak var tfname: SkyFloatingLabelTextField!
    @IBOutlet weak var tfExpDate: SkyFloatingLabelTextField!
    @IBOutlet weak var tfcvv: SkyFloatingLabelTextField!
    @IBOutlet weak var tfAmount: SkyFloatingLabelTextField!
    @IBOutlet weak var tfEmail: SkyFloatingLabelTextField!
    let expiryDatePicker = MonthYearPickerView()
     let dropDown = DropDown()
    override func viewDidLoad() {
        super.viewDidLoad()
        dropDown.anchorView = DrrpDwnVw
        dropDown.dataSource = ["Request Dumpster","Valet Service","Trash recycling","Snow Removal","Dumpster Rental","Dump Truck Rental"]
        hlabel.text = "Pay for Services"
        btnright.isHidden = true
        btnleft.setTitle("Cancel", for: .normal)
         btnleft.addTarget(self, action: #selector(btnHomeAct(_:)), for: .touchUpInside)
         tfEmail.returnKeyType = .next
         tfCrdno.returnKeyType = .next
         webVw.isHidden = true
        DrrpDwnVw.dropShadow()
        btnPay.layer.cornerRadius = 5
     //STPAddCardViewController.delegate =  self
    }
    
   
    func btnHomeAct(_ sender: Any) {
        if webVw.isHidden {
            self.navigationController?.popViewController(animated: true)
        }else{
            webVw.isHidden = true
            tfCrdno.isHidden = false
            tfname.isHidden =  false
            tfEmail.isHidden = false
            btnPay.isHidden =  false
        }
        //self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnActSrvcs(_ sender: Any) {
        dropDown.show()
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.btnServices.setTitle(item, for: .normal)
            self.btnServices.dropShadow()
    }
    }
    
    @IBAction func btnCancl(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tfEmail{
            tfCrdno.becomeFirstResponder()
        }
        else if textField == tfCrdno{
            tfname.becomeFirstResponder()
        }
        
        else{
            textField.resignFirstResponder()
        }
        return true
    }

    
    func donePressed(){
        self.view.endEditing(true)
      
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
    
    @IBAction func btnPayNow(_ sender: Any) {
        if tfEmail.text == ""{
            displayMsg(msgTodisply: "Please enter your Name")
        }else if tfCrdno.text == ""{
             displayMsg(msgTodisply: "Please enter your Email")
        }else if tfname.text == ""{
            displayMsg(msgTodisply: "Please enter  Amount to be paid")
        }else if !isValidEmailAddress(emailAddressString: tfCrdno.text!){
            displayMsg(msgTodisply: "Please enter Email Correctly")
        }else if btnServices.currentTitle == "Services"{
            displayMsg(msgTodisply: "Please Select  Services")
        }else{
             print("sucess")
//            let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "PaymentVC") as! PaymentVC
//            secondVC.Amount = tfname.text!
//            secondVC .Email  = tfCrdno.text!
            
//    *        let myUrl = URL(string: "https://ljwinc.company/zero-waste/payeezy-payment.php")
//
//            var request = URLRequest(url:myUrl!)
//
//            request.httpMethod = "POST"// Compose a query string
//
//            let postString = "amount=\(tfname.text!)&auth_token=alkfsjo4834fjfe43rfjr&email=\(tfCrdno.text!)"
//
//            request.httpBody = postString.data(using: String.Encoding.utf8)
//
//            webVw.loadRequest(request as URLRequest)
//            webVw.isHidden = false
//            tfCrdno.isHidden = true
//            tfname.isHidden =  true
//            tfEmail.isHidden = true
//    *        btnPay.isHidden =  true
            
            //self.navigationController?.pushViewController(secondVC, animated: true)
            let theme = STPTheme()
            if #available(iOS 11.0, *) {
                theme.accentColor = UIColor(named: "Mocha")
            } else {
                // Fallback on earlier versions
            }
            let config = STPPaymentConfiguration.shared()
            let addCardViewController = STPAddCardViewController.init(configuration: config, theme: theme);
            addCardViewController.delegate = self;
            
            let navigationController = UINavigationController(rootViewController: addCardViewController);
            self.present(navigationController, animated: true, completion: nil);
            //self.navigationController?.pushViewController(addCardViewController, animated: true)

        }
        
    }

    func displayMsg(msgTodisply: String){
        let alertController = UIAlertController(title: msgTodisply, message: nil, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            // Code in this block will trigger when OK button tapped.
            print("Ok button tapped");
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
    }
    
}
extension PayScreenVC: STPAddCardViewControllerDelegate {
    
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        addCardViewController.dismiss(animated: true, completion: nil)
    }
   
    
    func addCardViewController(_ addCardViewController: STPAddCardViewController,
                               didCreateToken token: STPToken,
                               completion: @escaping STPErrorBlock) {
       // StripeClient.shared.completeCharge(with: token, amount: tfname.text!, email: tfCrdno.text!)
       // let url = baseURL
        // 2
        let params: [String: String] = [
            "stripeToken": token.tokenId,
            "amount": tfname.text!,
            "stripeEmail" : tfCrdno.text!,
            "service" : btnServices.title(for: .normal)!]
       
        print(params)
        
        Alamofire.request( Constants.baseURLString, method : .post, parameters:params,encoding: URLEncoding.default,headers: [:]).responseJSON {
            response in
            let statusCode = response.response?.statusCode
            
            do {
                //                    let result = try doSomething()
                let json = try JSON(data: response.data!)
                switch response.result{
                    
                case .success(_):
                    if(statusCode==200){
                        if let data = response.result.value{
//                            success(json)
                            let alertController = UIAlertController(title: "Congrats", message: "Your payment was successful!", preferredStyle: .alert)
                            
                            
                            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                                addCardViewController.dismiss(animated: true, completion: nil)
                                self.tfname.text = ""
                                self.tfCrdno.text = ""
                                self.tfEmail.text = ""
                            }
                            
                            alertController.addAction(OKAction)
                            
                            addCardViewController.present(alertController, animated: true, completion:nil)
                        }
                    }
                    else{
                        let alert = UIAlertController(title: "Warning", message: "Error", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        addCardViewController.present(alert, animated: true, completion: nil)

                        //                        failure(json)
                        if let data = response.result.value{
                            let dict = data as! NSDictionary
//                            if statusCode == 403{
//                                //                                    deleteData()
//                                let navCon = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
//                                navCon.popToRootViewController(animated: true)
//                            }else{
//                                if let value = dict.value(forKey: "error_description"){
//                                    failure(dict.value(forKey: "error_description") as! String)
//                                }else{
//                                    failure(dict.value(forKey: "message") as! String)
//                                }
//                            }
                        }
                    }
                    break
                    
                case .failure(_):
                    if let error = response.result.error{
                        //                        failure(json)
                        let alert = UIAlertController(title: "Warning", message: "Error", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        addCardViewController.present(alert, animated: true, completion: nil)

//                        failure(error.localizedDescription as String)
                    }
                }
            }
            catch {
//                failure("Something went wrong. Please try again")
                // Here you know about the error
                // Feel free to handle to re-throw
            }
            
            
        }
        /*
        ApiHandler.callApiWithParameters(url: Constants.baseURLString, withParameters: params as [String : AnyObject], success: { (json) in
            print(json)
            let alertController = UIAlertController(title: "Congrats", message: "Your payment was successful!", preferredStyle: .alert)


            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                addCardViewController.dismiss(animated: true, completion: nil)
                self.tfname.text = ""
                self.tfCrdno.text = ""
                self.tfEmail.text = ""
            }

            alertController.addAction(OKAction)

            addCardViewController.present(alertController, animated: true, completion:nil)
            //completion(error as! Error)
            print("Sucess")
        }, failure: { string in
            //    self.apiLoading = false
            let alert = UIAlertController(title: "Warning", message: string, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            addCardViewController.present(alert, animated: true, completion: nil)

        }, method: ApiMethod.POST, img: nil, imageParamater: "", headers: [:])*/
//        Alamofire.request(Constants.baseURLString, method: .post, parameters: params, encoding: JSONEncoding.init(options: .prettyPrinted))
//            .responseJSON { response in
//                print(response)
//                switch response.result {
//                case .success(let error):
//
//                    print(response.response!.statusCode)
//
//                    let alertController = UIAlertController(title: "Congrats", message: "Your payment was successful!", preferredStyle: .alert)
//
//
//                    let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
//                        addCardViewController.dismiss(animated: true, completion: nil)
////                        self.tfname.text = ""
////                        self.tfCrdno.text = ""
////                        self.tfEmail.text = ""
////                        self.btnServices.setTitle("Services", for: .normal)
//                    }
//
//                    alertController.addAction(OKAction)
//
//                    addCardViewController.present(alertController, animated: true, completion:nil)
//                //completion(error as! Error)
//                case .failure(let error):
//                    let alertController = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: .alert)
//                    let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
//                        addCardViewController.dismiss(animated: true, completion: nil)
//                        self.tfname.text = ""
//                        self.tfCrdno.text = ""
//                        self.tfEmail.text = ""
//                        self.btnServices.setTitle("Services", for: .normal)
//                    }
//
//                    alertController.addAction(OKAction)
//                    addCardViewController.present(alertController, animated: true, completion:nil)
//                    completion(error)
//
//                }
//        }
//        Alamofire.request(Constants.baseURLString, method: .post, parameters: params)
//            .responseString { response in
//
//        }
    }
}

