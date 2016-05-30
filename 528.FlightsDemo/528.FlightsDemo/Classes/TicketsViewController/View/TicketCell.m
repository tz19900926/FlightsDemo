//
//  TicketCell.m
//  528.FlightsDemo
//
//  Created by TianZhen on 16/5/30.
//  Copyright © 2016年 TianZhen. All rights reserved.
//
#import "TicketModel.h"
#import "TicketCell.h"

@interface TicketCell ()
/**
 * 起飞时间文本
 */
@property (weak, nonatomic) IBOutlet UILabel    * xStartTimeLabel;

/**
 * 起飞机场文本
 */
@property (weak, nonatomic) IBOutlet UILabel    * xStartPlaceLabel;

/**
 * 航空公司和飞机类型文本
 */
@property (weak, nonatomic) IBOutlet UILabel    * xCompanyAndTypeLabel;

/**
 * 到达时间文本
 */
@property (weak, nonatomic) IBOutlet UILabel    * xArriveTimeLabel;

/**
 * 到达机场文本
 */
@property (weak, nonatomic) IBOutlet UILabel    * xArrivePlaceLabel;

/**
 * 价格文本
 */
@property (weak, nonatomic) IBOutlet UILabel    * xPriceLabel;

@end

@implementation TicketCell

- (void)setXTicketModel:(TicketModel *)xTicketModel
{
    _xTicketModel = xTicketModel;
    
    self.xStartTimeLabel.text       =  xTicketModel.xStartTime;
    self.xStartPlaceLabel.text      =  xTicketModel.xStartPlace;
    self.xArriveTimeLabel.text      =  xTicketModel.xArriveTime;
    self.xArrivePlaceLabel.text     =  xTicketModel.xArrivePlace;
    self.xPriceLabel.text           =  xTicketModel.xPrice;
    self.xCompanyAndTypeLabel.text  =  [NSString stringWithFormat:@"%@ %@",xTicketModel.xCompany,xTicketModel.xType];
}

@end
