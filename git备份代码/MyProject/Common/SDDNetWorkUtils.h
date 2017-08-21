/*
 ***************************************************************************
 * 建立日期	： 2014-04-15
 * 版权声明	： 本代码版权归圣笛科技所有，禁止任何未授权的传播和使用
 * 作者		： yanjiaming@sainti.com
 * 模块		：
 * 描述		： 判断网络链接
 * -------------------------------------------------------------------------
 * 修改历史
 * 序号			日期					修改人				修改原因
 * <#序号#>        <#日期#>                <#修改人#>              <#修改原因#>
 *
 ***************************************************************************
 */

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import "Reachability.h"

typedef enum {
    SDDNewWorkStatusNone,
    SDDNewWorkStatusWIFI,
    SDDNewWorkStatusWWAN
} SDDNetWorkStatus;


@interface SDDNetWorkUtils : NSObject<UIAlertViewDelegate>


/*
 方法描述:
    判断当前网络连接状态
 
 参数说明:
    无
 
 返回结果:
    SDDNetWorkStatus   
        SDDNewWorkStatusWIFI：WIFI连接
        SDDNewWorkStatus3G：3G连接
        SDDNewWorkStatusNone：无网络连接
 */
+ (SDDNetWorkStatus) currentNetworkStatus;

/*
 方法描述:
    判断是否有网络
 
 参数说明:
    无
 
 返回结果:
    BOOL YES表示网络可达，NO表示无网络
 */
+ (BOOL)isHostReachable;



@end
