//
//  BaseController.swift
//  slider
//
//  Created by 알버트 on 2017. 8. 25..
//  Copyright © 2017년 visionboy.me. All rights reserved.
//

import UIKit

class BaseController : NSObject {
    
    /// 单例
    static let BS: BaseController = BaseController()
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.grayColor()
        }
        
        var rgbValue:UInt32 = 0
        NSScanner(string: cString).scanHexInt(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func alert(message:String) {
        let alert = UIAlertView(title: "Message",
                                message: message,
                                delegate: nil,
                                cancelButtonTitle: "OK")
        alert.show()
    }
    
}
