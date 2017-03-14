//
//  weiboTableViewCell.swift
//  sina
//
//  Created by Mac on 17/3/11.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

// MARK: - 设置weiboTableViewCell的代理
protocol weiboTableViewCellDelegate {
    func touchSourceLabel(cell: weiboTableViewCell, sourceLabel: UILabel, location: CGPoint)
}

class weiboTableViewCell: UITableViewCell {
    var delegate: weiboTableViewCellDelegate?
    var indexPath: NSIndexPath?

    @IBOutlet var displayView: DisplayView!
    @IBOutlet var headImageView: UIImageView!
    @IBOutlet var nickNameLabel: UILabel!
    @IBOutlet var commentBtn: UIButton!
    @IBOutlet var reportBtn: UIButton!
    @IBOutlet var likeBtn: UIButton!
    @IBOutlet var resourceLabel: UILabel!
    @IBOutlet var textDetailLabel: UILabel!
    
    @IBAction func commentAction(sender: AnyObject) {
        print("你点击了commentAction")
    }
    @IBAction func reportAction(sender: AnyObject) {
        print("你点击了reportAction")
    }
    @IBAction func likeAction(sender: AnyObject) {
        print("你点击了likeAction")
    }
    
    // MARK: - 头像手势点击事件
    func headerTapClick(sender: UITapGestureRecognizer) {
        print("点击了用户头像")
    }
    
    // MARK: - 头像手势点击事件
    func nickNameTapClick(sender: UITapGestureRecognizer) {
        print("点击了用户昵称")
    }
    
    // MARK: - resouceLabel点击事件
    func resouceTapClick(sender: UITapGestureRecognizer) {
        print("点击了resouceLabel")
        //代理方法的实现
        if self.delegate != nil {
            //获取手指点击的位置
            let location = sender.locationInView(sender.view)
            self.delegate?.touchSourceLabel(self, sourceLabel: self.resourceLabel, location: location)
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.headImageView.layer.cornerRadius = 20
        self.headImageView.layer.masksToBounds = true
        
        //添加头像的点击手势
        let headerTap = UITapGestureRecognizer(target: self, action: #selector(weiboTableViewCell.headerTapClick(_:)))
        headImageView.userInteractionEnabled = true
        headImageView.addGestureRecognizer(headerTap)
        
        //添加昵称的点击手势
        let nickNameTap = UITapGestureRecognizer(target: self, action: #selector(weiboTableViewCell.nickNameTapClick(_:)))
        nickNameLabel.userInteractionEnabled = true
        nickNameLabel.addGestureRecognizer(nickNameTap)
        
        //添加resouceLabel的点击手势
        let resouceTap = UITapGestureRecognizer(target: self, action: #selector(weiboTableViewCell.resouceTapClick(_:)))
        resourceLabel.userInteractionEnabled = true
        resourceLabel.addGestureRecognizer(resouceTap)
    }
    
    
    
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
