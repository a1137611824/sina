//
//  Color+Extension.swift
//  sina
//
//  Created by Mac on 17/3/11.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

//对颜色的拓展
extension UIColor {
    
    //自定义颜色
    class func colorWithCustom(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
    }
    
    //产生随机颜色
    class func randomColor() -> UIColor {
        let r = CGFloat(arc4random_uniform(256))
        let g = CGFloat(arc4random_uniform(256))
        let b = CGFloat(arc4random_uniform(256))
        return UIColor.colorWithCustom(r, g: g, b: b)
    }
}


