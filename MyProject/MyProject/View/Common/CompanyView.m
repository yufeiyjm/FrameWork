//
//  CompanyView.m
//  MyProject
//
//  Created by jiaming yan on 2017/8/24.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "CompanyView.h"

@implementation CompanyView
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
//-(void)setTitleStr:(NSArray *)titleStr{
//    _titleStr = titleStr;
//    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(26, 13, 100, 15)];
//    lab.font = [UIFont fontWithName:@"PingFang SC" size:12];
//    lab.text = titleStr;
//    lab.textColor = UIColorFromRGB(0xbecbd0);
//    [self.contentView addSubview:lab];
//
//}
-(void)setButtonArr:(NSMutableArray *)buttonArr{
    self.selectIndexArr = [[NSMutableArray alloc]init];
    _buttonArr = buttonArr;
    self.contentView.frame = CGRectMake(0, 0, self.frame.size.width, 0) ;
    for (UIView *aView in [self.contentView subviews]) {
        [aView removeFromSuperview];
    }
    CGFloat width = (self.frame.size.width - 52 - 38)/3;
    CGFloat beginY = 0;
    for (NSInteger k = 0; k < buttonArr.count; k++) {
        [self.selectIndexArr addObject:@"-1"];
        NSArray *itemArr = buttonArr[k];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(26, beginY + 13, 100, 15)];
        lab.font = [UIFont fontWithName:@"PingFang SC" size:12];
        lab.text = _titleStr[k];
        lab.textColor = UIColorFromRGB(0xbecbd0);
        [self.contentView addSubview:lab];

        for (NSInteger i = 0; i < itemArr.count; i ++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size:14];
            [button setTitle:itemArr[i] forState:UIControlStateNormal];
            [button setTitleColor:UIColorFromRGB(0x6c7374) forState:UIControlStateNormal];
            [button setFrame:CGRectMake(26 + (i%3) * (width + 19), 40 + (i/3)*45 + beginY, width, 30)];
            [button setBackgroundColor:kWhiteColor];
            button.clipsToBounds = YES;
            button.layer.borderWidth = 0.5;
            button.layer.borderColor = UIColorFromRGB(0x1AA9BA).CGColor;
            button.layer.cornerRadius = 15;
            button.tag = i + 1000*(k + 1);
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:button];
            
        }
        beginY = 40 + ((itemArr.count%3==0)?(itemArr.count/3): (itemArr.count/3+ 1))*45;
        beginY = beginY - 15;
    }
    
    
    
    
    
    CGFloat height = 0;
    for (NSInteger i = 0 ; i < _buttonArr.count; i ++) {
        NSArray *itemArr = _buttonArr[i];
        height = height + 40 + ((itemArr.count%3==0)?(itemArr.count/3): (itemArr.count/3+ 1))*45;
        if (i > 0) {
            height = height - 15;
        }
    }
    
    UIButton *surebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    surebutton.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size:15];
    [surebutton setTitle:@"确定" forState:UIControlStateNormal];
    [surebutton setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [surebutton setFrame:CGRectMake((kScreenWidth - 155)/2, height + 77 - 60, 155, 36)];
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
            if ((aView.tag - sender.tag) < 100 && (aView.tag - sender.tag) > -100) {
                [(UIButton *)aView setTitleColor:UIColorFromRGB(0x6c7374) forState:UIControlStateNormal];
                [aView setBackgroundColor:kWhiteColor];
            }
            
        }
    }
    SaintiLog(@"%zd",sender.tag/1000);
    [self.selectIndexArr replaceObjectAtIndex:(sender.tag/1000 - 1) withObject:[NSString stringWithFormat:@"%zd",sender.tag%1000]];
//    self.selectIndex = (sender.tag/1000 + 1);
}

-(void)surebuttonClick:(UIButton *)sender{
    if (self.selectSure ){
        self.selectSure(self.selectIndexArr);
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
        CGFloat height = 0;
        for (NSInteger i = 0 ; i < _buttonArr.count; i ++) {
            NSArray *itemArr = _buttonArr[i];
            height = height + 40 + ((itemArr.count%3==0)?(itemArr.count/3): (itemArr.count/3+ 1))*45;
            if (i > 0) {
                height = height - 15;
            }
        }
        self.contentView.frame = CGRectMake(0, 0, self.frame.size.width, height + 77 );
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

@end
