//
//  ViewController.swift
//  sina
//
//  Created by Mac on 17/3/11.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class ViewController: YwBaseController ,UITableViewDelegate, UITableViewDataSource, weiboTableViewCellDelegate{

    @IBOutlet var mytableview: UITableView!
    //MJRefresh 顶部刷新
    var header = MJRefreshNormalHeader()
    var dataSource = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableViewInit()
        HeadRefresh()
        
        
        
    }
    
    // MARK: - 获取网络数据
    func netRequest() {
        let path = NSBundle.mainBundle().pathForResource("weibo", ofType: "json")
        let data = NSData(contentsOfFile: path!)
        let jsonData = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
        
        let array = jsonData?.objectForKey("statuses") as! NSArray
        dataSource.addObjectsFromArray(array as [AnyObject])

        
    }
    
    // MARK: - 顶部刷新
    func HeadRefresh() {
        // 下拉刷新
        header.setRefreshingTarget(self, refreshingAction: #selector(ViewController.forHeaderRefresh))
        mytableview.mj_header = header
        header.beginRefreshing()
    }
    func forHeaderRefresh() {
        netRequest()
        mytableview.reloadData()
        mytableview.mj_header.endRefreshing()
    }
    
    // MARK: - tableViewDelegate,tableViewDataSource
    func tableViewInit() {
        mytableview.delegate = self
        mytableview.dataSource = self
        
        let nib = UINib(nibName: weiboTableViewCellString, bundle: NSBundle.mainBundle())
        mytableview.registerNib(nib, forCellReuseIdentifier: weiboCellString)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height: CGFloat = 56.0
        
        let element = dataSource[indexPath.row] as! NSDictionary
        
        let text = element["text"] as! String
        let array = WBRegex.matchText(text)
        //实现富文本
        let detailAttribute = NSMutableAttributedString(string: text)
        
        for i in 0..<array.count {
            //取出检测正则表达式结果
            let match = array[i] as! NSTextCheckingResult
            detailAttribute.addAttribute(NSForegroundColorAttributeName, value: UIColor.blueColor(), range: match.range)
        }
        
        let emotionInfo = WBRegex.getEmotionWithString(text)
        for i in 0..<emotionInfo.count {
            let png = emotionInfo[emotionInfo.count-1-i]["png"] as! String
            let range = emotionInfo[emotionInfo.count-1-i]["range"] as! NSRange
            
            let textAttachment = NSTextAttachment()
            textAttachment.image = UIImage(named: png)
            textAttachment.bounds = CGRectMake(0, -2, 20, 20)
            let imageAttribute = NSAttributedString(attachment: textAttachment)
            detailAttribute.replaceCharactersInRange(range, withAttributedString: imageAttribute)
        }
        detailAttribute.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(17.0), range: NSMakeRange(0, detailAttribute.string.characters.count))
        
        height += WBHelper.caculateDetailLabelHeight(detailAttribute, text: text).height
        
        let pics = element["pic_urls"] as! NSArray
        
        if pics.count == 0 {
            height += CGFloat(46+8)
        }else if pics.count == 1 {
            height += CGFloat(200) + CGFloat(46)
        }else{
            let perHeight = (self.view.frame.size.width - CGFloat(16) - CGFloat(2*2))/CGFloat(3)
            if pics.count >= 2 && pics.count <= 3 {
                height += CGFloat(46) + perHeight
            }else if pics.count > 3 && pics.count <= 6 {
                height += CGFloat(46) + perHeight*2 + CGFloat(2)
            }else{
                height += CGFloat(46) + perHeight*3 + CGFloat(2)*2
            }
            
        }
        
        return height
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = mytableview.dequeueReusableCellWithIdentifier(weiboCellString, forIndexPath: indexPath) as? weiboTableViewCell
        cell?.delegate = self
        cell?.indexPath = indexPath
        //取出json数据并显示在UI上
        let element = dataSource[indexPath.row] as! NSDictionary
        let userDic = element["user"] as! NSDictionary
        let nickName = userDic["name"] as! String
        let avatar_hd = userDic["avatar_hd"] as! String
        
        
        let sourceText = NSMutableAttributedString()
        let created_at = WBHelper.timeLineWithStringDate(element["created_at"] as? String)
        if let _ = created_at {
            let dic = [NSFontAttributeName: UIFont.systemFontOfSize(12), NSForegroundColorAttributeName: UIColor.orangeColor()]
            let timeText = NSMutableAttributedString(string: created_at!, attributes: dic)
            sourceText.appendAttributedString(timeText)
            
        }
        
        let dic = [NSFontAttributeName: UIFont.systemFontOfSize(12), NSForegroundColorAttributeName: UIColor.lightGrayColor()]
        let timeText = NSMutableAttributedString(string: " 来自", attributes: dic)
        sourceText.appendAttributedString(timeText)

        let source = WBRegex.sourceText(element["source"] as! String)
        if let _ = source {
            let dic = [NSFontAttributeName: UIFont.systemFontOfSize(12), NSForegroundColorAttributeName: UIColor.blueColor()]
            let timeText = NSMutableAttributedString(string: source!, attributes: dic)
            sourceText.appendAttributedString(timeText)
        }
        
        let text = element["text"] as! String
        let array = WBRegex.matchText(text)
        //实现富文本
        let detailAttribute = NSMutableAttributedString(string: text)
        
        for i in 0..<array.count {
            //取出检测正则表达式结果
            let match = array[i] as! NSTextCheckingResult
            detailAttribute.addAttribute(NSForegroundColorAttributeName, value: UIColor.blueColor(), range: match.range)
        }
        
        let emotionInfo = WBRegex.getEmotionWithString(text)
        for i in 0..<emotionInfo.count {
            let png = emotionInfo[emotionInfo.count-1-i]["png"] as! String
            let range = emotionInfo[emotionInfo.count-1-i]["range"] as! NSRange
            
            let textAttachment = NSTextAttachment()
            textAttachment.image = UIImage(named: png)
            textAttachment.bounds = CGRectMake(0, -2, 20, 20)
            let imageAttribute = NSAttributedString(attachment: textAttachment)
            detailAttribute.replaceCharactersInRange(range, withAttributedString: imageAttribute)
        }
        detailAttribute.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(17.0), range: NSMakeRange(0, detailAttribute.string.characters.count))
        
        cell?.textDetailLabel.attributedText = detailAttribute
        cell?.headImageView.sd_setImageWithURL(NSURL(string: avatar_hd))
        cell?.nickNameLabel.text = nickName
        cell?.resourceLabel.attributedText = sourceText
        
        //设置tableview的点击风格
        cell!.selectionStyle = UITableViewCellSelectionStyle.None
        
        //设置cell中的图片链接
        let pics = element["pic_urls"] as! NSArray
        var urls = [String]()
        for i in 0..<pics.count {
            let str = pics[i]["thumbnail_pic"] as! String
            urls.append(str)
        }
        cell?.displayView.displayImageUrls = urls
        return cell!
    }
    
    func touchSourceLabel(cell: weiboTableViewCell, sourceLabel: UILabel, location: CGPoint) {
        //取出json数据
        let element = dataSource[cell.indexPath!.row] as! NSDictionary
        let source = WBRegex.sourceText(element["source"] as! String)
        if let _ = source {
            let dic = [NSFontAttributeName: UIFont.systemFontOfSize(12), NSForegroundColorAttributeName: UIColor.blueColor()]
            let sourceText = NSMutableAttributedString(string: source!, attributes: dic)
            //计算并取出指定source的尺寸，用普通的方法不准确
            let sourceSize = WBHelper.caculateAttributeSzie(sourceText)
            //取出整个label的尺寸
            let totalSize = WBHelper.caculateAttributeSzie(NSMutableAttributedString(attributedString: sourceLabel.attributedText!))
            //判断时候点击了需要取出尺寸处的label
            if totalSize.width - sourceSize.width < location.x {
                let href = WBRegex.sourceHref(element["source"] as! String)
//                print(href!)
            }
            
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("你点击了tableView的第\(indexPath.row)行")
    }


  


}

