//
//  ViewController.m
//  BlockUseDemo
//
//  Created by Liven on 2018/10/17.
//  Copyright © 2018年 Liven. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+LZAlertViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NSArray *dataArray;
@property(nonatomic,strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark - private
- (void)testAlertView {
    [self lz_showAlertWithTitle:@"AlertViewTest" message:@"" appearanceProcess:^(LZAlertController * _Nonnull alertMaker) {
        alertMaker.addActionDefaultTitle(@"默认样式");
        alertMaker.addActionDestructiveTitle(@"警告样式");
        alertMaker.addActionCancleTitle(@"取消样式");
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, LZAlertController * _Nonnull alertSelf) {
        NSLog(@"点击了第%ld个",buttonIndex);
    }];
}

- (void)testSheetView {
    [self lz_showActionSheetWithTitle:@"SheetViewTest" message:@"" appearanceProcess:^(LZAlertController * _Nonnull alertMaker) {
        alertMaker.addActionDefaultTitle(@"默认样式");
        alertMaker.addActionDestructiveTitle(@"警告样式");
        alertMaker.addActionCancleTitle(@"取消样式");
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, LZAlertController * _Nonnull alertSelf) {
        switch (action.style) {
            case UIAlertActionStyleDefault:
                NSLog(@"默认");
                break;
            case UIAlertActionStyleCancel:
                NSLog(@"取消");
                break;
            case UIAlertActionStyleDestructive:
                NSLog(@"警告");
                break;
                
            default:
                break;
        }
    }];
}

#pragma mark - tableView delegate && datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self testAlertView];
    }
    if (indexPath.row == 1) {
        [self testSheetView];
    }
}


#pragma mark - setter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    }
    return _tableView;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@"AlertViewTest",@"SheetViewTest"];
    }
    return _dataArray;
}






@end
