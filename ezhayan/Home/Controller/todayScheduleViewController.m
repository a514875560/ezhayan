//
//  todayScheduleViewController.m
//  ezhayan
//
//  Created by ChenFengbo on 15/11/10.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import "todayScheduleViewController.h"
#import "scheduleHomeHeadView.h"
#import "scheduleHomeLeftCell.h"
#import "scheduleHomeRightCell.h"
#import "threeScheduleViewCtrl.h"

#define headViewHeight(x) x * 266 / 375


@interface todayScheduleViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) scheduleHomeHeadView *headView;

@end

@implementation todayScheduleViewController

#pragma mark - life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = appTableviewBgColor;
    NSDate *senddate = [NSDate date];
    
    NSDateFormatter  *dateformatter = [[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"MM月dd日 YYYY"];
    
    NSString *locationString = [dateformatter stringFromDate:senddate];
    self.title = locationString;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.headView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2) {
        
        scheduleHomeRightCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rightCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        scheduleHomeLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 2) {
            cell.finshImg.image = [UIImage imageNamed:@"schedule3_content_ico1h"];
            cell.content.textColor = [UIUtils colorWithHexString:@"#e23c29"];
            cell.time.textColor = [UIUtils colorWithHexString:@"#e23c29"];
            cell.contentView.backgroundColor = [UIUtils colorWithHexString:@"#f3f3f3"];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    threeScheduleViewCtrl *scheduleView = [[threeScheduleViewCtrl alloc]init];
    scheduleView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:scheduleView animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

#pragma mark - getter
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, headViewHeight(kDeviceWidth) + 64, kDeviceWidth, KDeviceHeight - headViewHeight(kDeviceWidth) - 64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 54;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [_tableView registerNib:[UINib nibWithNibName:@"scheduleHomeLeftCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"leftCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"scheduleHomeRightCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"rightCell"];
    }
    return _tableView;
}

- (scheduleHomeHeadView *)headView
{
    if (_headView == nil) {
        _headView = [[[NSBundle mainBundle] loadNibNamed:@"scheduleHomeHeadView" owner:self options:nil] lastObject];
        _headView.frame = CGRectMake(0, 64, kDeviceWidth, headViewHeight(kDeviceWidth));
        
    }
    return _headView;
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
