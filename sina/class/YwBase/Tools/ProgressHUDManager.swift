//
//  ProgressHUDManager.swift
//  SVProgressHUD的应用
//
//  Created by Mac on 16/12/2.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class ProgressHUDManager {
    // MARK: --forColor
    class func setBackgroundColor(color: UIColor) {
        SVProgressHUD.setBackgroundColor(color)
    }
    
    class func setForegroundColor(color: UIColor) {
        SVProgressHUD.setForegroundColor(color)
    }
    
    // MARK: --show
    class func dismiss() {
        SVProgressHUD.dismiss()
    }
    
    class func show() {
        SVProgressHUD.show()
    }
    
    class func showWithStatus(status: String) {
        SVProgressHUD.showWithStatus(status)
    }
    
    // MARK: --oftenUse
    class func setSuccessImage(image: UIImage) {
        SVProgressHUD.setSuccessImage(image)
    }
    
    class func showSuccessWithStatus(string: String) {
        SVProgressHUD.showSuccessWithStatus(string)
    }
    
    class func setInfoImage(image: UIImage) {
        SVProgressHUD.setInfoImage(image)
    }
    
    class func showInfoWithStatus(string: String) {
        SVProgressHUD.showInfoWithStatus(string)
    }
    
    class func setErrorImage(image: UIImage) {
        SVProgressHUD.setErrorImage(image)
    }
    
    class func showErrorWithStatus(string: String) {
        SVProgressHUD.showErrorWithStatus(string)
    }
    
    // MARK --others
    class func setFont(font: UIFont) {
        SVProgressHUD.setFont(font)
    }
    
    class func showImage(image: UIImage, status:String) {
        SVProgressHUD.showImage(image, status: status)
    }
    
    class func isVisible() -> Bool {
        return SVProgressHUD.isVisible()
    }
    
    /********设置风格*/
// [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
// [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
// [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
// [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
 
 
}
