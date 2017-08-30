//
//  SelectButtonView.h
//  MyProject
//
//  Created by jiaming yan on 2017/8/23.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectButtonView : UIView
@property (nonatomic,copy) NSString *titleStr;
@property (nonatomic,strong) NSArray *buttonArr;
@property (nonatomic,strong) UIButton *backView;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,assign) NSInteger selectIndex;
@property (nonatomic,strong) void(^selectSure)(NSInteger selectIndex);
-(void)changeView;
-(void)show;
-(void)close;
@end
