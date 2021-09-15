//
//  RegisterVC.swift
//  LoginRegister
//
//  Created by Theappfathers on 13/04/21.
//

import UIKit

class RegisterVC: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtCode: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnBackToLogin(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnTermsCondition(_ sender: UIButton) {
        if sender.isSelected{
            sender.isSelected = false
        }else{
            sender.isSelected = true
        }
    }

    
    @IBAction func btnSignUp(_ sender: UIButton) {

    }


}
