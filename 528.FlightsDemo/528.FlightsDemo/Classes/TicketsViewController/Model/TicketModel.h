//
//  TicketModel.h
//  528.FlightsDemo
//
//  Created by TianZhen on 16/5/30.
//  Copyright © 2016年 TianZhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TicketModel : NSObject

/** 起飞时间 */
@property (nonatomic,copy) NSString             * xStartTime;

/** 起飞机场 */
@property (nonatomic,copy) NSString             * xStartPlace;

/** 到达时间 */
@property (nonatomic,copy) NSString             * xArriveTime;

/** 到达机场 */
@property (nonatomic,copy) NSString             * xArrivePlace;

/** 航空公司 */
@property (nonatomic,copy) NSString             * xCompany;

/** 飞机类型 */
@property (nonatomic,copy) NSString             * xType;

/** 价格 */
@property (nonatomic,copy) NSString             * xPrice;


- (instancetype)initWithDict:(NSDictionary *)dict;
@end
