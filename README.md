# LZAlertViewController

//调用方法

```
[self lz_showAlertWithTitle:@"AlertViewTest" message:@"" appearanceProcess:^(LZAlertController * _Nonnull alertMaker) {
        alertMaker.addActionDefaultTitle(@"默认样式");
        alertMaker.addActionDestructiveTitle(@"警告样式");
        alertMaker.addActionCancleTitle(@"取消样式");
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, LZAlertController * _Nonnull alertSelf) {
        NSLog(@"点击了第%ld个",buttonIndex);
    }];
    
```

```
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
    ```
