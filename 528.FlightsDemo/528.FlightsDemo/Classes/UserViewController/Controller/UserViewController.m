//
//  UserViewController.m
//  528.FlightsDemo
//
//  Created by TianZhen on 16/5/28.
//  Copyright © 2016年 TianZhen. All rights reserved.
//

/*
 － 使用 Storyboard 和 Auto Layout 布局, 创建最低部署版本 iOS 9 的工程。
 － http://touch.qunar.com/h5/flight/flightlist 分析这个网址，找出它如何查询机票
 
 你的demo将使用上述网页获取数据，找到一个方法在oc和js之间相互传递数据。以便从网页中提取关键信息。
 
 设计一个查询界面让用户输入出发地，返回地，时间等查询所需的数据
 设计一个机票展示界面显示返回机票信息。
 */

#import "UserViewController.h"
#import "TicketsViewController.h"
#import <SVProgressHUD.h>

// 字符串处理
#import "NSString+EncodeString.h"
#import "NSString+Today.h"

// 机票模型
#import "TicketModel.h"

#define URLObjBase [NSURL URLWithString:@"http://touch.qunar.com/h5/flight/flightlist"]

@interface UserViewController () <UIWebViewDelegate>
/**
 * 单程/往返
 */
@property (weak, nonatomic) IBOutlet UISegmentedControl  * xWayOfPath;

/**
 * 出发地
 */
@property (weak, nonatomic) IBOutlet UITextField         * xStartFrom;

/**
 * 到达城市
 */
@property (weak, nonatomic) IBOutlet UITextField         * xDestination;

/**
 * 出发日期
 */
@property (nonatomic,copy) NSString                      * xStartDate;

/**
 * 出发日期按钮
 */
@property (weak, nonatomic) IBOutlet UIButton            * xStartDateButton;

/**
 * 日期选择器
 */
@property (nonatomic,strong) UIDatePicker                * xDatePicker;

/**
 * webView
 */
@property (nonatomic,strong) UIWebView                   * xWebView;
@end

@implementation UserViewController

#pragma mark -   WebView Delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 路径
    NSLog(@"\n%@",request.URL.absoluteString);
    
    // 读取HTML
    NSString *htmlString = [NSString stringWithContentsOfURL: request.URL encoding:NSUTF8StringEncoding error:nil];  //htmlString是html网页的地址
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSMutableArray  * ticketsArray = [NSMutableArray array];
    // 获取10条数据
    for (int i =0 ; i<9; i++) {

        // 出发时间
        NSString *startTime = [self method:@"from-time time-font" count:i webView: webView];
        
        // 出发地点
        NSString *startPlace = [self method:@"from-place ellipsis" count:i webView: webView];
        
        // 降落时间
        NSString *arriveTime = [self method:@"to-time time-font" count:i webView: webView];
        
        // 降落地点
        NSString *arrivePlace = [self method:@"to-place ellipsis" count:i webView:webView];
        
        // 航空公司
        NSString *company = [self method:@"company1 ellipsis" count:i webView: webView];
        // 型号
        NSString *type = [self method:@"company2 ellipsis" count:i webView: webView];
        
        // 价格  // !*? ddv1adbm5dscv7dq 价格应该是做了处理，获取不到真实数据
        NSString *price = [self method:@"price" count:i webView: webView];
        
        // 创建模型
        TicketModel     * ticketModel =  [[TicketModel alloc] initWithDict: @{
                              @"xStartTime"  : startTime,
                              @"xStartPlace" : startPlace,
                              @"xArriveTime" : arriveTime,
                              @"xArrivePlace": arrivePlace,
                              @"xCompany"    : company,
                              @"xType"       : type,
                              @"xPrice"      : price
                             }];
        [ticketsArray addObject: ticketModel];
        
        NSLog(@"\n%@,%@,%@,%@,%@,%@,%@",startTime,startPlace,arriveTime,arrivePlace,company,type,price);
    }
    // 将数据赋值给展示界面并跳转
    [self pushToTicketsViewController: ticketsArray];
}

// 跳转到展示机票界面
- (void)pushToTicketsViewController:(NSArray *)ticketsArray
{
    // 拿到控制器
    TicketsViewController *ticktsViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ticketsviewcontroller"];
    // 赋值模型数组
    ticktsViewController.xTicketsArray          = ticketsArray;
    // 跳转
    [self.navigationController pushViewController:ticktsViewController animated:YES];
}

// 读取JS数据
- (NSString *)method:(NSString *)string count:(int)i webView:(UIWebView *)webView
{
    NSString *method = [NSString stringWithFormat:@"document.getElementsByClassName('%@')[%d].innerHTML",string,i];
    NSString *result =  [webView stringByEvaluatingJavaScriptFromString: method];

    return result;
}

#pragma mark -   生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 显示今日日期
    [self.xStartDateButton setTitle: [NSString today] forState:UIControlStateNormal];
    // 记录出发日期
    self.xStartDate =  [NSString today];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 停止编辑
    [self.view endEditing:YES];
    // 收回日期选择器
    [UIView animateWithDuration:0.3 animations:^{
        self.xDatePicker.frame  =  CGRectMake(0, [UIScreen mainScreen].bounds.size.height, 0, 0);
    }];
}

#pragma mark -   按钮点击事件
// 搜索
- (IBAction)Search {
    
    if (self.xWayOfPath.selectedSegmentIndex!=0) {
        [SVProgressHUD showErrorWithStatus:@"只做了单程哦亲.."];
        return;
    }
    
    // 交互遮罩
    [SVProgressHUD show];
    
    // 拿到出发地和目的地
    NSString *startFrom     =  self.xStartFrom.text.length==0? self.xStartFrom.placeholder : self.xStartFrom.text;
    NSString *destination   =  self.xDestination.text.length==0? self.xDestination.placeholder : self.xDestination.text;
    
    // 单程0、往返1
    NSString *way           =  self.xWayOfPath.selectedSegmentIndex==0? @"oneWay":@"往返";
    
    NSLog(@"\n%@\n出发地: %@\n目的地: %@\n出发日期: %@\n",way,startFrom,destination,self.xStartDate);
    
    // 拼接URL
    NSString *URL = [NSString stringWithFormat:@"http://touch.qunar.com/h5/flight/flightlist?startCity=%@&startCode=XMN&destCity=%@&destCode=&startDate=%@&backDate=&flightType=oneWay",[startFrom URLEncodedString],[destination URLEncodedString],self.xStartDate];
    
    // webView 加载
    [self.xWebView loadRequest:[NSURLRequest requestWithURL: [NSURL URLWithString: URL]]];
}

// 交换地点
- (IBAction)PlaceChange {
    // 拿到出发地和到达地
    if (self.xStartFrom.text.length != 0 && self.xDestination.text.length != 0) {
    
        // 交换文本
        NSString * string = self.xStartFrom.text;
        self.xStartFrom.text = self.xDestination.text;
        self.xDestination.text = string;
    }else
    {
        NSString * string = self.xStartFrom.placeholder;
        self.xStartFrom.placeholder = self.xDestination.placeholder;
        self.xDestination.placeholder = string;
    }
}

// 弹出选择日期
- (IBAction)DatePicker {
    
    // 添加日期选择器
    [self.view addSubview: self.xDatePicker];
    
    // Frame
    CGFloat dpX = 0;
    CGFloat dpH = 168;
    CGFloat dpW = self.view.frame.size.width;
    CGFloat dpY = self.view.frame.size.height - dpH;
    // 动画弹出
    [UIView animateWithDuration:0.3f animations:^{
        self.xDatePicker.frame  = CGRectMake(dpX, dpY, dpW, dpH);
    }];
}

#pragma mark -   监听日期改变事件
// 监听日期改变事件
- (void)dateValueChanged:(UIDatePicker *)datePicker {

    // 获得当前显示的时间
    NSDate *date = datePicker.date;
    
    // 创建日期格式化对象
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    // 设置时间格式
    fmt.dateFormat  =@"yyyy-MM-dd";
    
    // 将日期转换成字符串
    NSString *timeStr =[fmt stringFromDate:date];
    
    // 记录日期
    self.xStartDate =  timeStr;
    
    // 显示日期
    [self.xStartDateButton setTitle: timeStr forState:UIControlStateNormal];
}

#pragma mark -   懒加载
- (UIDatePicker *)xDatePicker {
    
    if (_xDatePicker == nil) {
        // 创建日期选择器
        _xDatePicker = [[UIDatePicker alloc] init];
        
        // 设置时区
        _xDatePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
        
        // 设置时间模式
        _xDatePicker.datePickerMode = UIDatePickerModeDate;
        
        // 设置最小选择时间
        _xDatePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:0];
        
        // 设置最大选择时间
        _xDatePicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:(365 * 1 * 24 * 3600)];
        
        // 设置时间间隔
        _xDatePicker.minuteInterval = 2;
        
        // 背景色
        _xDatePicker.backgroundColor = [UIColor orangeColor];
        
        // 监听时间选择器值改变时间
        [_xDatePicker addTarget:self action:@selector(dateValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        // Frame
        _xDatePicker.frame  =  CGRectMake(0, [UIScreen mainScreen].bounds.size.height, 0, 0);
    }
    return _xDatePicker;
}

- (UIWebView *)xWebView
{
    if (!_xWebView) {
        _xWebView = [[UIWebView alloc] init];
        _xWebView.delegate = self;
    }
    return _xWebView;
}
@end
