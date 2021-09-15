//
//  Constants.swift
//  Focus Fitness
//
//  Created by Theappfathers on 26/01/20.
//  Copyright © 2020 Theappfathers. All rights reserved.
//

import Foundation
import UIKit

let STORYBOARD : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
struct GlobalConstants {
    static let appName    =  Bundle.main.infoDictionary!["CFBundleName"] as! String
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate

    static let GoogleClientId = "1076560652631-7td9st7trq226c095hn5eh2v7ulam2kh.apps.googleusercontent.com"

}


struct CommonColor {
    static let app_blue = "00ACFF"
    static let dargGray = "A1A1A1"
    static let white = "ffffff"
    static let grayday = "787B7C"
    static let darkBlue = "1D518D"
}

struct THEME {
    static let BGCOLOR = UIColor.white
    static let BUTTON_BGCOLOR = UIColor.white
    static let NAVIGATIONTITLE_COLOR = UIColor(red: 172/255.0, green: 29/255.0, blue: 56/255.0, alpha: 1.0)
    static let FONTCOLOR = UIColor(red: 0/255.0, green: 186/255.0, blue: 212/255.0, alpha: 1.0)
    static let ReapetsViewBack = UIColor(red: 239/255.0, green: 239/255.0, blue: 244/255.0, alpha: 1.0)
    static let ThemeBGColor = UIColor(red: 255/255.0, green: 235/255.0, blue: 235/255.0, alpha: 1.0)
    static let ThemeSelColor = UIColor(red: 173/255.0, green: 208/255.0, blue: 249/255.0, alpha: 1.0)

}
