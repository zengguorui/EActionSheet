//
//  EActionSheet.h
//  ZGRActionControllerDemo
//
//  Created by 曾国锐 on 2017/5/4.
//  Copyright © 2017年 曾国锐. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+SDAutoLayout.h"

typedef void (^ActionSheetBlock)(NSInteger tag);

@interface EActionSheet : UIView

/**
 *  返回一个 ActionSheet 对象, 实例方法
 *
 *  @param title 提示标题
 *
 *  @param titles 所有按钮的标题
 *
 *  @param buttonIndex 蓝色按钮的index
 *
 *  @param sheetBlock block
 *
 *  Tip: 如果没有蓝色按钮, blueButtonIndex 给 `-1` 即可
 */

+ (instancetype)initWithTitle:(NSString *)title
                 buttonTitles:(NSArray *)titles
              blueButtonIndex:(NSInteger)buttonIndex
             detailTitleIndex:(NSInteger)titleIndex
                   sheetBlock:(ActionSheetBlock)sheetBlock;


@end
