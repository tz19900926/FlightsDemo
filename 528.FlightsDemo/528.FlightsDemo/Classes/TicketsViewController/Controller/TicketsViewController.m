//
//  TicketsViewController.m
//  528.FlightsDemo
//
//  Created by TianZhen on 16/5/28.
//  Copyright © 2016年 TianZhen. All rights reserved.
//
#import <SVProgressHUD.h>
#import "TicketsViewController.h"
#import "TicketCell.h"

@interface TicketsViewController ()

@end

@implementation TicketsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [SVProgressHUD dismiss];
    
    // 添加手势
    UISwipeGestureRecognizer *pan = [[UISwipeGestureRecognizer alloc] initWithTarget: self action:@selector(back)];
    [self.view addGestureRecognizer:pan];
}

- (void)back
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.xTicketsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TicketCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ticketcell" forIndexPath:indexPath];
    
    cell.xTicketModel   = self.xTicketsArray[indexPath.row];
    
    return cell;
}

#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
