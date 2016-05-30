//
//  NSString+Today.m
//  528.FlightsDemo
//
//  Created by TianZhen on 16/5/30.
//  Copyright © 2016年 TianZhen. All rights reserved.
//

#import "NSString+Today.h"

@implementation NSString (Today)
+ (NSString *)today
{
    // 获得当前显示的时间
    NSDate *date = [NSDate date];
    
    // 创建日期格式化对象
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    // 设置时间格式
    fmt.dateFormat  =@"yyyy-MM-dd";
    
    // 将日期转换成字符串
    return [fmt stringFromDate:date];
}
@end
