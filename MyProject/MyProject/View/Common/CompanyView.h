//
//  CompanyView.h
//  MyProject
//
//  Created by jiaming yan on 2017/8/24.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompanyView : UIView
@property (nonatomic,strong) NSArray *titleStr;
@property (nonatomic,strong) NSArray *buttonArr;
@property (nonatomic,strong) UIButton *backView;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) NSMutableArray *selectIndexArr;
@property (nonatomic,strong) void(^selectSure)(NSMutableArray  *selectIndexArr);
-(void)changeView;
-(void)show;
-(void)close;
@end
