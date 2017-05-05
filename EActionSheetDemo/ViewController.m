//
//  ViewController.m
//  EActionSheetDemo
//
//  Created by 曾国锐 on 2017/5/4.
//  Copyright © 2017年 曾国锐. All rights reserved.
//

#import "ViewController.h"
#import "EActionSheet.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)buttonClick:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
        {
            [EActionSheet initWithTitle:nil buttonTitles:@[@"移除设备", @"非本人操作"] blueButtonIndex:-1 detailTitleIndex:1 sheetBlock:^(NSInteger tag) {
                NSLog(@"%ld", (long)tag);
            }];
        }
            break;
        case 1:
        {
            [EActionSheet initWithTitle:nil buttonTitles:@[@"移除设备", @"非本人操作"] blueButtonIndex:0 detailTitleIndex:0 sheetBlock:^(NSInteger tag) {
                NSLog(@"%ld", (long)tag);
            }];
        }
            break;
        case 2:
        {
            [EActionSheet initWithTitle:@"提示" buttonTitles:@[@"移除设备", @"非本人操作"] blueButtonIndex:1 detailTitleIndex:-1 sheetBlock:^(NSInteger tag) {
                NSLog(@"%ld", (long)tag);
            }];
        }
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
