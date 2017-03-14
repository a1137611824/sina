//
//  WBHelper.swift
//  sina
//
//  Created by Mac on 17/3/12.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class WBHelper: NSObject {


    
    //设置时间格式
    class func timeLineWithStringDate(dateString: String?) -> String? {
        
        /*
         设置事件函数
            一分钟前    刚刚
            一小时前    几分钟前
            一天之前    几小时之前
            昨天之前    昨天 几时几分
            一年之内    几月几日
            几年前     年月日
         
         
         */
        //实例化一个对象格式
        let dateFormatter = NSDateFormatter()
        //设置时间格式为自己需要的格式 EEE MMM d HH:mm:ss Z yyyy
        dateFormatter.dateFormat = "EEE MMM d HH:mm:ss Z yyyy"
        //设置地区
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
        let date = dateFormatter.dateFromString(dateString!)
        
        //获取当前时间
        let nowDate = NSDate()
        //获得时间间隔
        let intervalTimer = nowDate.timeIntervalSince1970 - (date?.timeIntervalSince1970)!
        
        if intervalTimer < 60.0 {
            return "刚刚"
        }else if intervalTimer < 60.0*60.0 {
            return "\(Int(intervalTimer/60.0))分钟前"
        }else if intervalTimer < 60.0*60.0*24 {
            return "\(Int(intervalTimer/60.0/24))小时前"
        }else if intervalTimer < 60.0*60.0*24*2 {
            //格式化nsdate对象
            let dateFormatterYesterday = NSDateFormatter()
            //设置对象格式
            dateFormatterYesterday.dateFormat = "昨天 HH:mm"
            //获得本地化对象的具体内容
            dateFormatterYesterday.locale = NSLocale.currentLocale()
            
            return dateFormatterYesterday.stringFromDate(date!)
            
        }else if  WBHelper.isSameYear(date) {
            let dateFormatterSameYear = NSDateFormatter()
            dateFormatterSameYear.dateFormat = "MM-dd"
            dateFormatterSameYear.locale = NSLocale.currentLocale()
            
            return dateFormatterSameYear.stringFromDate(date!)
        }else{
            let dateFormatterElse = NSDateFormatter()
            dateFormatterElse.dateFormat = "yyyy-MM-dd"
            dateFormatterElse.locale = NSLocale.currentLocale()
            
            return dateFormatterElse.stringFromDate(date!)
        }
        
        
        
    }
    
    
    class func isSameYear(date: NSDate?) -> Bool{
        let forYear = NSCalendar.currentCalendar().components(NSCalendarUnit.Year, fromDate: date!)
        let nowYear = NSCalendar.currentCalendar().components(NSCalendarUnit.Year, fromDate: NSDate())
        return forYear == nowYear
        
    }
    
    
        
    
    //计算Label中某段文字大小
    class func caculateAttributeSzie(attributeStr: NSMutableAttributedString) -> CGSize {
        //通过应用属性化文本创建 CTFramesetter
        let frameSetterRef = CTFramesetterCreateWithAttributedString(attributeStr)
        let cfRange = CFRangeMake(0, 0)
        let maxSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width, CGFloat.max)
        //计算取出文本区域的大小
        let size = CTFramesetterSuggestFrameSizeWithConstraints(frameSetterRef, cfRange, nil, maxSize, nil)
        return size
    
    }
    
    //计算显示文字的的高度
    class func caculateDetailLabelHeight(attributeStr: NSMutableAttributedString, text: String) -> CGSize {
        
        //通过应用属性化文本创建 CTFramesetter
        let frameSetterRef = CTFramesetterCreateWithAttributedString(attributeStr)
        let cfRange = CFRangeMake(0, 0)
        let maxSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width, CGFloat.max)
        //计算取出文本区域的大小
        let size = CTFramesetterSuggestFrameSizeWithConstraints(frameSetterRef, cfRange, nil, maxSize, nil)
        
        let count1 = WBRegex.getEmotionWithString(text).count
        let count2 = WBRegex.matchText(text).count
        
        return CGSizeMake(size.width, size.height + CGFloat(count1 + count2) * 5)
    }
    
    

}






