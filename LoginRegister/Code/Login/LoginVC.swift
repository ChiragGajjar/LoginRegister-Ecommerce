//
//  LoginVC.swift
//  LoginRegister
//
//  Created by Theappfathers on 13/04/21.
//

import UIKit
import Alamofire
import SVProgressHUD
import ObjectMapper

class LoginVC: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        let nextVC = STORYBOARD.instantiateViewController(withIdentifier: "TabbarVC") as! TabbarVC
        self.navigationController?.pushViewController(nextVC, animated: true)

//        if isValidation(){
//            LoginWebservice()
//        }
    }

    @IBAction func btnForgotPassword(_ sender: UIButton) {
        let nextVC = STORYBOARD.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @IBAction func btnSignUpNow(_ sender: UIButton) {
        let nextVC = STORYBOARD.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

    //MARK:- API WEBSERVICES
    
    func LoginWebservice(){
        self.view.endEditing(false)
        
        let urlString = createUrlForWebservice(url: APIManager.LOGIN_URL)
        let getToken = getStringValue(key: UserDefaultsKey.FCM_KEY)

        let param:Parameters = ["mobile":txtUsername.text!,"password":txtPassword.text!,"fcm_token":getToken]
        
        print(param)
        
        SVProgressHUD.show()
        AFWrapper.servicecallWithHeader(url: urlString, Method: .get, Parameter: [:]) { (result, IsSuccess) in
            if IsSuccess == true
            {
                HideProgress()
                
                let mapData  = Mapper<LoginDataModel>().mapArray(JSONString: result ?? "")
                
            }else{
                HideProgress()
            }
        }
    }

}
extension LoginVC{
    func isValidation() -> Bool{
        if (txtUsername.text?.isEmpty)!{
            AlertView.showOKTitleMessageAlert(AlertTitle.App_Name, strMessage: AlertMessages.kmsgBlankUsername, viewcontroller: self)
            
            return false
        }
        if (txtPassword.text?.isEmpty)! {
            AlertView.showOKTitleMessageAlert(AlertTitle.App_Name, strMessage: AlertMessages.kmsgBlankPassword, viewcontroller: self)
            return false
        }
        return true
    }
}
