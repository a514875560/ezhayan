//
//  threeScheduleViewCtrl.m
//  ezhayan
//
//  Created by ChenFengbo on 15/11/3.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import "threeScheduleViewCtrl.h"
#import "scheduleTableView.h"
#import "scheduleDayView.h"
#import "FDCalendarItem.h"
#import "scheduleMonthView.h"
#import "targetScheduleListModel.h"
#import "scheduleFutureViewController.h"
#import "scheduleCurrentViewController.h"

#define Weekdays @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"]

@interface threeScheduleViewCtrl ()<UIScrollViewDelegate,FDCalendarItemDelegate>

@property (nonatomic, strong) UISegmentedControl *segmented;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) scheduleTableView *dayTableView;
@property (nonatomic, strong) scheduleTableView *monthTableView;
@property (nonatomic, strong) scheduleDayView *dayView;
@property (nonatomic, strong) UIView *weekDayView;
@property (nonatomic, strong) FDCalendarItem *calendar;
@property (nonatomic, strong) UIScrollView *monthView;

@end


@implementation threeScheduleViewCtrl

#pragma mark - life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"日程";
    self.view.backgroundColor = [UIUtils colorWithHexString:@"#edf2f1"];
    
    [self.view addSubview:self.segmented];
    
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.dayTableView];
    [self.scrollView addSubview:self.dayView];
    [self.scrollView addSubview:self.monthTableView];
    [self.scrollView addSubview:self.weekDayView];
    [self.scrollView addSubview:self.monthView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getScheduleDayData];
}

#pragma mark - getScheduleData
- (void)getScheduleDayData
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:date];
    [WXDataServer requestURL:@"ScheduleEvent/getDayScheduleList"
                  httpMethod:@"GET"
                      params:[@{@"md5getDayScheduleList":[UIUtils encodeToPercentEscapeString:[UIUtils TripleDES:[NSString stringWithFormat:@"%@:%@", dateTime,[Commtion shareCommtion].user.client_id] encryptOrDecrypt:kCCEncrypt DESKEY:KEY]]}mutableCopy]
                        file:nil
                     success:^(id data) {
                         if([[NSString stringWithFormat:@"%@",data[@"success"]] isEqualToString:@"1"]){
                             NSMutableArray *issueArr = [NSMutableArray array];
                             for (NSDictionary *dic in data[@"data"]) {
                                 targetScheduleListModel *model = [[targetScheduleListModel alloc] initWithJSONDic:dic];
                                 [issueArr addObject:model];
                             }
                             self.dayTableView.dataArray = issueArr;
                             self.monthTableView.dataArray = issueArr;
                         }
                         else
                         {
                             
                         }
                     }
                        fail:^(NSError *error) {
                            [SVProgressHUD showErrorWithStatus:@"链接错误"];
                            
                        }];
}

#pragma mark - didEvent
- (void)segmentChange:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex) {
        case 0:
            [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            break;
        
        case 1:
            [_scrollView setContentOffset:CGPointMake(kDeviceWidth, 0) animated:YES];
            break;
            
        default:
            [_scrollView setContentOffset:CGPointMake(kDeviceWidth * 2, 0) animated:YES];
            break;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    if (point.x <= kDeviceWidth / 2) {
        _segmented.selectedSegmentIndex = 0;
    }
    else if (point.x <= kDeviceWidth * 1.5 && point.x >= kDeviceWidth)
    {
        _segmented.selectedSegmentIndex = 1;
    }
    else
    {
        _segmented.selectedSegmentIndex = 2;
    }
}


#pragma mark - delegateAndDataSource
- (void)calendarItem:(FDCalendarItem *)item didSelectedDate:(NSDate *)date
{
    _calendar.date = date;
}

#pragma mark - getter
- (UISegmentedControl *)segmented
{
    if (_segmented == nil) {
        _segmented = [[UISegmentedControl alloc]initWithItems:@[@"日视图",@"周视图",@"月视图"]];
        _segmented.tintColor = [UIUtils colorWithHexString:@"#40b49a"];
        _segmented.selectedSegmentIndex = 0;
        [_segmented addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
        _segmented.frame = CGRectMake(kDeviceWidth / 2 - 130, 85, 261, 38);
    }
    return _segmented;
}

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _segmented.bottom, kDeviceWidth, KDeviceHeight - _segmented.bottom - 49)];
        _scrollView.contentSize = CGSizeMake(kDeviceWidth * 3, KDeviceHeight - _segmented.bottom - 49);
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (scheduleTableView *)dayTableView
{
    if (_dayTableView == nil) {
        _dayTableView = [[scheduleTableView alloc]initWithFrame:CGRectMake(0, 70, kDeviceWidth, _scrollView.frame.size.height - 70) style:UITableViewStyleGrouped];
    }
    return _dayTableView;
}

- (scheduleTableView *)monthTableView
{
    if (_monthTableView == nil) {
        _monthTableView = [[scheduleTableView alloc]initWithFrame:CGRectMake(kDeviceWidth, 95, kDeviceWidth, _scrollView.frame.size.height - 95) style:UITableViewStyleGrouped];
    }
    return _monthTableView;
}

- (scheduleDayView *)dayView
{
    if (_dayView == nil) {
        _dayView = [[[NSBundle mainBundle] loadNibNamed:@"scheduleDayView" owner:self options:nil] lastObject];
        _dayView.frame = CGRectMake(0, 25, kDeviceWidth, 25);
    }
    return _dayView;
}

- (UIView *)weekDayView
{
    if (_weekDayView == nil) {
        _weekDayView = [[UIView alloc]initWithFrame:CGRectMake(kDeviceWidth, 25, kDeviceWidth, 50)];
        NSInteger count = [Weekdays count];
        CGFloat offsetX = 5;
        for (int i = 0; i < count; i++) {
            UILabel *weekdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, 0, (kDeviceWidth - 10) / count, 20)];
            weekdayLabel.textAlignment = NSTextAlignmentCenter;
            weekdayLabel.font = [UIFont systemFontOfSize:13];
            weekdayLabel.text = Weekdays[i];
            
            if (i == 0 || i == count - 1) {
                weekdayLabel.textColor = [UIColor redColor];
            } else {
                weekdayLabel.textColor = [UIColor grayColor];
            }
            
            [_weekDayView addSubview:weekdayLabel];
            offsetX += weekdayLabel.frame.size.width;
        }
        
        [_weekDayView addSubview:self.calendar];
    }
    return _weekDayView;
}

- (FDCalendarItem *)calendar
{
    if (_calendar == nil) {
        _calendar = [[FDCalendarItem alloc]initWithCellNum:7 andCellWidth:33];
        CGRect frame = _calendar.frame;
        frame.origin.y = 10;
        _calendar.frame = frame;
        _calendar.delegate = self;
        _calendar.date = [NSDate date];
    }
    return _calendar;
}

- (UIScrollView *)monthView
{
    if (_monthView == nil) {
        scheduleMonthView *scheduleMonView = [[[NSBundle mainBundle] loadNibNamed:@"scheduleMonthView" owner:self options:nil] lastObject];
        
        scheduleMonView.didSuccess = ^{
            scheduleFutureViewController *future = [[scheduleFutureViewController alloc]init];
            future.isOverSchedule = YES;
            future.navigationItem.title = @"已完成日程";
            future.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:future animated:YES];
        };
        
        scheduleMonView.didWillDo = ^{
            scheduleFutureViewController *future = [[scheduleFutureViewController alloc]init];
            future.isOverSchedule = NO;
            future.navigationItem.title = @"未完成日程";
            future.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:future animated:YES];
        };
        
        scheduleMonView.didDoing = ^{
            scheduleCurrentViewController *current = [[scheduleCurrentViewController alloc]init];
            current.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:current animated:YES];
        };
        
        _monthView = [[UIScrollView alloc]initWithFrame:CGRectMake(kDeviceWidth * 2, 25, kDeviceWidth, KDeviceHeight - 25 - _segmented.bottom - 49)];
        _monthView.contentSize = CGSizeMake(kDeviceWidth, scheduleMonView.frame.size.height);
        _monthView.showsHorizontalScrollIndicator = NO;
        _monthView.showsVerticalScrollIndicator = NO;
        [_monthView addSubview:scheduleMonView];
    }
    return _monthView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
