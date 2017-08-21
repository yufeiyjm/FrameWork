//
//  SendRequest.m
//  SaintiFrameWork
//
//  Created by yan.jm on 14-5-6.
//  Copyright (c) 2014年 yan.jm. All rights reserved.
//

#import "SendRequest.h"
#import "SaintiNetWork.h"
@implementation SendRequest
/*
 方法说明:
 获取机场列表
 
 参数说明:
 空
 
 返回结果:
 NSDictionary *result；block的返回结果，这个可以自定义，可以是数组，字典，也可以是一个实例类，建议实例类，这样用起来比较方便，代码易读。
 */
+ (NSURLSessionDataTask *)requestAirportListWithLat:(NSString *)lat lon:(NSString *)lon result:(void (^)(NSDictionary *result, NSError *error))block{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    if (lat.length > 0) {
        [dic setObject:lat forKey:@"lat"];
        [dic setObject:lon forKey:@"lon"];
    }else{
        [dic setObject:@"40.7128" forKey:@"lat"];
        [dic setObject:@"-74.0059" forKey:@"lon"];
    }
    

    return [[SaintiNetWork sharedClient]GET:@"v1/airport" parameters:dic progress:nil success:^(NSURLSessionDataTask * __unused task, id JSON){
        if (block) {//添加block返回
            block(JSON, nil);
        }
    }failure:^(NSURLSessionDataTask *task, NSError *error){
        if (block) {
            block(nil, error);
        }
    }];
    
}
/*
 方法说明:
 查询当前出行最低票价。
 
 参数说明:
 空
 
 返回结果:
 NSDictionary *result；block的返回结果，这个可以自定义，可以是数组，字典，也可以是一个实例类，建议实例类，这样用起来比较方便，代码易读。
 */
+ (NSURLSessionDataTask *)requestLowestWithOrigin:(NSString *)origin dest:(NSString *)dest deptdate:(NSString *)deptdate returndate:(NSString *)returndate result:(void (^)(NSDictionary *result, NSError *error))block{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:origin forKey:@"origin"];
    [dic setObject:dest forKey:@"dest"];
    [dic setObject:deptdate forKey:@"deptdate"];
    [dic setObject:returndate forKey:@"returndate"];
    
    return [[SaintiNetWork sharedClient]GET:@"v1/fare/lowest" parameters:dic progress:nil success:^(NSURLSessionDataTask * __unused task, id JSON){
        if (block) {//添加block返回
            block(JSON, nil);
        }
    }failure:^(NSURLSessionDataTask *task, NSError *error){
        if (block) {
            block(nil, error);
        }
    }];
    
}
/*
 方法说明:
 Query for the lowest fare for the given trip in the past 2 weeks
 查询过去2周行程中的最低票价
 
 参数说明:
 空
 
 返回结果:
 NSDictionary *result；block的返回结果，这个可以自定义，可以是数组，字典，也可以是一个实例类，建议实例类，这样用起来比较方便，代码易读。
 */
+ (NSURLSessionDataTask *)requestHistoryWithOrigin:(NSString *)origin dest:(NSString *)dest deptdate:(NSString *)deptdate returndate:(NSString *)returndate result:(void (^)(NSDictionary *result, NSError *error))block{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:origin forKey:@"origin"];
    [dic setObject:dest forKey:@"dest"];
    [dic setObject:deptdate forKey:@"deptdate"];
    [dic setObject:returndate forKey:@"returndate"];
    
    return [[SaintiNetWork sharedClient]GET:@"v2/fare/history" parameters:dic progress:nil success:^(NSURLSessionDataTask * __unused task, id JSON){
        if (block) {//添加block返回
            block(JSON, nil);
        }
    }failure:^(NSURLSessionDataTask *task, NSError *error){
        if (block) {
            block(nil, error);
        }
    }];
    
}
/*
 方法说明:
 Lowest fare calendar in the future (Calendar)
 
 未来价格预测
 
 参数说明:
 空
 
 返回结果:
 NSDictionary *result；block的返回结果，这个可以自定义，可以是数组，字典，也可以是一个实例类，建议实例类，这样用起来比较方便，代码易读。
 */
+ (NSURLSessionDataTask *)requestCalendarWithOrigin:(NSString *)origin dest:(NSString *)dest los:(NSString *)los result:(void (^)(NSDictionary *result, NSError *error))block{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:origin forKey:@"origin"];
    [dic setObject:dest forKey:@"dest"];
    [dic setObject:los forKey:@"los"];
    
    return [[SaintiNetWork sharedClient]GET:@"v1/fare/calendar" parameters:dic progress:nil success:^(NSURLSessionDataTask * __unused task, id JSON){
        if (block) {//添加block返回
            block(JSON, nil);
        }
    }failure:^(NSURLSessionDataTask *task, NSError *error){
        if (block) {
            block(nil, error);
        }
    }];
    
}
/*
 方法说明:
 现在是否适合购买机票
 
 参数说明:
 空
 
 返回结果:
 NSDictionary *result；block的返回结果，这个可以自定义，可以是数组，字典，也可以是一个实例类，建议实例类，这样用起来比较方便，代码易读。
 */
+ (NSURLSessionDataTask *)requestRecommendWithOrigin:(NSString *)origin dest:(NSString *)dest deptdate:(NSString *)deptdate returndate:(NSString *)returndate result:(void (^)(NSDictionary *result, NSError *error))block{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:origin forKey:@"origin"];
    [dic setObject:dest forKey:@"dest"];
    [dic setObject:deptdate forKey:@"deptdate"];
    [dic setObject:returndate forKey:@"returndate"];
    
    return [[SaintiNetWork sharedClient]GET:@"v2/fare/recommend" parameters:dic progress:nil success:^(NSURLSessionDataTask * __unused task, id JSON){
        if (block) {//添加block返回
            block(JSON, nil);
        }
    }failure:^(NSURLSessionDataTask *task, NSError *error){
        if (block) {
            block(nil, error);
        }
    }];
    
}
/*
 方法说明:
 查询城市代码，根据机场名或者城市
 
 参数说明:
 空
 
 返回结果:
 NSDictionary *result；block的返回结果，这个可以自定义，可以是数组，字典，也可以是一个实例类，建议实例类，这样用起来比较方便，代码易读。
 */
+ (NSURLSessionDataTask *)requestCityCodeWithTerm:(NSString *)term result:(void (^)(NSDictionary *result, NSError *error))block{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:term forKey:@"term"];
    return [[SaintiNetWork sharedClient]GET:@"v1/airport/autocomplete" parameters:dic progress:nil success:^(NSURLSessionDataTask * __unused task, id JSON){
        if (block) {//添加block返回
            block(JSON, nil);
        }
    }failure:^(NSURLSessionDataTask *task, NSError *error){
        if (block) {
            block(nil, error);
        }
    }];
    
}
/*
 方法说明:
 Calendar Heatmap (New)
 
 价格预测
 
 参数说明:
 空
 
 返回结果:
 NSDictionary *result；block的返回结果，这个可以自定义，可以是数组，字典，也可以是一个实例类，建议实例类，这样用起来比较方便，代码易读。
 */
+ (NSURLSessionDataTask *)requestCalendarHeatWithOrigin:(NSString *)origin dest:(NSString *)dest result:(void (^)(NSDictionary *result, NSError *error))block{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:origin forKey:@"origin"];
    [dic setObject:dest forKey:@"dest"];
    
    return [[SaintiNetWork sharedClient]GET:@"v2/fare/heat" parameters:dic progress:nil success:^(NSURLSessionDataTask * __unused task, id JSON){
        if (block) {//添加block返回
            block(JSON, nil);
        }
    }failure:^(NSURLSessionDataTask *task, NSError *error){
        if (block) {
            block(nil, error);
        }
    }];
    
}
/*
 方法说明:
 获取ip请求地址
 
 参数说明:
 空
 
 返回结果:
 NSDictionary *result；block的返回结果，这个可以自定义，可以是数组，字典，也可以是一个实例类，建议实例类，这样用起来比较方便，代码易读。
 */
+ (NSURLSessionDataTask *)requestUrlRouteWithLanguage:(NSString *)language result:(void (^)(NSDictionary *result, NSError *error))block{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:language forKey:@"area"];

    
    return [[SaintiNetWork sharedClient]GET:@"v1/route" parameters:dic progress:nil success:^(NSURLSessionDataTask * __unused task, id JSON){
        if (block) {//添加block返回
            block(JSON, nil);
        }
    }failure:^(NSURLSessionDataTask *task, NSError *error){
        if (block) {
            block(nil, error);
        }
    }];
    
}
+(void)uploadWithFileDatas:(NSArray *)dataArr result:(void (^)(NSDictionary *result, NSError *error))block{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];

    [dic setObject:@"f2a3a267ec0af4bc7865a2a8c07e9cb4" forKey:@"user_token"];
    [dic setObject:@"29" forKey:@"user_id"];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://yueban.demo.sainti.net/app_api/index.php/upload_picture" parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (NSInteger i = 0 ; i < dataArr.count; i++) {
            [formData appendPartWithFileData:dataArr[i] name:@"file[]" fileName:@"filename.jpg" mimeType:@"image/jpeg"];
        }
        
    } error:nil];
    request.timeoutInterval = 500;
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    MBProgressHUD *_progressHUD = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    _progressHUD.mode = MBProgressHUDModeDeterminate;
    _progressHUD.color = [UIColor blackColor];
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
                      dispatch_async(dispatch_get_main_queue(), ^{
                          //Update the progress view
                          _progressHUD.progress = uploadProgress.fractionCompleted;
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      [_progressHUD hide:YES];
                      if (error) {
                          if (block) {
                              block(nil, error);
                          }
                      } else {
                          if (block) {//添加block返回
                              NSError *parseError = nil;
                              NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:&parseError];
                              NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                              NSLog(@"json = %@",json);
                              block(responseObject, nil);
                          }
                      }
                  }];
    
    [uploadTask resume];

}
+(void)downLoadWithFileDatas:(NSArray *)dataArr result:(void (^)(NSDictionary *result, NSError *error))block{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    
    [dic setObject:@"f2a3a267ec0af4bc7865a2a8c07e9cb4" forKey:@"user_token"];
    [dic setObject:@"29" forKey:@"user_id"];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://yueban.demo.sainti.net/app_api/index.php/upload_picture" parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (NSInteger i = 0 ; i < dataArr.count; i++) {
            [formData appendPartWithFileData:dataArr[i] name:@"file[]" fileName:@"filename.jpg" mimeType:@"image/jpeg"];
        }
        
    } error:nil];
    request.timeoutInterval = 500;
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    MBProgressHUD *_progressHUD = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    _progressHUD.mode = MBProgressHUDModeDeterminate;
    _progressHUD.color = [UIColor blackColor];
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
                      dispatch_async(dispatch_get_main_queue(), ^{
                          //Update the progress view
                          _progressHUD.progress = uploadProgress.fractionCompleted;
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      [_progressHUD hide:YES];
                      if (error) {
                          if (block) {
                              block(nil, error);
                          }
                      } else {
                          if (block) {//添加block返回
                              NSError *parseError = nil;
                              NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:&parseError];
                              NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                              NSLog(@"json = %@",json);
                              block(responseObject, nil);
                          }
                      }
                  }];
    
    [uploadTask resume];
    
}
@end
