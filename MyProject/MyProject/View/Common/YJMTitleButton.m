//
//  YJMTitleButton.m
//  MyProject
//
//  Created by jiaming yan on 2017/8/23.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "YJMTitleButton.h"
#define ImageW  8

@implementation YJMTitleButton
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        
        //设置图片显示的样式
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentRight;

        [self addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
}
-(void)buttonClick:(UIButton *)sender{
    [UIView animateWithDuration:0.25 animations:^{
        if (CGAffineTransformIsIdentity(sender.imageView.transform)) {
            sender.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        }else{
            sender.imageView.transform = CGAffineTransformIdentity;
        }
        
    }];
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
   CGFloat width = [CommonUtils labelWidthWith:self.font title:self.currentTitle];
    
    CGFloat titleX = (contentRect.size.width - (width + ImageW + 5))/2;
    CGFloat titleH = contentRect.size.height;
    return CGRectMake(titleX, 0, width, titleH);
    
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = ImageW;
    CGFloat imageH = contentRect.size.height;
   CGFloat width = [CommonUtils labelWidthWith:self.font title:self.currentTitle];
    
    CGFloat titleX = (contentRect.size.width - (width + ImageW + 5))/2;

    return CGRectMake(titleX + width + 2.5,0, imageW, imageH);
}

-(void)setHighlighted:(BOOL)highlighted{
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
