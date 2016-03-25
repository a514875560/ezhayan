//
//  scheduleFutureViewController.m
//  ezhayan
//
//  Created by ChenFengbo on 16/2/18.
//  Copyright © 2016年 ChenFengbo. All rights reserved.
//

#import "scheduleFutureViewController.h"
#import "scheduleOverOrFutureTableViewCell.h"
#import "scheduleOverOrFutureHeadView.h"
#import "targetScheduleListModel.h"
#import "scheduleOverOrFutureModel.h"
#import "targetScheduleDetailViewController.h"

@interface scheduleFutureViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) UITableView *tableView;


@end

@implementation scheduleFutureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getOverOrFutureData];
}

#pragma mark - GetOverOrFutureData
- (void)getOverOrFutureData
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM"];
    NSString *dateTime = [formatter stringFromDate:date];
    
    NSString *urlStr;
    NSMutableDictionary *params;
    if (_isOverSchedule) {
        urlStr = @"ScheduleEvent/getMonthSchedulefisList";
        params = [@{@"md5getMonthSchedulefisList":[UIUtils encodeToPercentEscapeString:[UIUtils TripleDES:[NSString stringWithFormat:@"%@:%@", dateTime,[Commtion shareCommtion].user.client_id] encryptOrDecrypt:kCCEncrypt DESKEY:KEY]]}mutableCopy];
    }
    else
    {
        urlStr = @"ScheduleEvent/getMonthScheduleNofisList";
        params = [@{@"md5getMonthScheduleNofisList":[UIUtils encodeToPercentEscapeString:[UIUtils TripleDES:[NSString stringWithFormat:@"%@:%@", dateTime,[Commtion shareCommtion].user.client_id] encryptOrDecrypt:kCCEncrypt DESKEY:KEY]]}mutableCopy];
    }
    
    [WXDataServer requestURL:urlStr
                  httpMethod:@"GET"
                      params:params
                        file:nil
                     success:^(id data) {
                         if([[NSString stringWithFormat:@"%@",data[@"success"]] isEqualToString:@"1"]){
                             NSMutableArray *issueArr = [NSMutableArray array];
                             for (NSDictionary *dic in data[@"data"]) {
                                 scheduleOverOrFutureModel *scheduleModel = [[scheduleOverOrFutureModel alloc]initWithJSONDic:dic];
                                 NSMutableArray *modelArray = [NSMutableArray array];
                                 for (NSDictionary *modelDict in dic[@"resultMap"]) {
                                     targetScheduleListModel *model = [[targetScheduleListModel alloc] initWithJSONDic:modelDict];
                                     [modelArray addObject:model];
                                 }
                                 scheduleModel.resultMap = modelArray;
                                 [issueArr addObject:scheduleModel];
                             }
                             _dataSource = issueArr;
                             [_tableView reloadData];
                         }
                         else
                         {
                             [SVProgressHUD showInfoWithStatus:data[@"message"]];
                         }
                     }
                        fail:^(NSError *error) {
                            [SVProgressHUD showErrorWithStatus:@"链接错误"];
                            
                        }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    scheduleOverOrFutureModel *model = _dataSource[section];
    return model.resultMap.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    scheduleOverOrFutureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"overOrFutureCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    scheduleOverOrFutureModel *model = _dataSource[indexPath.section];
    targetScheduleListModel *sModel = model.resultMap[indexPath.row];
    cell.model = sModel;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    scheduleOverOrFutureHeadView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"overOrFutureHeadView"];
    scheduleOverOrFutureModel *model = _dataSource[section];
    headView.model = model;
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    scheduleOverOrFutureModel *model = _dataSource[indexPath.section];
    targetScheduleListModel *sModel = model.resultMap[indexPath.row];
    targetScheduleDetailViewController *scheduleDetail = [[targetScheduleDetailViewController alloc]init];
    scheduleDetail.scheduleModel = sModel;
    [self.navigationController pushViewController:scheduleDetail animated:YES];
}

#pragma mark - getter

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"scheduleOverOrFutureTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"overOrFutureCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"scheduleOverOrFutureHeadView" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"overOrFutureHeadView"];
    }
    return _tableView;
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
