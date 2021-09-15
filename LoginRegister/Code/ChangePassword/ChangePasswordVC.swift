//
//  ChangePasswordVC.swift
//  LoginRegister
//
//  Created by Theappfathers on 13/04/21.
//

import UIKit
import Alamofire
import SVProgressHUD

class ChangePasswordVC: UIViewController {

    @IBOutlet weak var txtCurrentPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnResetPassword(_ sender: UIButton) {
        if isValidation(){
//            ChangePasswordWebservice()
        }
    }

    func isValidation() -> Bool{
        if (txtCurrentPassword.text?.isEmpty)! {
            AlertView.showOKTitleMessageAlert(AlertTitle.App_Name, strMessage: AlertMessages.kmsgBlankPassword, viewcontroller: self)
            return false
        }
        if (txtNewPassword.text?.isEmpty)! {
            AlertView.showOKTitleMessageAlert(AlertTitle.App_Name, strMessage: AlertMessages.kmsgBlankPassword, viewcontroller: self)
            return false
        }
        if (txtConfirmPassword.text?.isEmpty)! {
            AlertView.showOKTitleMessageAlert(AlertTitle.App_Name, strMessage: AlertMessages.kmsgBlankPassword, viewcontroller: self)
            return false
        }

        return true
    }

    //MARK:- API WEBSERVICES
  


}
