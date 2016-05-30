//
//  TicketsViewController.h
//  528.FlightsDemo
//
//  Created by TianZhen on 16/5/28.
//  Copyright © 2016年 TianZhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TicketModel;

@interface TicketsViewController : UITableViewController

/**
 * 机票数据模型数组
 */
@property (nonatomic,strong) NSArray        *xTicketsArray;

@end
