//
//  Colors.swift
//  Latitude
//
//  Created by Ng Zoujiu on 15/9/14.
//  Copyright (c) 2015年 Ng. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex: Int) {
        let alpha = CGFloat((hex >> 24) & 0xff) / 255
        self.init(
            red: CGFloat((hex >> 16) & 0xff) / 255,
            green: CGFloat((hex >> 08) & 0xff) / 255,
            blue: CGFloat((hex >> 00) & 0xff) / 255,
            alpha: alpha > 0 ? alpha : 1.0
        )
        println(alpha)
    }
}

class Colors {
    class func greenLatitude() -> UIColor {
        return UIColor(red: 0, green: 151/255.0, blue: 134/255.0, alpha: 1.0)
    }
    class func greyText() -> UIColor {
        return UIColor(red: 184/255.0, green: 184/255.0, blue: 184/255.0, alpha: 1.0)
    }
    class func forceOne() -> UIColor {
        return UIColor(hex: 0xfa7841)
    }
    class func forceOneLight() -> UIColor {
        return UIColor(hex: 0x66fa7841)
    }
    class func forceOneExtraLight() -> UIColor {
        return UIColor(hex: 0x1afa7841)
    }
    class func forceTwo() -> UIColor {
        return UIColor(hex: 0x225dbf)
    }
    class func forceTwoLight() -> UIColor {
        return UIColor(hex: 0x66225dbf)
    }
    class func forceTwoExtraLight() -> UIColor {
        return UIColor(hex: 0x1a225dbf)
    }
    class func greenLocation() -> UIColor {
        return UIColor(hex: 0x44009786)
    }
    class func greenLocationLight() -> UIColor {
        return UIColor(hex: 0x4400ab97)
    }
}
