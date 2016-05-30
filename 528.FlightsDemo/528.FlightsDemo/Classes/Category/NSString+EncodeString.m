//
//  NSString+EncodeString.m
//  528.FlightsDemo
//
//  Created by TianZhen on 16/5/30.
//  Copyright © 2016年 TianZhen. All rights reserved.
//

#import "NSString+EncodeString.h"

@implementation NSString (EncodeString)

// 中文转码
- (NSString *)URLEncodedString
{
    //    NSString* encodedString = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                                    (CFStringRef)self,
                                                                                                    (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                                                                    NULL,
                                                                                                    kCFStringEncodingUTF8));
    return encodedString;
}

@end
