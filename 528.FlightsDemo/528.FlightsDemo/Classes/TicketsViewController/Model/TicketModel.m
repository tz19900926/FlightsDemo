//
//  TicketModel.m
//  528.FlightsDemo
//
//  Created by TianZhen on 16/5/30.
//  Copyright © 2016年 TianZhen. All rights reserved.
//

#import "TicketModel.h"

@implementation TicketModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary: dict];
    }
    return self;
}


@end
