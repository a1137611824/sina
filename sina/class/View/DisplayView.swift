//
//  DisplayView.swift
//  sina
//
//  Created by Mac on 17/3/13.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class DisplayView: UIView {


    var displayImageUrls:[String] {
        get{
            return self.displayImageUrls
        }
        set(newValues){
            let array = self.subviews
            
            for i in 0..<array.count {
                //将原来的视图从父类移除
                let v = array[i]
                v.removeFromSuperview()
            }
            
            let urlCount = newValues.count
            if urlCount == 1 {
                let imageView = UIImageView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width/2.0, 200.0))
                //设置图片的内容模式为填充满
                imageView.contentMode = UIViewContentMode.ScaleToFill
                //将图片剪切下
                imageView.clipsToBounds = true
                let url = NSURL(string: newValues[0])
                imageView.sd_setImageWithURL(url)
                self.addSubview(imageView)
                
            }else if urlCount > 1 && urlCount <= 3 {
                for j in 0..<urlCount {
                    let perHeight = (UIScreen.mainScreen().bounds.size.width - CGFloat(16) - CGFloat(2*2))/CGFloat(3)
                    let imageView = UIImageView(frame: CGRectMake(perHeight*CGFloat(j) + 2.0*CGFloat(j),0, perHeight,perHeight))
                    imageView.contentMode = .ScaleToFill
                    imageView.clipsToBounds = true
               
                    let url = NSURL(string: newValues[j])
                    imageView.sd_setImageWithURL(url)
                    self.addSubview(imageView)
                }
                
            }else if urlCount > 3 && urlCount <= 6 {
                var count = 0
                for i in 0..<2 {
                    for j in 0..<3 {
                        if count == urlCount {
                            break
                        }
                        let perHeight = (UIScreen.mainScreen().bounds.size.width - CGFloat(16) - CGFloat(2*2))/CGFloat(3)
                        let imageView = UIImageView(frame: CGRectMake(perHeight*CGFloat(j) + 2.0*CGFloat(j), perHeight*CGFloat(i) + 2.0*CGFloat(i), perHeight,perHeight))
                        imageView.contentMode = .ScaleToFill
                        imageView.clipsToBounds = true
                        
                        let url = NSURL(string: newValues[count])
                        imageView.sd_setImageWithURL(url)
                        self.addSubview(imageView)
                        count += 1
                        
                    }
                }
                
            }else{
                var count = 0
                for i in 0..<3 {
                    for j in 0..<3 {
                        if count == urlCount {
                            break
                        }
                        let perHeight = (UIScreen.mainScreen().bounds.size.width - CGFloat(16) - CGFloat(2*2))/CGFloat(3)
                        let imageView = UIImageView(frame: CGRectMake(perHeight*CGFloat(j) + 2.0*CGFloat(j), perHeight*CGFloat(i) + 2.0*CGFloat(i), perHeight,perHeight))
                        imageView.contentMode = .ScaleToFill
                        imageView.clipsToBounds = true
                        
                        let url = NSURL(string: newValues[count])
                        imageView.sd_setImageWithURL(url)
                        self.addSubview(imageView)
                        count += 1
                        
                    }
                }
            }
            
        }
    }

}
