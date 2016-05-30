//
//  TicketCell.h
//  528.FlightsDemo
//
//  Created by TianZhen on 16/5/30.
//  Copyright © 2016年 TianZhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TicketModel;

@interface TicketCell : UITableViewCell

/**
 * 机票数据模型
 */
@property (nonatomic,strong) TicketModel        *xTicketModel;

@end
