//
//  TZNetworkTool.m
//  315-networkPrc
//
//  Created by user on 16/3/15.
//  Copyright © 2016年 M&M. All rights reserved.
//

#import "TTNetworkTool.h"

@implementation TTNetworkTool
#pragma mark - ======== 单例创建方法 ========
+ (instancetype)sharedNetworkTool
{
    return [self sharedNetworkToolWithBaseUrl:nil];
}

+ (instancetype)sharedNetworkToolWithBaseUrl:(NSString *)baseUrl
{
    static TTNetworkTool *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 创建根路径
        NSURL *baseURL = [NSURL URLWithString:baseUrl];
        // 创建单例对象
        instance = [[self alloc] initWithBaseURL:baseURL];
        // 修改响应解析器能够解析的数据类型
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",nil];
    });
    return instance;
}

- (void)GET:(NSString *)URLString success:(void (^)(id responseObj))success failed:(void (^)(NSError *error))failed
{
    [self GET:URLString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 打印响应对象内容和类
        NSLog(@"\n%@\nLoadSuccess! responseObject = %@",responseObject,[responseObject class]);
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failed) {
            failed(error);
        }
    }];
}

#pragma mark - ======== 赋值属性 ========


@end
