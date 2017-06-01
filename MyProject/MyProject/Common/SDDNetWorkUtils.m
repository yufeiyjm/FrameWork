
/* 判断网络连接
 ***************************************************************************
 * 类名	    ： SDDNetWorkJudge
 * 建立日期	： 2012-08-06
 * 版权声明	： 本代码版权归东软集团（大连）有限公司所有，禁止任何未授权的传播和使用
 * 作者		： peng_y@neusoft.com
 * 模块		： 
 * 描述		： 判断网络是否可达
 * -------------------------------------------------------------------------
 * 修改历史
 * 序号			日期					修改人				修改原因
 * 1																
 * 2																
 ***************************************************************************
 */



#import "SDDNetWorkUtils.h"
#import <QuartzCore/QuartzCore.h>

@implementation SDDNetWorkUtils




/*
 方法描述:
    判断当前网络连接状态
 
 参数说明:
    无
 
 返回结果:
       SDDNewWorkStatusNone：无网络连接
       SDDNewWorkStatusWIFI：WIFI网络连接
       SDDNewWorkStatusWWAN：蜂窝网络连接
       
 */
+ (SDDNetWorkStatus)currentNetworkStatus {
    NetworkStatus wifiStatusTemp = [[Reachability reachabilityForLocalWiFi] 
                                    currentReachabilityStatus];
    if (wifiStatusTemp == ReachableViaWiFi) {
        return SDDNewWorkStatusWIFI;
    };
    NetworkStatus connStatusTemp = [[Reachability reachabilityForInternetConnection] 
                                    currentReachabilityStatus];
    if (connStatusTemp == NotReachable) {
        return SDDNewWorkStatusNone;
    }
    return SDDNewWorkStatusWWAN;
}

/*
 方法描述:
     判断是否有网络
 
 参数说明:
     无
 
 返回结果:
     BOOL YES表示网络可达，NO表示无网络
 */
+ (BOOL)isHostReachable{
    NetworkStatus connStatusTemp = [[Reachability reachabilityForInternetConnection]
                                    currentReachabilityStatus];
    if (connStatusTemp == NotReachable) {
        return NO;
    }else{
        return YES;
    }
}

@end
