//
//  MakeDateSignVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/9/14.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "MakeDateSignVC.h"
#import "NSString+Expand.h"
#define titleTag 1
#define titleSayTag 2
#define contentTag 3
@interface MakeDateSignVC ()
@property (weak, nonatomic) IBOutlet UILabel *titleHanLabel1;
@property (weak, nonatomic) IBOutlet UILabel *titleHanLabel2;
@property (weak, nonatomic) IBOutlet UILabel *titleHanLabel3;
@property (weak, nonatomic) IBOutlet UILabel *titleHanLabel4;
@property (weak, nonatomic) IBOutlet UILabel *titlePinyinLabel1;
@property (weak, nonatomic) IBOutlet UILabel *titlePinyinLabel2;
@property (weak, nonatomic) IBOutlet UILabel *titlePinyinLabel3;
@property (weak, nonatomic) IBOutlet UILabel *titlePinyinLabel4;


@property (weak, nonatomic) IBOutlet UIView *contentBackView;
@property (weak, nonatomic) IBOutlet UILabel *contentMindleLabel;

@property (weak, nonatomic) IBOutlet UILabel *myWordLabel;
@property (weak, nonatomic) IBOutlet UILabel *myWordSayLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@property (weak, nonatomic) IBOutlet UITextField *commitTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sendBottom;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (copy, nonatomic) NSString *userNameStr;

@property (copy, nonatomic) NSString *titleStr;
@property (copy, nonatomic) NSString *titleSayStr;
@property (copy, nonatomic) NSString *contentStr;
@end

@implementation MakeDateSignVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"做日签";
    self.userNameStr = @"严加明";
    self.titleSayStr = self.userNameStr;
    self.myWordLabel.text = self.titleSayStr;
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy年M月dd日"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    //输出格式为：2010-10-27 10:22:13
    NSMutableString *string = [NSMutableString string];
    
    
    NSString *year = [currentDateStr subString:0 length:4] ;
    
    for(int i = 0; i < [year length]; i++) {
        NSString *a = [year subString:i length:1];
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = kCFNumberFormatterRoundHalfDown;
        NSString *aString = [formatter stringFromNumber:[NSNumber numberWithInteger: [a integerValue]]];
        [string appendString:aString];
    }
    [string appendString:@"年"];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterRoundHalfDown;
    NSInteger month = [[currentDateStr subString:5 length:2] integerValue];
    NSString *monthString = [formatter stringFromNumber:[NSNumber numberWithInteger: month]];
    [string appendString:monthString];
    [string appendString:@"月"];
    NSInteger day = [[currentDateStr subString:7 length:2] integerValue];
    NSString *dayString = [formatter stringFromNumber:[NSNumber numberWithInteger: day]];
    [string appendString:dayString];
    [string appendString:@"日"];
    
    self.timeLabel.text = string;
  
    ///监听键盘高度变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"发布" forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(0x13bacd) forState:UIControlStateNormal];
    button.titleLabel.font = k15Font;
    button.frame = CGRectMake(0, 0, 40, 40);
    [button addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer,barItem];
    
}
-(void)addButtonClick{
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}
- (BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}


-(void)textFieldDidBeginEditing:(UITextField *)textField{
   
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.commitTextField.text = @"";
    self.commitTextField.placeholder = @"点击相应区域开始输入";
    self.commitTextField.tag = 0;
}
///动态更改frame
-(void)keyboardFrameChange:(NSNotification *)notify
{
    NSDictionary *dict = [notify userInfo];
    NSValue *endValue = [dict objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect endFrame = [endValue CGRectValue];
    SaintiLog(@"%f---%f",endFrame.origin.y,endFrame.size.height);
    
    
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    
    NSNumber *isShowKeyboardValue = [dict objectForKey:@"UIKeyboardIsLocalUserInfoKey"];
    BOOL isShowKeyboard = isShowKeyboardValue.boolValue;
    
    
    if (isShowKeyboard)
    {
        
        ///键盘高度更改
        [self.bottomView setFrame:CGRectMake(0, endFrame.origin.y - 55 - 64 , screenWidth, 55)];
        self.sendBottom.constant = (screenHeight - endFrame.origin.y);
    }
    else
    {
        //        [UIView beginAnimations:nil context:nil];
        //        [UIView setAnimationDuration:0.25];
        ///键盘隐藏
        [self.bottomView setFrame:CGRectMake(0, screenHeight, screenWidth, 55)];
        self.sendBottom.constant = 0;
        //         [UIView commitAnimations];
    }
    
    
    
}


- (IBAction)titleClick:(id)sender {
    self.commitTextField.tag = titleTag;
    self.commitTextField.text = self.titleStr;
    self.commitTextField.placeholder = @"";
    [self.commitTextField becomeFirstResponder];
}
- (IBAction)titleSayClick:(id)sender {
    self.commitTextField.tag = titleSayTag;
    self.commitTextField.text = self.titleSayStr;
    self.commitTextField.placeholder = @"请输入签名";
    [self.commitTextField becomeFirstResponder];
}
- (IBAction)contentClick:(id)sender {
    self.commitTextField.tag = contentTag;
    self.commitTextField.text = self.contentStr;
    [self.commitTextField becomeFirstResponder];
}
- (IBAction)finishClick:(id)sender {
    if (self.commitTextField.tag == titleTag) {
        /**词语*/
        if (self.commitTextField.text.length > 4) {
            ALERT_VIEW(@"最多只能输入4个词语");
            return;
        }
        self.titleStr = self.commitTextField.text;
        self.titleHanLabel1.textColor = UIColorFromRGB(0X686E6F);
        self.titleHanLabel2.textColor = UIColorFromRGB(0X686E6F);
        self.titleHanLabel3.textColor = UIColorFromRGB(0X686E6F);
        self.titleHanLabel4.textColor = UIColorFromRGB(0X686E6F);
        self.titlePinyinLabel1.textColor = UIColorFromRGB(0X686E6F);
        self.titlePinyinLabel2.textColor = UIColorFromRGB(0X686E6F);
        self.titlePinyinLabel3.textColor = UIColorFromRGB(0X686E6F);
        self.titlePinyinLabel4.textColor = UIColorFromRGB(0X686E6F);
        if (self.titleStr.length == 0) {
            self.titleHanLabel1.textColor = UIColorFromRGB(0X9FA6A7);
            self.titleHanLabel2.textColor = UIColorFromRGB(0X9FA6A7);
            self.titlePinyinLabel1.textColor = UIColorFromRGB(0X9FA6A7);
            self.titlePinyinLabel2.textColor = UIColorFromRGB(0X9FA6A7);
            /**0个汉字时*/
            self.titleHanLabel1.hidden = NO;
            self.titleHanLabel2.hidden = NO;
            self.titleHanLabel3.hidden = YES;
            self.titleHanLabel4.hidden = YES;
            self.titlePinyinLabel1.hidden = NO;
            self.titlePinyinLabel2.hidden = NO;
            self.titlePinyinLabel3.hidden = YES;
            self.titlePinyinLabel4.hidden = YES;
            
            self.titleHanLabel1.text = @"词";
            self.titlePinyinLabel1.text = [self hanzhuanPin:@"词"];
            self.titleHanLabel2.text = @"语";
            self.titlePinyinLabel2.text = [self hanzhuanPin:@"语"];
            
        }else if (self.titleStr.length == 1) {
            /**一个汉字时*/
            self.titleHanLabel1.hidden = NO;
            self.titleHanLabel2.hidden = YES;
            self.titleHanLabel3.hidden = YES;
            self.titleHanLabel4.hidden = YES;
            self.titlePinyinLabel1.hidden = NO;
            self.titlePinyinLabel2.hidden = YES;
            self.titlePinyinLabel3.hidden = YES;
            self.titlePinyinLabel4.hidden = YES;
            
            self.titleHanLabel1.text = self.titleStr;
            self.titlePinyinLabel1.text = [self hanzhuanPin:self.titleStr];
            
        }else if (self.titleStr.length == 2) {
             /**2个汉字时*/
            self.titleHanLabel1.hidden = NO;
            self.titleHanLabel2.hidden = NO;
            self.titleHanLabel3.hidden = YES;
            self.titleHanLabel4.hidden = YES;
            self.titlePinyinLabel1.hidden = NO;
            self.titlePinyinLabel2.hidden = NO;
            self.titlePinyinLabel3.hidden = YES;
            self.titlePinyinLabel4.hidden = YES;
            
            self.titleHanLabel1.text = [self.titleStr subString:0 length:1];
            self.titlePinyinLabel1.text = [self hanzhuanPin:[self.titleStr subString:0 length:1]];
            
            self.titleHanLabel2.text = [self.titleStr subString:1 length:1];
            self.titlePinyinLabel2.text = [self hanzhuanPin:[self.titleStr subString:1 length:1]];
        }else if (self.titleStr.length == 3) {
             /**3个汉字时*/
            self.titleHanLabel1.hidden = NO;
            self.titleHanLabel2.hidden = NO;
            self.titleHanLabel3.hidden = NO;
            self.titleHanLabel4.hidden = YES;
            self.titlePinyinLabel1.hidden = NO;
            self.titlePinyinLabel2.hidden = NO;
            self.titlePinyinLabel3.hidden = NO;
            self.titlePinyinLabel4.hidden = YES;
            
            self.titleHanLabel1.text = [self.titleStr subString:0 length:1];
            self.titlePinyinLabel1.text = [self hanzhuanPin:[self.titleStr subString:0 length:1]];
            
            self.titleHanLabel2.text = [self.titleStr subString:1 length:1];
            self.titlePinyinLabel2.text = [self hanzhuanPin:[self.titleStr subString:1 length:1]];
            
            self.titleHanLabel3.text = [self.titleStr subString:2 length:1];
            self.titlePinyinLabel3.text = [self hanzhuanPin:[self.titleStr subString:2 length:1]];
        }else if (self.titleStr.length == 4) {
             /**4个汉字时*/
            self.titleHanLabel1.hidden = NO;
            self.titleHanLabel2.hidden = NO;
            self.titleHanLabel3.hidden = NO;
            self.titleHanLabel4.hidden = NO;
            self.titlePinyinLabel1.hidden = NO;
            self.titlePinyinLabel2.hidden = NO;
            self.titlePinyinLabel3.hidden = NO;
            self.titlePinyinLabel4.hidden = NO;
            
            self.titleHanLabel1.text = [self.titleStr subString:0 length:1];
            self.titlePinyinLabel1.text = [self hanzhuanPin:[self.titleStr subString:0 length:1]];
            
            self.titleHanLabel2.text = [self.titleStr subString:1 length:1];
            self.titlePinyinLabel2.text = [self hanzhuanPin:[self.titleStr subString:1 length:1]];
            
            self.titleHanLabel3.text = [self.titleStr subString:2 length:1];
            self.titlePinyinLabel3.text = [self hanzhuanPin:[self.titleStr subString:2 length:1]];
            
            self.titleHanLabel4.text = [self.titleStr subString:3 length:1];
            self.titlePinyinLabel4.text = [self hanzhuanPin:[self.titleStr subString:3 length:1]];
        }
    }else if (self.commitTextField.tag == titleSayTag) {
        /**右下角个性签名*/
        if (self.commitTextField.text.length > 6) {
            ALERT_VIEW(@"签名最多6个字");
            return;
        }
        self.titleSayStr = self.commitTextField.text;
        if (self.titleSayStr.length == 0) {/**用户清空数据*/
            self.titleSayStr = self.userNameStr;
            self.myWordLabel.textColor = UIColorFromRGB(0X9FA6A7);
            self.myWordSayLabel.textColor = UIColorFromRGB(0X9FA6A7);
        }else{
            self.myWordLabel.textColor = UIColorFromRGB(0X686E6F);
            self.myWordSayLabel.textColor = UIColorFromRGB(0X686E6F);
        }
        self.myWordLabel.text = self.titleSayStr;
    }else if (self.commitTextField.tag == contentTag) {
        
        /**日签内容*/
        for (UIView *aView in [self.contentBackView subviews]) {
            [aView removeFromSuperview];
        }
        self.contentStr = self.commitTextField.text;
        
        
        NSInteger line = self.contentStr.length%16==0?(self.contentStr.length/16):(self.contentStr.length/16+1);
        
        if (line == 0) {/**用户清空数据*/
            self.contentMindleLabel.hidden = NO;
        }else{
            self.contentMindleLabel.hidden = YES;
        }
        for (NSInteger i = 0; i < line; i ++) {
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 155 - 25*line)/2 + 25*i, 12, 18, 338)];
            lab.font = [UIFont fontWithName:@"FZQingKeBenYueSongS-R-GB" size:18];
            lab.numberOfLines = 0;
            lab.textColor = UIColorFromRGB(0X686E6F);

            
            NSString *txt = @"";
            if (i == (line -1)) {
                if (line == 1) {
                    txt = self.contentStr;
                }else{
                    SaintiLog(@"l=%zd ----- len = %zd",self.contentStr.length,(self.contentStr.length - 16*i));
                    txt = [self.contentStr subString:16*i length:(self.contentStr.length - 16*i)];
                }
                
            }else{
                txt = [self.contentStr subString:16*i length:16];
            }
            lab.text = txt;
            [self.contentBackView addSubview:lab];
        }
    }
    [self.commitTextField resignFirstResponder];
}
- (IBAction)closeClick:(id)sender {
    [self.commitTextField resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)hanzhuanPin:(NSString *)han{
    NSMutableString * pinYin = [[NSMutableString alloc]initWithString:han];
    //1.先转换为带声调的拼音
    if(CFStringTransform((__bridge CFMutableStringRef)pinYin, NULL, kCFStringTransformMandarinLatin, NO)) {
        NSLog(@"带声调的pinyin: %@", pinYin);
        return pinYin;
    }else{
        return nil;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
