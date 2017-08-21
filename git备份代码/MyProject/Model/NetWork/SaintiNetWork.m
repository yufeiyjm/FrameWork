/*
 ***************************************************************************
 * 建立日期	： 2014-04-15
 * 版权声明	： 本代码版权归圣笛科技所有，禁止任何未授权的传播和使用
 * 作者		： yanjiaming@sainti.com
 * 模块		：
 * 描述		： AFNetWorking单例
 * -------------------------------------------------------------------------
 * 修改历史
 * 序号			日期					修改人				修改原因
 * <#序号#>        <#日期#>                <#修改人#>              <#修改原因#>
 *
 ***************************************************************************
 */

#import "SaintiNetWork.h"
static NSString * const AFAppDotNetAPIBaseURLString = BASEURL;//post请求测试
@implementation SaintiNetWork
+ (instancetype)sharedClient {
    static SaintiNetWork *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([UrlSharedManager sharedManager].requestUrl.length > 0) {
            _sharedClient = [[SaintiNetWork alloc] initWithBaseURL:[NSURL URLWithString:[UrlSharedManager sharedManager].requestUrl]];
        }else{
            _sharedClient = [[SaintiNetWork alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
        }
        
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
//        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        if([_sharedClient.responseSerializer isKindOfClass:[AFJSONResponseSerializer class]]){
            ((AFJSONResponseSerializer *)(_sharedClient.responseSerializer)).removesKeysWithNullValues = YES;
        }
    });
    return _sharedClient;
}

@end
