//
//  TZNetworkTool.h
//  315-networkPrc
//
//  Created by user on 16/3/15.
//  Copyright © 2016年 M&M. All rights reserved.
//

#import <AFNetworking.h>

@interface TTNetworkTool : AFHTTPSessionManager

/** 网络单例工具 */
+ (instancetype)sharedNetworkTool;

/** 带有根路径的 网络单例工具 */
+ (instancetype)sharedNetworkToolWithBaseUrl:(NSString *)baseUrl;

/**
 *  !请求文件数据方法!
 *
 *  @param URLString URL路径
 *  @param success   成功回调
 *  @param failed    失败回调
 */
- (void)GET:(NSString *)URLString success:(void (^)(id responseObj))success failed:(void (^)(NSError *error))failed;
@end
