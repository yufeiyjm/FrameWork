//
//  TypePickerView.m
//  FrameWork2.0
//
//  Created by yanjiaming on 17/3/5.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "TypePickerView.h"

@implementation TypePickerView

-(void)creatTypePickerView:(UIView *)aView{
    self.tag =909090901;
    UIView *tempView = [aView viewWithTag:909090901];
    [tempView removeFromSuperview];
    if (!_typePick) {
        self.backgroundColor = kWhiteColor;
        self.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 256);
        [aView addSubview:self];
        
        self.typePick = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, 216)];
        self.typePick.delegate = self;
        self.typePick.dataSource = self;
        self.typePick.backgroundColor = kWhiteColor;
        [self addSubview:self.typePick];
        
        
        UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancleBtn setTitleColor:UIColorFromRGB(0x50BDCA) forState:UIControlStateNormal];
        cancleBtn.titleLabel.font = k15Font;
        [cancleBtn setFrame:CGRectMake(20, 0, 44, 40)];
        [cancleBtn addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancleBtn];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromRGB(0x50BDCA) forState:UIControlStateNormal];
        btn.titleLabel.font = k15Font;
        [btn setFrame:CGRectMake(kScreenWidth - 64, 0, 44, 40)];
        [btn addTarget:self action:@selector(finishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        UIView *lineTop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
        lineTop.backgroundColor =UIColorFromRGB(0xE4EAF4);
        [self addSubview:lineTop];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, 0.5)];
        line.backgroundColor =UIColorFromRGB(0xE4EAF4);
        [self addSubview:line];
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, kScreenHeight - 256 -64, kScreenWidth, 256);
    }];
}
-(void)setSelected:(NSInteger)selected{
    _selected = selected;
    [self.typePick selectRow:selected inComponent:0 animated:YES];
}
-(void)cancleClick{
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, kScreenHeight , kScreenWidth, 256);
    }completion:^(BOOL finish){
        [self removeFromSuperview];
    }];
}
-(void)finishClick{
   
    if (self.selectPicker) {
        
      NSString *select = self.typeArr[[self.typePick selectedRowInComponent:0]];
        self.selectPicker(select);
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = CGRectMake(0, kScreenHeight , kScreenWidth, 256);
        }completion:^(BOOL finish){
            [self removeFromSuperview];
        }];
    }
}
#pragma Mark -- UIPickerViewDataSource
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.typeArr count];
}
//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_typeArr objectAtIndex:row];
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
}

@end
