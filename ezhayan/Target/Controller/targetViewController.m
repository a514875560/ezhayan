//
//  targetViewController.m
//  ezhayan
//
//  Created by ChenFengbo on 15/10/21.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import "targetViewController.h"
#import "targetTableViewCell.h"
#import "addNewTargetViewController.h"
#import "newTargetViewController.h"
#import "targetScheduleViewController.h"
#import "targetListModel.h"

@interface targetViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation targetViewController

#pragma mark - life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (self.targetName) {
        self.navigationItem.title = self.targetName;
    }
    else
    {
        self.navigationItem.title = @"我的目标";
    }
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *rightBut = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"object1_nav_jia"] style:UIBarButtonItemStylePlain target:self action:@selector(didRightBut:)];
    self.navigationItem.rightBarButtonItem = rightBut;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getDataSource];
}

- (void)getDataSource
{
    NSMutableDictionary *params;
    if (self.objId) {
        params = [@{@"md5getObjectiveList":[UIUtils encodeToPercentEscapeString:[UIUtils TripleDES:[NSString stringWithFormat:@"%@", [Commtion shareCommtion].user.client_id] encryptOrDecrypt:kCCEncrypt DESKEY:KEY]],
                    @"objective_id":self.objId}mutableCopy];
    }
    else
    {
        params = [@{@"md5getObjectiveList":[UIUtils encodeToPercentEscapeString:[UIUtils TripleDES:[NSString stringWithFormat:@"%@", [Commtion shareCommtion].user.client_id] encryptOrDecrypt:kCCEncrypt DESKEY:KEY]],
                    @"objective_id":@""}mutableCopy];
    }
    [WXDataServer requestURL:@"ObjectiveEvent/getObjectiveList"
                  httpMethod:@"GET"
                      params:params
                        file:nil
                     success:^(id data) {
                         if([[NSString stringWithFormat:@"%@",data[@"success"]] isEqualToString:@"1"]){
                             NSMutableArray *issueArr = [NSMutableArray array];
                             for (NSDictionary *dic in data[@"data"]) {
                                 targetListModel *model = [[targetListModel alloc] initWithJSONDic:dic];
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
    [WXDataServer requestURL:@"ObjectiveEvent/deleteObjective"
                  httpMethod:@"GET"
                      params:[@{@"md5deleteObjective":[UIUtils encodeToPercentEscapeString:[UIUtils TripleDES:[NSString stringWithFormat:@"%@",detail_id] encryptOrDecrypt:kCCEncrypt DESKEY:KEY]]} mutableCopy]
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
    newTargetViewController *newTarget = [[newTargetViewController alloc]init];
    if (self.objId) {
        newTarget.objId = self.objId;
    }
    else
    {
        newTarget.objId = @"0";
    }
    newTarget.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:newTarget animated:YES];
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
    targetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"targetCell" forIndexPath:indexPath];
    targetListModel *model = _dataSource[indexPath.row];
    cell.model = model;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *test1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"粘贴" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"粘贴");
    }];
    test1.backgroundColor = [UIUtils colorWithHexString:@"#d4d4d4"];

    UITableViewRowAction *test2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        [self tableView:tableView commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:indexPath];
    }];
    test2.backgroundColor = [UIColor redColor];

    return @[test2,test1];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 1.删除数据
        targetListModel *model = _dataSource[indexPath.row];
        [self deleteData:model.objective_id];
        [_dataSource removeObjectAtIndex:indexPath.row];
        
        // 2.更新UITableView UI界面
        //        [tableView reloadData];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    targetListModel *model = _dataSource[indexPath.row];
    if ([model.objnum integerValue]) {
        targetViewController *target = [[targetViewController alloc]init];
        target.targetName = model.name;
        target.objId = model.objective_id;
        target.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:target animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
    if ([model.schedulenum integerValue]) {
        targetScheduleViewController *targetSchedule = [[targetScheduleViewController alloc]init];
        targetSchedule.targetScheduleId = model.objective_id;
        targetSchedule.targetScheduleName = model.name;
        targetSchedule.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:targetSchedule animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
    addNewTargetViewController *newTarget = [[addNewTargetViewController alloc]init];
    newTarget.objId = model.objective_id;
    newTarget.objName = model.name;
    newTarget.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:newTarget animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - getter

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = appTableviewBgColor;
        [_tableView registerNib:[UINib nibWithNibName:@"targetTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"targetCell"];
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
