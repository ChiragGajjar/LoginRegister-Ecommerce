//
//  ForgotPasswordVC.swift
//  LoginRegister
//
//  Created by Theappfathers on 13/04/21.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var txtMobile: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnSendOTP(_ sender: UIButton) {

    }



}
extension ForgotPasswordVC{
    func isValidation() -> Bool{
        if (txtMobile.text?.isEmpty)!{
            AlertView.showOKTitleMessageAlert(AlertTitle.App_Name, strMessage: AlertMessages.kmsgBlankEmail, viewcontroller: self)
            
            return false
        }
        if !isValidEmail(testStr: txtMobile.text!){
            AlertView.showOKTitleMessageAlert(AlertTitle.App_Name, strMessage: AlertMessages.kmsgValidEmail, viewcontroller: self)
            
            return false
        }
        return true
    }
}

