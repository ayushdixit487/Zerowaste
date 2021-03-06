//
//  WasteMngmntVC.swift
//  ZeroWasteProject
//
//  Created by MACBOOK on 28/02/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import MessageUI
import skpsmtpmessage
import SwiftyJSON
import Alamofire
import DropDown

class WasteMngmntVC: HeaderVC,MFMailComposeViewControllerDelegate,UITextFieldDelegate,SKPSMTPMessageDelegate {
    func messageSent(_ message: SKPSMTPMessage!) {
        print("delegate - message sent")
        displayMsg(msgTodisply: "message sent")
        //sendEmailInBackground()
    }
    
    func messageFailed(_ message: SKPSMTPMessage!, error: Error!) {
         displayMsg(msgTodisply: "error")
        print("delegate - error(\(String(describing: (error as NSError?)?.code  ))): \(String(describing: error?.localizedDescription))")
    }
    
    var header = ""
    
    @IBOutlet var btnSS: UIButton!
    @IBOutlet var firstNmTop: NSLayoutConstraint!
    @IBOutlet var btnSize: UIButton!
    @IBOutlet var SizeVw: UIView!
    @IBOutlet var btnSrvcs: UIButton!
    @IBOutlet var DrpDwnVw: UIView!
    @IBOutlet weak var BtnCode: UIButton!
    @IBOutlet weak var lblGet: UILabel!
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var tfzip: SkyFloatingLabelTextField!
    @IBOutlet weak var tfFirstnm: SkyFloatingLabelTextField!
    @IBOutlet weak var tfEmail: SkyFloatingLabelTextField!
    @IBOutlet weak var tfLastNm: SkyFloatingLabelTextField!
    @IBOutlet weak var tfState: SkyFloatingLabelTextField!
    @IBOutlet weak var tfCity: SkyFloatingLabelTextField!
    @IBOutlet weak var tfAddress: SkyFloatingLabelTextField!
    @IBOutlet weak var tfCompny: SkyFloatingLabelTextField!
    @IBOutlet weak var tfPhn: SkyFloatingLabelTextField!
    let dropDown = DropDown()
    let dropDown2 = DropDown()
    let dropDown3  = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dropDown.anchorView = DrpDwnVw // UIView or UIBarButtonItem
        dropDown2.anchorView = SizeVw
        dropDown3.anchorView = tfAddress
        dropDown3.anchorView = btnSS
        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = ["Valet Service","Trash recycling","Snow Removal","Dumpster Rental","Dump Truck Rental"]
        dropDown3.dataSource = ["D - Delivery","DR - Dump & Return","F - Final Pull","R - Relocate"]
        btnright.isHidden = true
        //btnleft.setTitle("Services", for: .normal)
        btnleft.addTarget(self, action: #selector(btnsetting(_:)), for: .touchUpInside)
        SizeVw.dropShadow(scale: true)
         tfEmail.returnKeyType = .next
        tfFirstnm.returnKeyType = .next
        tfLastNm.returnKeyType = .next
       // tfState.returnKeyType = .next
       // tfCity.returnKeyType = .next
        tfAddress.returnKeyType = .next
        tfCompny.returnKeyType = .next
        tfPhn.returnKeyType = .next
        SizeVw.isHidden = true
        firstNmTop.constant = 0
         BtnCode.layer.cornerRadius = 5
        DrpDwnVw.dropShadow()
        SizeVw.dropShadow()
        btnSrvcs.isUserInteractionEnabled = false
        // Do any additional setup after loading the view.
    }
    func btnsetting(_ sender: Any) {
        let topVC = self.navigationController?.topViewController as! TabBar
        topVC.selectedIndex = 0
    }
    override func viewDidAppear(_ animated: Bool) {
          hlabel.text = header
        if header == "Dumpster Rental" || header  == "Dump Truck Rental"{
            SizeVw.isHidden = false
            firstNmTop.constant = 30
            SizeVw.dropShadow()
        }
        else{
            SizeVw.isHidden = true
            firstNmTop.constant = 30
           // SizeVw.dropShadow(scale: false)
        }
        SizeVw.dropShadow(scale: true)
        if header != ""{
            btnSrvcs.setTitle(header, for: .normal)
            
        }else{
            hlabel.text = "Request Dumpster"
            btnSrvcs.setTitle("Schedule Services", for: .normal)
            
        }
        if header == "Schedule Services"{
            hlabel.text = "Request Dumpster"
            btnSrvcs.setTitle("Schedule Services", for: .normal)
        }
    }
    
    
   
    @IBAction func btnActSelectServiceCode(_ sender: Any) {
        dropDown3.show()
        dropDown3.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.tfAddress.text = item
            self.btnSS.dropShadow()
    }
    }
    
    @IBAction func TapSelectServicesCode(_ sender: Any) {
        dropDown3.show()
        dropDown3.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.tfAddress.text = item
            self.tfAddress.dropShadow()
        }
    }
    @IBAction func btnActSize(_ sender: UIButton) {
        if btnSrvcs.title(for: .normal) == "Dumpster Rental"{
            dropDown2.dataSource = ["10 Yard - 10 ft long, 4 ft tall, 7 ft wide","15 Yard - 10 ft long, 5.5 ft tall, 7 ft wide","20 Yard -  22 ft long, 4.5 ft tall, 7 ft wide","30 Yard -  22 ft long, 6 ft tall, 7 ft wide","40 Yard -  22 ft long, 7 ft tall, 7 ft wide"]
        }
        if btnSrvcs.title(for: .normal) == "Dump Truck Rental" {
            dropDown2.dataSource = ["Single/axle","Tri/axle"]
            
        }
        dropDown2.show()
        dropDown2.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.btnSize.setTitle(item, for: .normal)
            self.SizeVw.dropShadow()
        }
    }
   
    @IBAction func btnActSrvcs(_ sender: UIButton) {
        
        dropDown.show()
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
             print("Selected item: \(item) at index: \(index)")
            self.btnSrvcs.setTitle(item, for: .normal)
            self.hlabel.text = item
            self.btnSize.setTitle("Size", for: .normal)
            if item == "Dumpster Rental" || item  == "Dump Truck Rental"{
                self.SizeVw.isHidden = false
                self.firstNmTop.constant = 30
                self.SizeVw.dropShadow()
            }
            else{
                self.SizeVw.isHidden = true
                self.firstNmTop.constant = 30
            }
            }
       // dropDown.hide()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tfFirstnm{
            tfLastNm.becomeFirstResponder()
        }
        else if textField == tfLastNm{
            tfEmail.becomeFirstResponder()
        }
        else if textField == tfEmail{
            tfPhn.becomeFirstResponder()
        }
        else if textField == tfPhn{
            tfCompny.becomeFirstResponder()
        }else if textField == tfCompny{
            tfAddress.becomeFirstResponder()
        }
        else{
            textField.resignFirstResponder()
        }
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnServices(_ sender: Any) {
        let topVC = self.navigationController?.topViewController as! TabBar
        topVC.selectedIndex = 0

    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == ""{
            return true
        }
//        switch textField{
//        case tfzip:
//            if tfzip.text?.count == 6{
//                return false
//            }
//        default:
//            print("")
//        }
        return true
    }
    
    func displayMsg(msgTodisply: String){
        let alertController = UIAlertController(title: "Alert!", message: msgTodisply, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            if msgTodisply == "Email has been sent successfully"{
                let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBar") as! TabBar
                secondVC.selectedIndex = 0
                //secondVC.header = lblname[_sender.tag]
                
                self.navigationController?.pushViewController(secondVC, animated: true)
            }
            // Code in this block will trigger when OK button tapped.
            print("Ok button tapped");
        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
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
    @IBAction func btnGetCode(_ sender: Any) {
         if hlabel.text == ""{
            displayMsg(msgTodisply: "Please select Service Code")
        }else if tfFirstnm.text == ""{
            displayMsg(msgTodisply: "Please enter your First Name")
        }else if tfLastNm.text == ""{
            displayMsg(msgTodisply: "Please enter your Last Name")
        }else if !isValidEmailAddress(emailAddressString: tfPhn.text!) && tfPhn.text != ""{
            
            displayMsg(msgTodisply: "Please enter Email Correctly")
         }else if tfAddress.text == ""{
            displayMsg(msgTodisply: "Please enter your Address")
        }
        else{

            sendApiEmail()

        }
    }

    func sendApiEmail(){
        let overlay = loadingOnScreen(self.view.frame)
        self.view.addSubview(overlay)
        
        var params : [String:String] = [ : ]
        if hlabel.text == "Dumpster Rental" || hlabel.text  == "Dump Truck Rental"{
            params = ["size" : btnSize.title(for: .normal),
            "service_type"  :   hlabel.text!,
            "name"    :   tfFirstnm.text!,
            "location"     :   tfLastNm.text!,
            "telephone"         :   tfEmail.text!,
            "email"     :   tfPhn.text!,
            "size_on_site"       :   tfCompny.text!,
            "service_code"       :   tfAddress.text!]
                 as! [String : String]
        }else{
            params = ["size" : " ",
                      "service_type"  :   hlabel.text!,
                      "name"    :   tfFirstnm.text!,
                      "location"     :   tfLastNm.text!,
                      "telephone"         :   tfEmail.text!,
                      "email"     :   tfPhn.text!,
                      "size_on_site"       :   tfCompny.text!,
                      "service_code"       :   tfAddress.text!
                      ]
        }
        Alamofire.request("\(BASE_URL)" ,method : .get,parameters:params as [String:AnyObject],encoding:URLEncoding.default ,headers: [:]).responseString{
            response in
            overlay.removeFromSuperview()

//        } //responseJSON { response
//            in
            let statusCode = response.response?.statusCode
            do {
                //                    let result = try doSomething()
                let json = try JSON(data: response.data!)

                switch response.result{

                case .success(_):
                    if(statusCode==200){

                        let bully = response.description as! String

                        if bully.contains("Success"){
                            self.displayMsg(msgTodisply: "Email has been sent successfully")
                        }else{
                            self.displayMsg(msgTodisply: "Something went wrong")
                        }

//                        if let data = response.result.value{
////                            success(json)
//                        }
                    }
                    else{
                        self.displayMsg(msgTodisply: "Something went wrong")

                    }
                    break
                case .failure(_):
                    self.displayMsg(msgTodisply: "Something went wrong")
                    if let error = response.result.error{
                        let str = error.localizedDescription as String
         
                    }

                }
            }
            catch {
                self.displayMsg(msgTodisply: "Something went wrong")
//                failure("Something went wrong. Please try again")
                // Here you know about the error
                // Feel free to handle to re-throw
            }

        }

//        ApiHandler.callApiWithParameters(url: "", withParameters: params as [String : AnyObject], success: { (json) in
//            self.displayMsg(msgTodisply: "Email has been sent successfully")
//            overlay.removeFromSuperview()
//        }, failure: { (string) in
//            self.displayMsg(msgTodisply: "Something went wrong")
//            overlay.removeFromSuperview()
//        }, method: ApiMethod.GET, img: nil, imageParamater: "", headers: [:])



    }

    func configureMaailController() -> MFMailComposeViewController{
        let mailComposerVc = MFMailComposeViewController()
        mailComposerVc.mailComposeDelegate = self
        mailComposerVc.setToRecipients(["support@ljwinc.com"])
        mailComposerVc.setSubject("Required Quote for “\(hlabel.text ?? "")”")
        mailComposerVc.setMessageBody("Hello Sir,\n\n I have checked the app and I would like to get quote for  \n\n Here are the details about the project.\nFirst Name: \( tfFirstnm.text ?? "")\nLast Name: \(tfLastNm.text ?? "")/n Email: \(tfEmail.text ?? "")\n Country: \(tfCompny.text ?? "")\n Address: \(tfAddress.text ?? "")\n City: \(tfCity.text ?? "")\n State: \(tfState.text ?? "")\nZip code: \( tfzip.text ?? "")\nPhone: \(tfPhn.text ?? "") \n\n\nLooking forward to get a quote as soon as possible.\n\n\n Thanks", isHTML: false)
        
        return mailComposerVc
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    

}
extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
