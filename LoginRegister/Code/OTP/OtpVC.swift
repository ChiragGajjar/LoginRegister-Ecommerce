//
//  OtpVC.swift
//  LoginRegister
//
//  Created by Theappfathers on 13/04/21.
//

import UIKit
import Alamofire
import SVProgressHUD

class OtpVC: UIViewController {

    @IBOutlet weak var txtOTP1: UITextField!
    @IBOutlet weak var txtOTP2: UITextField!
    @IBOutlet weak var txtOTP3: UITextField!
    @IBOutlet weak var txtOTP4: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        txtOTP1.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        txtOTP2.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        txtOTP3.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        txtOTP4.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)


        // Do any additional setup after loading the view.
    }

    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnConfirm(_ sender: UIButton) {
        let strOTP = "\(txtOTP1.text ?? "")\(txtOTP2.text ?? "")\(txtOTP3.text ?? "")\(txtOTP4.text ?? "")"

        
    }
    @IBAction func btnResendOTP(_ sender: UIButton) {

    }

    @objc func textFieldDidChange(textField: UITextField){
        let text = textField.text
        if  text?.count == 1 {
            switch textField{
            case txtOTP1:
                txtOTP2.becomeFirstResponder()
            case txtOTP2:
                txtOTP3.becomeFirstResponder()
            case txtOTP3:
                txtOTP4.becomeFirstResponder()
            case txtOTP4:
                txtOTP4.resignFirstResponder()
            default:
                break
            }
        }
        if text?.count == 0 {
            switch textField{
            case txtOTP1:
                txtOTP1.becomeFirstResponder()
            case txtOTP2:
                txtOTP1.becomeFirstResponder()
            case txtOTP3:
                txtOTP2.becomeFirstResponder()
            case txtOTP4:
                txtOTP3.becomeFirstResponder()
            default:
                break
            }
        }else{
            
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        if textField.text!.count == 1{
            if let char = string.cString(using: String.Encoding.utf8) {
                let isBackSpace = strcmp(char, "\\b")
                if (isBackSpace == -92) {
                    print("Backspace was pressed")
                    return true
                }
            }
            return false
        }
        return true
    }
    

}
