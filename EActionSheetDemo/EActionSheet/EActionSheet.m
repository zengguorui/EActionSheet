//
//  EActionSheet.m
//  ZGRActionControllerDemo
//
//  Created by 曾国锐 on 2017/5/4.
//  Copyright © 2017年 曾国锐. All rights reserved.
//

// 按钮高度
#define BUTTON_H 44.0f
// 屏幕尺寸
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
// 颜色
#define LCColor(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]

#import "EActionSheet.h"

@interface EActionSheet () {
    
    /** 所有按钮 */
    NSArray *_buttonTitles;
    
    /** 暗黑色的view */
    UIView *_darkView;
    
    /** 所有按钮的底部view */
    UIView *_bottomView;
    
    /** 代理 */
    ActionSheetBlock _sheetBlock;
}

@property (nonatomic, strong) UIWindow *backWindow;


@end

@implementation EActionSheet

+ (instancetype)initWithTitle:(NSString *)title
                 buttonTitles:(NSArray *)titles
              blueButtonIndex:(NSInteger)buttonIndex
             detailTitleIndex:(NSInteger)titleIndex
                   sheetBlock:(ActionSheetBlock)sheetBlock{

    return [[self alloc] initWithTitle:title buttonTitles:titles blueButtonIndex:buttonIndex detailTitleIndex:titleIndex sheetBlock:sheetBlock];
}

- (instancetype)initWithTitle:(NSString *)title
                 buttonTitles:(NSArray *)titles
              blueButtonIndex:(NSInteger)buttonIndex
             detailTitleIndex:(NSInteger)titleIndex
                   sheetBlock:(ActionSheetBlock)sheetBlock{
    
    if (self = [super init]) {
        
        _sheetBlock = sheetBlock;
        
        // 暗黑色的view
        UIView *darkView = [[UIView alloc] init];
        [darkView setAlpha:0];
        [darkView setUserInteractionEnabled:NO];
        [darkView setFrame:(CGRect){0, 0, SCREEN_SIZE}];
        [darkView setBackgroundColor:LCColor(46, 49, 50)];
        [self addSubview:darkView];
        _darkView = darkView;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
        [darkView addGestureRecognizer:tap];
        
        // 所有按钮的底部view
        UIView *bottomView = [[UIView alloc] init];
        [bottomView setBackgroundColor:LCColor(233, 233, 238)];
        [self addSubview:bottomView];
        _bottomView = bottomView;
        
        bottomView.sd_layout
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .bottomSpaceToView(self, 0);
        
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"EActionSheet" ofType:@"bundle"];
        
        NSString *linePath = [bundlePath stringByAppendingPathComponent:@"cellLine@2x.png"];
        UIImage *lineImage = [UIImage imageWithContentsOfFile:linePath];

        UIImageView *tempLine = [[UIImageView alloc] init];
        
        if (title) {
            
            // 标题
            UILabel *label = [[UILabel alloc] init];
            [label setText:title];
            [label setTextColor:LCColor(111, 111, 111)];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setFont:[UIFont systemFontOfSize:13.0f]];
            [label setBackgroundColor:[UIColor whiteColor]];
            [bottomView addSubview:label];
            
            label.sd_layout
            .leftSpaceToView(bottomView, 0)
            .rightSpaceToView(bottomView, 0)
            .topSpaceToView(bottomView, 0)
            .heightIs(BUTTON_H);
            
            //线条
            UIImageView *line = [[UIImageView alloc] init];
            [line setImage:lineImage];
            [line setContentMode:UIViewContentModeCenter];
            
            [bottomView addSubview:line];
            
            line.sd_layout
            .leftSpaceToView(bottomView, 0)
            .rightSpaceToView(bottomView, 0)
            .topSpaceToView(label, 0)
            .heightIs(1.0f);
            
            tempLine = line;
        }
        
        if (titles.count) {
            
            _buttonTitles = titles;
            
            
            for (int i = 0; i < titles.count; i++) {
                
                // 所有按钮
                UIButton *btn = [[UIButton alloc] init];
                [btn setTag:i];
                [btn setBackgroundColor:[UIColor whiteColor]];
                [btn setTitle:titles[i] forState:UIControlStateNormal];
                [[btn titleLabel] setFont:[UIFont systemFontOfSize:15.0f]];
                
                UIColor *titleColor = nil;
                [btn setTitleColor:titleColor forState:UIControlStateNormal];
                
                NSString *bgPath = [bundlePath stringByAppendingPathComponent:@"bgImage_HL@2x.png"];
                UIImage *bgImage = [UIImage imageWithContentsOfFile:bgPath];
                
                [btn setBackgroundImage:bgImage forState:UIControlStateHighlighted];
                [btn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
                
                [bottomView addSubview:btn];
                
                CGFloat tempHeight = BUTTON_H;
                
                if (i == buttonIndex) {
                    
                    titleColor = LCColor(0, 134, 229);
                    
                } else {
                    
                    titleColor = LCColor(51, 51, 51) ;
                }
                [btn setTitleColor:titleColor forState:UIControlStateNormal];
                
                if (i == titleIndex) {
                    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, SCREEN_SIZE.width, 15)];
                    detailLabel.text = @"移除设备后，当前账户在该设备上将要重新登录";
                    detailLabel.textAlignment = NSTextAlignmentCenter;
                    detailLabel.textColor = [UIColor grayColor];
                    detailLabel.font = [UIFont systemFontOfSize:11];
                    [btn addSubview:detailLabel];
                    
                    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 15, 0);
                    tempHeight += 19;
                }
                
                btn.sd_layout
                .leftSpaceToView(bottomView, 0)
                .rightSpaceToView(bottomView, 0)
                .topSpaceToView(tempLine, 0)
                .heightIs(tempHeight);
                
                //线条
                UIImageView *line = [[UIImageView alloc] init];
                [line setImage:lineImage];
                [line setContentMode:UIViewContentModeCenter];
                
                [bottomView addSubview:line];
                
                line.sd_layout
                .leftSpaceToView(bottomView, 0)
                .rightSpaceToView(bottomView, 0)
                .topSpaceToView(btn, 0)
                .heightIs(1.0f);
                
                tempLine = line;
            }

        }
        
        // 取消按钮
        UIButton *cancelBtn = [[UIButton alloc] init];
        [cancelBtn setTag:titles.count];
        [cancelBtn setBackgroundColor:[UIColor whiteColor]];
        [cancelBtn setTitle:@"关闭" forState:UIControlStateNormal];
        [[cancelBtn titleLabel] setFont:[UIFont systemFontOfSize:16.0f]];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBtn setBackgroundImage:[UIImage imageNamed:@"bgImage_HL"] forState:UIControlStateHighlighted];
        [cancelBtn addTarget:self action:@selector(didClickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:cancelBtn];
        
        cancelBtn.sd_layout
        .leftSpaceToView(bottomView, 0)
        .rightSpaceToView(bottomView, 0)
        .topSpaceToView(tempLine, 10)
        .heightIs(BUTTON_H);
        
        [bottomView setupAutoHeightWithBottomView:cancelBtn bottomMargin:0];
        
        [self setFrame:(CGRect){0, 0, SCREEN_SIZE}];
        [self.backWindow addSubview:self];
        
        [self show];
    }
    
    return self;
}

- (UIWindow *)backWindow {
    
    if (_backWindow == nil) {
        
        _backWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backWindow.windowLevel       = UIWindowLevelStatusBar;
        _backWindow.backgroundColor   = [UIColor clearColor];
        _backWindow.hidden = NO;
    }
    
    return _backWindow;
}


- (void)didClickBtn:(UIButton *)btn {
    
    [self dismiss:nil];
    
    if (_sheetBlock) {
        _sheetBlock(btn.tag);
    }
}

- (void)dismiss:(UITapGestureRecognizer *)tap {
    
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         [_darkView setAlpha:0];
                         [_darkView setUserInteractionEnabled:NO];
                         
                         CGRect frame = _bottomView.frame;
                         frame.origin.y += frame.size.height;
                         [_bottomView setFrame:frame];
                         
                     }
                     completion:^(BOOL finished) {
                         
                         _backWindow.hidden = YES;
                         
                         [self removeFromSuperview];
                     }];
}

- (void)didClickCancelBtn {
    
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         [_darkView setAlpha:0];
                         [_darkView setUserInteractionEnabled:NO];
                         
                         CGRect frame = _bottomView.frame;
                         frame.origin.y += frame.size.height;
                         [_bottomView setFrame:frame];
                         
                     }
                     completion:^(BOOL finished) {
                         
                         _backWindow.hidden = YES;
                         
                         [self removeFromSuperview];
                         
                         if (_sheetBlock) {
                             _sheetBlock(_buttonTitles.count);
                         }
                     }];
}

- (void)show {
    
    _backWindow.hidden = NO;
    
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         [_darkView setAlpha:0.4f];
                         [_darkView setUserInteractionEnabled:YES];
                         
                         CGRect frame = _bottomView.frame;
                         frame.origin.y -= frame.size.height;
                         [_bottomView setFrame:frame];
                         
                     }
                     completion:nil];
}

@end
