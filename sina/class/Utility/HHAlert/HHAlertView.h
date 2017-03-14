//
//  MrLoadingView.h
//  MrLoadingView
//
//  Created by ChenHao on 2/11/15.
//  Copyright (c) 2015 xxTeam. All rights reserved.

/**************HHAlert的使用********************
@IBAction func success(sender: AnyObject) {
    
    HHAlertView.shared().showAlertWithStyle(HHAlertStyle.Ok, inView: self.view, title: "sucess", detail: "完全正确", cancelButton: nil, okbutton: "ok", block:({ (buttonindex) in
        if buttonindex == HHAlertButton.Ok{
            NSLog("ok按钮被点击事件")
        }else{
            NSLog("cancel按钮被点击事件")
        }
    }))
}

@IBAction func waring(sender: AnyObject) {
    HHAlertView.shared().showAlertWithStyle(HHAlertStyle.Wraning, inView: self.view, title: "warn", detail: "你输入的密码有误", cancelButton: "No", okbutton: "sure")
}

@IBAction func cancel(sender: AnyObject) {
    HHAlertView.shared().showAlertWithStyle(HHAlertStyle.Error, inView: self.view, title: "Error", detail: "错误，请重新输入", cancelButton: nil, okbutton: "我知道")
    
}

func didClickButtonAnIndex(button: HHAlertButton) {
    if button == HHAlertButton.Ok {
        NSLog("你点击了ok")
    }else{
        NSLog("你点击了cancel")
    }
}
**************HHAlert的使用********************/

#import <UIKit/UIKit.h>


/**
 *  button index
 */
typedef NS_ENUM(NSInteger, HHAlertButton){
    HHAlertButtonOk,
    HHAlertButtonCancel
};
/*
 *the style of the logo
 */
typedef NS_ENUM(NSInteger, HHAlertStyle){
    HHAlertStyleDefault,
    HHAlertStyleOk,
    HHAlertStyleError,
    HHAlertStyleWraning,
};

typedef NS_ENUM(NSInteger, HHAlertEnterStyle){
    HHAlertEnterStyleCenter,
    

};

/**
 *  the block to tell user whitch button is clicked
 *
 *  @param button button
 */
typedef void (^selectButton)(HHAlertButton buttonindex);


@protocol HHAlertViewDelegate <NSObject>


@optional
/**
 *  the delegate to tell user whitch button is clicked
 *
 *  @param button button
 */
- (void)didClickButtonAnIndex:(HHAlertButton )button;

@end


@interface HHAlertView : UIView

/**
 *  the singleton of the calss
 *
 *  @return the singleton
 */
+ (instancetype)shared;

/**
 *  dismiss the alertview
 */
- (void)hide;

/**
 *  show the alertview and use delegate to know which button is clicked
 *
 *  @param HHAlertStyle style
 *  @param view         view
 *  @param title        title
 *  @param detail       etail
 *  @param cancel       cancelButtonTitle
 *  @param ok           okButtonTitle
 */
- (void)showAlertWithStyle:(HHAlertStyle )HHAlertStyle
                    inView:(UIView *)view
                     Title:(NSString *)title
                    detail:(NSString *)detail
              cancelButton:(NSString *)cancel
                  Okbutton:(NSString *)ok;


/**
 *  show the alertview and use Block to know which button is clicked
 *
 *  @param HHAlertStyle style
 *  @param view         view
 *  @param title        title
 *  @param detail       etail
 *  @param cancel       cancelButtonTitle
 *  @param ok           okButtonTitle
 */
- (void)showAlertWithStyle:(HHAlertStyle)HHAlertStyle
                    inView:(UIView *)view
                     Title:(NSString *)title
                    detail:(NSString *)detail
              cancelButton:(NSString *)cancel
                  Okbutton:(NSString *)ok
                     block:(selectButton)block;

@property (nonatomic, weak) id<HHAlertViewDelegate> delegate;

@end
