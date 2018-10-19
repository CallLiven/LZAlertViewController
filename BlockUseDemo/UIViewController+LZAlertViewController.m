//
//  UIViewController+LZAlertViewController.m
//  liangyiju-v2
//
//  Created by Liven on 2018/10/15.
//  Copyright © 2018年. All rights reserved.
//

#import "UIViewController+LZAlertViewController.h"

/* 默认展示时间 **/
static NSTimeInterval const LZAlertShowDurationDefault = 1.0f;

#pragma mark - I AlertActionModel
@interface LZAlertActionModel : NSObject
@property(nonatomic,copy ) NSString *title;
@property(nonatomic,assign ) UIAlertActionStyle  style;
@end

@implementation LZAlertActionModel
- (instancetype)init {
    if (self = [super init]) {
        self.title = @"";
        self.style = UIAlertViewStyleDefault;
    }
    return self;
}
@end

#pragma mark - II LZAlertController
/* alertActions 配置 **/
typedef void (^LZAlertAcitionsConfig)(LZAlertActionBlock actionBlock);

@interface LZAlertController()
/* alertActionModel数组 **/
@property(nonatomic,strong) NSMutableArray <LZAlertActionModel *> *alertActionArray;
/* 是否执行动画 **/
@property(nonatomic,assign) BOOL  setAlertAnimated;

/**
 action配置
 */
- (LZAlertAcitionsConfig)alertActionsConfig;

@end

@implementation LZAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (self.alertDidDismiss) {
        self.alertDidDismiss();
    }
}

#pragma mark - private
- (NSMutableArray<LZAlertActionModel *> *)alertActionArray {
    if (_alertActionArray == nil) {
        _alertActionArray = [NSMutableArray array];
    }
    return _alertActionArray;
}


- (LZAlertAcitionsConfig)alertActionsConfig {
    return ^(LZAlertActionBlock actionBlock){
        if (self.alertActionArray.count>0) {
            //创建alertAction
            __weak typeof(self)weakSelf = self;
            [self.alertActionArray enumerateObjectsUsingBlock:^(LZAlertActionModel * actionModel, NSUInteger idx, BOOL * _Nonnull stop) {
                UIAlertAction *alertAction = [UIAlertAction actionWithTitle:actionModel.title style:actionModel.style handler:^(UIAlertAction * _Nonnull action) {
                    __strong typeof(weakSelf)strongSelf = weakSelf;
                    if (actionBlock) {
                        actionBlock(idx,action,strongSelf);
                    }
                }];
                [self addAction:alertAction];
            }];
        
        }
        else
        {
            NSTimeInterval duration = self.toastStyleDuration > 0 ? self.toastStyleDuration : LZAlertShowDurationDefault;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:!(self.setAlertAnimated) completion:NULL];
            });
        }

    };
}

#pragma mark - Public
- (instancetype)initAlertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle {
    if (!(title.length>0) && (message.length>0) && preferredStyle == UIAlertControllerStyleAlert) {
        title = @"";
    }
    self = [[self class] alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    if (!self) return nil;
    
    self.setAlertAnimated = NO;
    return self;
}

- (void)alertAnimateDisabled {
    self.setAlertAnimated = YES;
}

- (LZAlertActionTitle)addActionDefaultTitle {
    return ^(NSString *title){
        LZAlertActionModel *actionModel = [[LZAlertActionModel alloc]init];
        actionModel.title = title;
        actionModel.style = UIAlertActionStyleDefault;
        [self.alertActionArray addObject:actionModel];
        return self;
    };
}


- (LZAlertActionTitle)addActionCancleTitle {
    return ^(NSString *title){
        LZAlertActionModel *actionModel = [[LZAlertActionModel alloc]init];
        actionModel.title = title;
        actionModel.style = UIAlertActionStyleCancel;
        [self.alertActionArray addObject:actionModel];
        return self;
    };
}

- (LZAlertActionTitle)addActionDestructiveTitle {
    return ^(NSString *title){
        LZAlertActionModel *actionModel = [[LZAlertActionModel alloc]init];
        actionModel.title = title;
        actionModel.style = UIAlertActionStyleDestructive;
        [self.alertActionArray addObject:actionModel];
        return self;
    };
}


@end


#pragma mark - III 类别
@implementation UIViewController (LZAlertViewController)

- (void)lz_showAlertWithPreferredStyle:(UIAlertControllerStyle)preferredStyle title:(NSString *)title message:(NSString *)message appearanceProcess:(LZAlertAppearanceProcess)appearanceProcess actionsBlock:(LZAlertActionBlock)actionBlock {
    if (appearanceProcess) {
        LZAlertController *alertMaker = [[LZAlertController alloc]initAlertControllerWithTitle:title message:message preferredStyle:preferredStyle];
        //防止nil
        if (alertMaker == nil) {
            return;
        }
        //加工链：添加alertAction
        appearanceProcess(alertMaker);
        //配置响应
        alertMaker.alertActionsConfig(actionBlock);
        
        if (alertMaker.alertDidShown) {
            [self presentViewController:alertMaker animated:!alertMaker.setAlertAnimated completion:^{
                alertMaker.alertDidShown();
            }];
        }
        else{
            [self presentViewController:alertMaker animated:!alertMaker.setAlertAnimated completion:NULL];
        }
    }
}


- (void)lz_showAlertWithTitle:(NSString *)title message:(NSString *)message appearanceProcess:(LZAlertAppearanceProcess)appearanceProcesss actionsBlock:(LZAlertActionBlock)actionBlock {
    [self lz_showAlertWithPreferredStyle:UIAlertControllerStyleAlert title:title message:message appearanceProcess:appearanceProcesss actionsBlock:actionBlock];
}


- (void)lz_showActionSheetWithTitle:(NSString *)title message:(NSString *)message appearanceProcess:(LZAlertAppearanceProcess)appearanceProcess actionsBlock:(LZAlertActionBlock)actionBlock {
    [self lz_showAlertWithPreferredStyle:UIAlertControllerStyleActionSheet title:title message:message appearanceProcess:appearanceProcess actionsBlock:actionBlock];
}

@end
