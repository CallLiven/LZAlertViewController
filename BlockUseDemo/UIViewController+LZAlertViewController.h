//
//  UIViewController+LZAlertViewController.h
//  liangyiju-v2
//
//  Created by Liven on 2018/10/15.
//  Copyright © 2018年. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LZAlertController;

#pragma mark - I LZAlertController构造
/**
 alertAction配置链

 @param title 标题
 @return LZAlertController对象
 */
typedef LZAlertController *_Nonnull (^LZAlertActionTitle)(NSString * _Nonnull title);

/**
 alertz按钮执行回调

 @param buttonIndex 按钮index
 @param action UIAlertAction对象
 @param alertSelf 本类对象
 */
typedef void (^LZAlertActionBlock)(NSInteger buttonIndex, UIAlertAction * _Nonnull action, LZAlertController * _Nonnull alertSelf);

@interface LZAlertController : UIAlertController
/* alert弹出后，可配置的回调 **/
@property (nullable, nonatomic, copy) void (^alertDidShown)(void);
/* alert关闭后, 可配置的回调 **/
@property (nullable, nonatomic, copy) void (^alertDidDismiss)(void);
/* 设置toast模式展示时间：如果alert未添加任何按钮，将会以toast样式展示，默认一秒 **/
@property(nonatomic,assign ) NSTimeInterval  toastStyleDuration;

/**
 禁用alert弹出动画，默认执行系统的默认弹出动画
 */
- (void)alertAnimateDisabled;

/**
 链式构造alert视图按钮，添加一个alertAction按钮，默认样式，参数为标题

 @return LZAlertController 对象
 */
- (LZAlertActionTitle _Nonnull )addActionDefaultTitle;

/**
 链式构造alert视图按钮，添加一个alertAction按钮，取消样式，参数为标题

 @return LZAlertController 对象
 */
- (LZAlertActionTitle _Nonnull )addActionCancleTitle;

/**
 链式构造alert视图按钮，添加一个alertAction按钮，警告样式，参数为标题

 @return LZAlertController 对象
 */
- (LZAlertActionTitle _Nonnull )addActionDestructiveTitle;

@end



#pragma mark - II 类别
/* alert构造块 **/
typedef void (^LZAlertAppearanceProcess)(LZAlertController * _Nonnull alertMaker);

@interface UIViewController (LZAlertViewController)

/**
 show-alert(iOS_8.0)

 @param title title
 @param message message
 @param appearanceProcesss alert配置过程
 @param actionBlock alert点击响应回调
 */
- (void)lz_showAlertWithTitle:(nullable NSString *)title
                      message:(nullable NSString *)message
            appearanceProcess:(LZAlertAppearanceProcess _Nonnull )appearanceProcesss
                 actionsBlock:(nullable LZAlertActionBlock)actionBlock;

/**
 show-actionSheet(iOS_8.0)

 @param title title
 @param message message
 @param appearanceProcess actionSheet配置过程
 @param actionBlock actionSheet点击响应回调
 */
- (void)lz_showActionSheetWithTitle:(nullable NSString *)title
                            message:(nullable NSString *)message
                  appearanceProcess:(LZAlertAppearanceProcess _Nonnull )appearanceProcess
                       actionsBlock:(nullable LZAlertActionBlock)actionBlock;

@end

