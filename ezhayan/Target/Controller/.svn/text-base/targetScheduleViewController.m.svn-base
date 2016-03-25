//
//  targetScheduleViewController.m
//  ezhayan
//
//  Created by ChenFengbo on 16/2/16.
//  Copyright © 2016年 ChenFengbo. All rights reserved.
//

#import "targetScheduleViewController.h"
#import "targetScheduleTableViewCell.h"
#import "targetScheduleListModel.h"
#import "targetAddScheduleViewController.h"
#import "targetScheduleDetailViewController.h"

@interface targetScheduleViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation targetScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.targetScheduleName;
    [self.view addSubview:self.tableView];
    UIBarButtonItem *rightBut = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"object1_nav_jia"] style:UIBarButtonItemStylePlain target:self action:@selector(didRightBut:)];
    self.navigationItem.rightBarButtonItem = rightBut;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self getTargetScheduleDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getDataSource
- (void)getTargetScheduleDataSource
{
    [WXDataServer requestURL:@"ScheduleEvent/getScheduleRealList"
                  httpMethod:@"GET"
                      params:[@{@"md5getScheduleRealList":[UIUtils encodeToPercentEscapeString:[UIUtils TripleDES:[NSString stringWithFormat:@"%@", self.targetScheduleId] encryptOrDecrypt:kCCEncrypt DESKEY:KEY]]}mutableCopy]
                        file:nil
                     success:^(id data) {
                         if([[NSString stringWithFormat:@"%@",data[@"success"]] isEqualToString:@"1"]){
                             NSMutableArray *issueArr = [NSMutableArray array];
                             for (NSDictionary *dic in data[@"data"]) {
                                 targetScheduleListModel *model = [[targetScheduleListModel alloc] initWithJSONDic:dic];
                                 [issueArr addObject:model];
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

- (void)deleteData:(NSString *)detail_id;
{
    [WXDataServer requestURL:@"ScheduleEvent/deleteSchedule"
                  httpMethod:@"GET"
                      params:[@{@"md5deleteSchedule":[UIUtils encodeToPercentEscapeString:[UIUtils TripleDES:[NSString stringWithFormat:@"%@",detail_id] encryptOrDecrypt:kCCEncrypt DESKEY:KEY]]} mutableCopy]
                        file:nil
                     success:^(id data) {
                         if([[NSString stringWithFormat:@"%@",data[@"success"]] isEqualToString:@"1"]){
                             
                         }else {
                             [SVProgressHUD showInfoWithStatus:data[@"message"]];
                         }
                         
                     }
                        fail:^(NSError *error) {
                            [SVProgressHUD showErrorWithStatus:@"链接错误"];
                        }];
    
}

#pragma mark - didEvent

- (void)didRightBut:(UIBarButtonItem *)sender
{
    targetAddScheduleViewController *addSchedule = [[targetAddScheduleViewController alloc]init];
    addSchedule.objId = self.targetScheduleId;
    addSchedule.objName = self.targetScheduleName;
    [self.navigationController pushViewController:addSchedule animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    targetScheduleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"targetScheduleCell" forIndexPath:indexPath];
    
    targetScheduleListModel *model = _dataSource[indexPath.row];
    cell.model = model;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 1.删除数据
        targetScheduleListModel *model = _dataSource[indexPath.row];
        [self deleteData:model.sr_id];
        [_dataSource removeObjectAtIndex:indexPath.row];
        
        // 2.更新UITableView UI界面
        //        [tableView reloadData];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    targetScheduleDetailViewController *detailCtrl = [[targetScheduleDetailViewController alloc]init];
    targetScheduleListModel *model = _dataSource[indexPath.row];
    detailCtrl.objName = self.targetScheduleName;
    detailCtrl.scheduleModel = model;
    [self.navigationController pushViewController:detailCtrl animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - getter

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        [_tableView registerNib:[UINib nibWithNibName:@"targetScheduleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"targetScheduleCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
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
