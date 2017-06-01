/*
 ***************************************************************************
 * 建立日期	： 2014-04-15
 * 版权声明	： 本代码版权归圣笛科技所有，禁止任何未授权的传播和使用
 * 作者		： yanjiaming@sainti.com
 * 模块		：
 * 描述		： 全局通用的一些方法
 * -------------------------------------------------------------------------
 * 修改历史
 * 序号			日期					修改人				修改原因
 * <#序号#>        <#日期#>                <#修改人#>              <#修改原因#>
 *
 ***************************************************************************
 */

#import "CommonUtils.h"
#define kdefaultFont [UIFont systemFontOfSize:15.0f]
#define kNoNetImgViewKey   2917
#define kBtnTag            3918
//无数据时的文字颜色
#define kNoDataTitleColor      kColor(160,160,160,1)
#define kBackGrayColor         kColor(221,221,221,1)
//无数据时的文字大小
#define kNoDataTitleSize 18
@implementation CommonUtils
+ (instancetype)sharedCommonUtils {
    static CommonUtils *_commonUtils = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _commonUtils = [[CommonUtils alloc] init];
    });
    
    return _commonUtils;
}
/*
 方法说明:
 请求失败时弹出框
 
 参数说明:
 NSString* oStrMsg：提示信息
 
 返回结果:
 void
 */
-(void) showAlert:(NSString *) oStrMsg
         delegate:(id<UIAlertViewDelegate>) delegate {
    [self.alertView dismissWithClickedButtonIndex:0 animated:NO];
    self.alertView =[[UIAlertView alloc] initWithTitle:@"提示:"
                                               message:oStrMsg
                                              delegate:delegate
                                     cancelButtonTitle:@"确定"
                                     otherButtonTitles:nil,nil ];
    self.alertView.tag=888;
    [self.alertView show];
}
/*
 方法描述:
 获取应用版本号
 
 参数说明:
 无
 
 返回结果:
 nsstring
 
 */
+ (NSString *)devicesVersion{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}
//
//static const CGFloat borderWidth = 0.5;

+ (UILabel*)createLabelWithText:(NSString*)string frame:(CGRect)frame {
    UILabel *result = [[UILabel alloc] initWithFrame:frame];
    result.numberOfLines = 0;
    result.backgroundColor = [UIColor clearColor];
    result.textColor = [UIColor whiteColor];
    result.text = string;
    result.font = kdefaultFont;
//    result.layer.borderColor = [UIColor darkGrayColor].CGColor;
//    result.layer.borderWidth = borderWidth;
    
    return result ;
}

+ (UITextView*)createTextViewWithText:(NSString*)string frame:(CGRect)frame {
    UITextView *result = [[UITextView alloc] initWithFrame:frame];
    result.text = string;
    result.backgroundColor = [UIColor clearColor];
    result.textColor = [UIColor whiteColor];
    result.font = kdefaultFont;
    
    return result;
}

+ (UITextField*)createTextFieldWithText:(NSString*)string frame:(CGRect)frame {
    UITextField *result = [[UITextField alloc] initWithFrame:frame];
    result.text = string;
    result.backgroundColor = [UIColor clearColor];
    result.textColor = [UIColor whiteColor];
    result.font = kdefaultFont;
    
    return result;
}

+ (UIButton*)createButtonWithText:(NSString*)string frame:(CGRect)frame {
    UIButton *result = [UIButton buttonWithType:UIButtonTypeCustom];
    [result setFrame:frame];
    [result setTitle: string forState:UIControlStateNormal];
    result.backgroundColor = [UIColor clearColor];
    [result setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    return result;
}
/*
 方法说明:
 判断当前是否有网络
 
 参数说明:
 (UIView *)aView  在该view上显示无网络的图片
 
 返回结果:
 若当前没有网络, 返回NO;
 有网, 返回YES
 */
+ (void)showTipOnView:(UIView *)aView
           withTarget:(id)target
          andSelector:(SEL)action
             andTitle:(NSString *)title
{
    
    BOOL isFindoutShade = NO;
    
    for (UIView *tempView in aView.subviews )
    {
        if (tempView.tag == kNoNetImgViewKey)
        {
            tempView.hidden = NO;
            isFindoutShade = YES;
            [aView bringSubviewToFront:tempView];
            
            for (UIView *view in tempView.subviews) {
                if (view.tag==kBtnTag) {
                    UIButton *tempBtn=(UIButton *)view;
                    [tempBtn setTitle:title forState:UIControlStateNormal];
                }
                
            }
        }
        
        
        
    }
    
    if (!isFindoutShade)
    {
        float viewWidth  = aView.frame.size.width;
        float viewHeight = aView.frame.size.height;
        //            [aView setBackgroundColor:[UIColor redColor]];
        CGRect shadeImgViewRect = CGRectMake(0, 64, viewWidth, viewHeight - 64);
        UIImageView *shadeView = [[UIImageView alloc] initWithFrame:shadeImgViewRect];
        [shadeView setUserInteractionEnabled:YES];
        shadeView.tag = kNoNetImgViewKey;
        shadeView.backgroundColor = kWhiteColor;
        
        UIButton *noDataBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [noDataBtn setFrame:CGRectMake(0, 0, aView.frame.size.width, aView.frame.size.height)];
        //            [[UIButton alloc]initWithFrame:labRect];
        noDataBtn.tag = kBtnTag;
        noDataBtn.backgroundColor = [UIColor clearColor];
        [noDataBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:kNoDataTitleSize]];
        [noDataBtn setTitleColor:kNoDataTitleColor forState:UIControlStateNormal];
        [noDataBtn.titleLabel setTextColor:kNoDataTitleColor];
        [noDataBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
        //        [noDataBtn setBackgroundColor:[UIColor clearColor]];
        [noDataBtn setTitle:title forState:UIControlStateNormal];
        [noDataBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        [shadeView addSubview:noDataBtn];

        UIImageView *noDataView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 35)];
        noDataView.image = IMAGE(@"noData");
        noDataView.center =  shadeView.center;
        [shadeView addSubview:noDataView];
      
     
        [aView addSubview:shadeView];
    }
    
}
/*
 方法描述:
 隐藏提示view
 
 参数说明:
 
 
 返回结果:
 
 
 */
+ (void)hideTipOnView:(UIView *)aView
{
    for (UIView *tempView in aView.subviews )
    {
        if (tempView.tag == kNoNetImgViewKey)
        {
            tempView.hidden = YES;
        }
        //            else
        //            {
        //                tempView.hidden = NO;
        //            }
    }
    
}
/*
 方法说明:
 社区模块：
 1.1小时以内：显示多少分钟之前 (例如：2分钟前）
 2.1小时~24小时：显示多少小时之前 （例如：5小时前）
 3.一周之内：显示多少天之前 （例如：5天前）
 4.超过一周：显示年月日 （例如：14-10-25）
 
 参数说明:
 (UIView *)aView  在该view上显示无网络的图片
 
 返回结果:
 若当前没有网络, 返回NO; 有网, 返回YES
 */
+ (NSString *)communityTimeWithDate:(NSDate *)date{
    NSTimeInterval late=[date timeIntervalSince1970]*1;
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    
     NSTimeInterval cha=now-late;
    NSString *timeString=@"";
    if (cha/3600<=1) {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
        
    }
    if (cha/3600>1&&cha/86400<=1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
//        NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
//        [dateformatter setDateFormat:@"HH:mm"];
//        timeString = [NSString stringWithFormat:@"今天 %@",[dateformatter stringFromDate:date]];
    }
    
    if (cha/86400>1&&cha/604800<=1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@天前", timeString];
//        NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
//        [dateformatter setDateFormat:@"YY-MM-dd HH:mm"];
//        timeString = [NSString stringWithFormat:@"%@",[dateformatter stringFromDate:date]];
    }
    if (cha/604800>1)
    {

        NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"YYYY-MM-dd"];
        timeString = [NSString stringWithFormat:@"%@",[dateformatter stringFromDate:date]];
    }
    return timeString;
}
/*
 方法说明:
 消息模块：
 1.24小时消失以内：显示小时+分钟 （例如：13:34）
 2.24小时~48小时： 显示昨天
 3.超过48小时：显示月+日 （例如：10-25)
 
 参数说明:
 (UIView *)aView  在该view上显示无网络的图片
 
 返回结果:
 若当前没有网络, 返回NO; 有网, 返回YES
 */
+ (NSString *)messageTimeWithDate:(NSDate *)date{
    NSTimeInterval late=[date timeIntervalSince1970]*1;
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    
    NSTimeInterval cha=now-late;
    NSString *timeString=@"";
    if (cha/86400<=1) {
//        timeString = [NSString stringWithFormat:@"%f", cha/60];
//        timeString = [timeString substringToIndex:timeString.length-7];
//        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
        NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"HH:mm"];
        timeString = [NSString stringWithFormat:@"%@",[dateformatter stringFromDate:date]];

        
    }
    if (cha/86400>1&&cha/172800<=1) {
        timeString = @"昨天";
//        timeString = [NSString stringWithFormat:@"%f", cha/3600];
//        timeString = [timeString substringToIndex:timeString.length-7];
//        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
//                NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
//                [dateformatter setDateFormat:@"HH:mm"];
//                timeString = [NSString stringWithFormat:@"今天 %@",[dateformatter stringFromDate:date]];
    }
    
    if (cha/172800>1)
    {
        NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"MM-dd"];
        timeString = [NSString stringWithFormat:@"%@",[dateformatter stringFromDate:date]];    }
       return timeString;

}
/*
 方法说明:
 toast显示
 
 参数说明:
 <#参数说明#>
 
 返回结果:
 <#返回结果#>
 */
+ (void)showToast:(NSString *)strTest{
    MBProgressHUD *loading = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    loading.mode = MBProgressHUDModeText;
    loading.color = [UIColor blackColor];
    loading.labelText = strTest;
    
    [loading hide:YES afterDelay:1.0f];
    
    
}

//-判断当前网络是否可用
+(BOOL) isNetworkEnabled
{
    BOOL bEnabled = FALSE;
    NSString *url = @"www.baidu.com";
    SCNetworkReachabilityRef ref = SCNetworkReachabilityCreateWithName(NULL, [url UTF8String]);
    SCNetworkReachabilityFlags flags;
    
    bEnabled = SCNetworkReachabilityGetFlags(ref, &flags);
    
    CFRelease(ref);
    if (bEnabled) {
        //        kSCNetworkReachabilityFlagsReachable：能够连接网络
        //        kSCNetworkReachabilityFlagsConnectionRequired：能够连接网络，但是首先得建立连接过程
        //        kSCNetworkReachabilityFlagsIsWWAN：判断是否通过蜂窝网覆盖的连接，比如EDGE，GPRS或者目前的3G.主要是区别通过WiFi的连接。
        BOOL flagsReachable = ((flags & kSCNetworkFlagsReachable) != 0);
        BOOL connectionRequired = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
        BOOL nonWiFi = flags & kSCNetworkReachabilityFlagsTransientConnection;
        bEnabled = ((flagsReachable && !connectionRequired) || nonWiFi) ? YES : NO;
    }
    
    return bEnabled;
}
@end
