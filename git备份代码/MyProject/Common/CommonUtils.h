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

#import <Foundation/Foundation.h>
#import "SDDNetWorkUtils.h"
#import "MBProgressHUD.h"
#import <SystemConfiguration/SystemConfiguration.h>
@interface CommonUtils : NSObject
@property(nonatomic,retain) UIAlertView *alertView;
/*
 方法描述:
 单例模式创建对象
 
 参数说明:
 无
 
 返回结果:
 
 CommonUtils
 */
+ (instancetype)sharedCommonUtils;
/*
 方法说明:
 请求失败时弹出框
 
 参数说明:
 NSString* oStrMsg：提示信息
 
 返回结果:
 void
 */
-(void) showAlert:(NSString *) oStrMsg
         delegate:(id<UIAlertViewDelegate>) delegate;
/*
 方法描述:
 获取应用版本号
 
 参数说明:
 无
 
 返回结果:
 nsstring
 
 */
+ (NSString *)devicesVersion;
+ (UILabel*)createLabelWithText:(NSString*)string frame:(CGRect)frame;

+ (UITextView*)createTextViewWithText:(NSString*)string frame:(CGRect)frame;

+ (UITextField*)createTextFieldWithText:(NSString*)string frame:(CGRect)frame;

+ (UIButton*)createButtonWithText:(NSString*)string frame:(CGRect)frame;
/*
 方法说明:
 判断当前是否有网络。没有网络时, 显示无网络的图片
 
 参数说明:
 (UIView *)aView  在该view上显示无网络的图片
 
 返回结果:
 若当前没有网络, 返回NO; 有网, 返回YES
 */
+ (void)showTipOnView:(UIView *)aView
           withTarget:(id)target
          andSelector:(SEL)action
             andTitle:(NSString *)title;
/*
 方法描述:
 隐藏提示view
 
 参数说明:
 
 
 返回结果:
 
 
 */
+ (void)hideTipOnView:(UIView *)aView;
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
+ (NSString *)communityTimeWithDate:(NSDate *)date;
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
+ (NSString *)messageTimeWithDate:(NSDate *)date;
/*
 方法说明:
 toast显示
 
 参数说明:
 <#参数说明#>
 
 返回结果:
 <#返回结果#>
 */
+ (void)showToast:(NSString *)strTest;
//-判断当前网络是否可用
+(BOOL) isNetworkEnabled;
@end
