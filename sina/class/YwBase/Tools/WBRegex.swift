//
//  WBRegex.swift
//  sina
//
//  Created by Mac on 17/3/13.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

var regexText: NSRegularExpression?
var regexHref: NSRegularExpression?

var urlRegex: NSRegularExpression?
var atRegex: NSRegularExpression?
var topicRegex: NSRegularExpression?
var emotionRegex: NSRegularExpression?

class WBRegex: NSObject {

    
    //解析正则表达式
    
    /*
     <a href=\"http://weibo.com/\" rel=\"nofollow\">微博 weibo.com</a>
     */
    
    // MARK: -----------text正则---------------
    class func sourceTextRegex() -> NSRegularExpression {
        
        if regexText == nil {
            do {
                let regex = "(?<=>).+(?=<)"
                try regexText = NSRegularExpression(pattern: regex, options: NSRegularExpressionOptions.AllowCommentsAndWhitespace)
                
            }catch{}
            
        }
        return  regexText!
        
    }
    
    class func sourceText(htmlString: String) -> String? {
        //定义返回值
        var text: String?
        //给regexText赋初值
        WBRegex.sourceTextRegex()
        
        let opt = NSMatchingOptions.init(rawValue: 0)
        //从起始位置到结束位置
        let range = NSMakeRange(0, htmlString.startIndex.distanceTo((htmlString.endIndex)))
        //过滤出需要的字符串
        let result = regexText?.firstMatchInString(htmlString, options: opt, range: range)

        
        //判断result是否存在并且其已经被过滤出来了
        if result != nil && result?.range.location != NSNotFound {
            //得到目标字符串的位置
            let start = htmlString.startIndex.advancedBy((result?.range.location)!)
            let end = htmlString.startIndex.advancedBy((result?.range.location)! + (result?.range.length)!)
            let textRange = Range(start..<end)
            
            //截取字符串htmlString
            text = htmlString.substringWithRange(textRange)
            
        }
        
        return text
    }
    
    // MARK: -----------超链接正则---------------
    class func sourceHrefRegex() -> NSRegularExpression {
        
        if regexHref == nil {
            do {
                let regex = "(?<=href=\").+(?=\"\\s)"
                try regexHref = NSRegularExpression(pattern: regex, options: NSRegularExpressionOptions.AllowCommentsAndWhitespace)
            }catch{}
            
        }
        return regexHref!
        
    }
    
    class func sourceHref(htmlString: String) -> String? {
        
        var text: String?
        
        WBRegex.sourceHrefRegex()
        let opt = NSMatchingOptions.init(rawValue: 0)
        let range = NSMakeRange(0, htmlString.startIndex.distanceTo(htmlString.endIndex))
        let result = regexHref?.firstMatchInString(htmlString, options: opt, range: range)
        
        if result != nil && result?.range.location != NSNotFound {
            let start = htmlString.startIndex.advancedBy((result?.range.location)!)
            let end = htmlString.startIndex.advancedBy((result?.range.location)! + (result?.range.length)!)
            let textRange = Range(start..<end)
            
            text = htmlString.substringWithRange(textRange)
            
        }
        
        return text
    }
    
    // MARK: -----------url正则---------------
    class func sourceUrlRegex() -> NSRegularExpression {
        if urlRegex == nil {
            do{
                let regex = "([hH][tT][tT][pP][sS]?:\\/\\/[^ ,'\">\\]\\)]*[^\\. ,'\">\\]\\)])"
                try urlRegex = NSRegularExpression(pattern: regex, options: NSRegularExpressionOptions.CaseInsensitive)
            }catch{}
        
        }
        return urlRegex!
    }
    
    
    // MARK: -----------at正则---------------
    class func sourceAtRegex() -> NSRegularExpression {
        if atRegex == nil {
            do{
                let regex = "@[-_a-zA-Z0-9\\u4E00-\\u9FA5]+"
                try atRegex = NSRegularExpression(pattern: regex, options: NSRegularExpressionOptions.CaseInsensitive)
            }catch{}
        }
        return atRegex!
    }
    
    // MARK: -----------topic正则---------------
    class func sourceTopicRegex() -> NSRegularExpression {
        if topicRegex == nil {
            do{
                let regex = "#[^@#]+?#"
                try topicRegex = NSRegularExpression(pattern: regex, options: NSRegularExpressionOptions.CaseInsensitive)
            }catch{}
        }
        
        return topicRegex!
    }
    
    
    // MARK: -----------emotion正则---------------
    class func sourceEmotionRegex() -> NSRegularExpression {
        if emotionRegex == nil {
            do{
                let regex = "\\[[^\\[\\]]+?\\]"
                try emotionRegex = NSRegularExpression(pattern: regex, options: NSRegularExpressionOptions.AllowCommentsAndWhitespace)
            }catch{}
        }
        return emotionRegex!
    }
    
    class func matchText(text: String) -> NSMutableArray {
        let array = NSMutableArray()
        WBRegex.sourceAtRegex()
        WBRegex.sourceUrlRegex()
        WBRegex.sourceTopicRegex()
        
        
        let opt = NSMatchingOptions.init(rawValue: 0)
        let range = NSMakeRange(0, text.startIndex.distanceTo(text.endIndex))
        
        let urls = urlRegex?.matchesInString(text, options: opt, range: range)
        let ats = atRegex?.matchesInString(text, options: opt, range: range)
        let topics = topicRegex?.matchesInString(text, options: opt, range: range)
        
        
        array.addObjectsFromArray(urls!)
        array.addObjectsFromArray(ats!)
        array.addObjectsFromArray(topics!)
        
        
        return array
    }
    
    // MARK: - 替换表情文字为表情
    class func getEmotionWithString(text: String) -> NSMutableArray {
        let results = NSMutableArray()
        
        WBRegex.sourceEmotionRegex()
        let opt = NSMatchingOptions.init(rawValue: 0)
        let range = NSMakeRange(0, text.startIndex.distanceTo(text.endIndex))
        let emoticons = emotionRegex?.matchesInString(text, options: opt, range: range)
        
        //获取表情包中的内容
        //--获取表情包的路径
        let bundlePath = NSBundle.mainBundle().pathForResource("EmoticonWeibo", ofType: "bundle")                              
        //--获取表情包中的plist文件
        let plistPath = bundlePath! + "/emoticons.plist"
        //--获取表情包中的文件字典
        let plistInfo = NSDictionary(contentsOfFile: plistPath)
        //--将表情包存入数组当中
        let packes = plistInfo!["packages"] as! NSArray
        
        //遍历获取的数组
        for i in 0..<packes.count {
            let idValue = packes[i]["id"] as! String
            
            if idValue == "com.apple.emoji" {
                continue
            }
            
            //获取具体表情包中的info文件路径
            let subPlistPath = bundlePath! + "/\(idValue)/" + "info.plist"
            //取出具体表情包的信息路径
            let info = NSDictionary(contentsOfFile: subPlistPath)
            //得到具体表情包的信息
            let infoEmoticons = info!["emoticons"] as! NSArray
            
            let nsText = text as NSString
            for j in 0..<emoticons!.count {
                let match = emoticons![j]
                
                //取出NSRange
                let subStr = nsText.substringWithRange(match.range)
                
                for z in 0..<infoEmoticons.count-1 {
                    let tmp = infoEmoticons[z]["chs"] as! String
                    if tmp == subStr {
                        var forPng = infoEmoticons[z]["png"] as! String
                        forPng.removeRange(forPng.rangeOfString(".png")!)
                        let imageName = bundlePath! + "/\(idValue)/" + forPng
                        
                        results.addObject(["range": NSValue(range: match.range),"png": imageName])
                    }
                }
            }
            
        }
        

        
        
        return results
    }

}
