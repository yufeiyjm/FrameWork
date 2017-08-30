//
//  SelectButtonView.m
//  MyProject
//
//  Created by jiaming yan on 2017/8/23.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "SelectButtonView.h"

@implementation SelectButtonView
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = kClearColor;
    self.backView = [[UIButton alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.backView.backgroundColor = kBlackColor;
    self.backView.alpha = 0;
    [self.backView addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.backView];
    
    self.contentView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.contentView.backgroundColor = kWhiteColor;
    [self addSubview:self.contentView];
    self.contentView.frame = CGRectMake(0, 0, self.frame.size.width, 0);
    self.contentView.clipsToBounds = YES;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kClearColor;
        self.backView = [[UIButton alloc]initWithFrame:frame];
        
        self.backView.backgroundColor = kBlackColor;
        self.backView.alpha = 0;
        [self addSubview:self.backView];
        [self.backView addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        self.contentView = [[UIView alloc]initWithFrame:frame];
        self.contentView.backgroundColor = kWhiteColor;
        [self addSubview:self.contentView];
        self.contentView.frame = CGRectMake(0, 0, self.frame.size.width, 0);
        self.contentView.clipsToBounds = YES;
        
    }
    return self;
}
-(void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(26, 13, 100, 15)];
    lab.font = [UIFont fontWithName:@"PingFang SC" size:12];
    lab.text = titleStr;
    lab.textColor = UIColorFromRGB(0xbecbd0);
    [self.contentView addSubview:lab];
    
}
-(void)setButtonArr:(NSMutableArray *)buttonArr{
    
    _buttonArr = buttonArr;
    for (UIView *aView in [self.contentView subviews]) {
        [aView removeFromSuperview];
    }
    self.contentView.frame = CGRectMake(0, 0, self.frame.size.width, 0) ;
    
    
    CGFloat width = (self.frame.size.width - 52 - 38)/3;
    for (NSInteger i = 0; i < _buttonArr.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size:14];
        [button setTitle:buttonArr[i] forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(0x6c7374) forState:UIControlStateNormal];
        [button setFrame:CGRectMake(26 + (i%3) * (width + 19), 40 + (i/3)*45, width, 30)];
        [button setBackgroundColor:kWhiteColor];
        button.clipsToBounds = YES;
        button.layer.borderWidth = 0.5;
        button.layer.borderColor = UIColorFromRGB(0x1AA9BA).CGColor;
        button.layer.cornerRadius = 15;
        button.tag = i + 1000;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        
    }
    UIButton *surebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    surebutton.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size:15];
    [surebutton setTitle:@"确定" forState:UIControlStateNormal];
    [surebutton setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [surebutton setFrame:CGRectMake((kScreenWidth - 155)/2, 40 + ((_buttonArr.count%3==0)?(_buttonArr.count/3): (_buttonArr.count/3+ 1))*45 + 77 - 60, 155, 36)];
    [surebutton setBackgroundColor:UIColorFromRGB(0x1AA9BA)];
    surebutton.clipsToBounds = YES;
    surebutton.layer.cornerRadius = 18;
    surebutton.tag = -1;
    [surebutton addTarget:self action:@selector(surebuttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:surebutton];
    
    
}
-(void)buttonClick:(UIButton *)sender{
    for (UIView *aView in [self.contentView subviews]) {
        if ([aView isKindOfClass:[UILabel class]]) {
            continue;
        }
        if (aView == sender) {
            [aView setBackgroundColor:UIColorFromRGB(0x1AA9BA)];
            [(UIButton *)aView setTitleColor:kWhiteColor forState:UIControlStateNormal];
        }else{
            if (aView.tag == -1) {
                continue ;
            }
            [(UIButton *)aView setTitleColor:UIColorFromRGB(0x6c7374) forState:UIControlStateNormal];
            [aView setBackgroundColor:kWhiteColor];
        }
    }
    self.selectIndex = sender.tag;
}

-(void)surebuttonClick:(UIButton *)sender{
    if (self.selectSure && self.selectIndex > 0) {
        self.selectSure((self.selectIndex - 1000));
    }
}
-(void)changeView{
    NSString *strK = [NSString stringWithFormat:@"%f",self.backView.alpha];
    if ([strK isEqualToString:@"0.600000"]) {
        [self close];
    }else{
        [self show];
    }
}
-(void)show{
    [UIView animateWithDuration:0.25 animations:^{
        self.contentView.frame = CGRectMake(0, 0, self.frame.size.width, 40 + ((_buttonArr.count%3==0)?(_buttonArr.count/3): (_buttonArr.count/3+ 1))*45 + 77);
        self.backView.alpha = 0.6;
        self.alpha = 1;
    }];
}
-(void)close{
    SaintiLog(@"关闭");
    [UIView animateWithDuration:0.25 animations:^{
        self.contentView.frame = CGRectMake(0, 0, self.frame.size.width, 0);
        self.backView.alpha = 0;
        self.alpha = 0;
    }];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
