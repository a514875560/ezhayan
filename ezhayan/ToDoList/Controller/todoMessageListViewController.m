//
//  todoMessageListViewController.m
//  ezhayan
//
//  Created by ChenFengbo on 16/2/22.
//  Copyright © 2016年 ChenFengbo. All rights reserved.
//

#import "todoMessageListViewController.h"

@interface todoMessageListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSDictionary *dataDict;

@end

@implementation todoMessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"待办";
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getData];
}

#pragma mark - getData

- (void)getData
{
    [WXDataServer requestURL:@"TodoEvent/getTodoEveryCount"
                  httpMethod:@"GET"
                      params:[@{@"md5getTodoEveryCount":[UIUtils encodeToPercentEscapeString:[UIUtils TripleDES:[NSString stringWithFormat:@"%@",[Commtion shareCommtion].user.client_id] encryptOrDecrypt:kCCEncrypt DESKEY:KEY]]}mutableCopy]
                        file:nil
                     success:^(id data) {
                         if([[NSString stringWithFormat:@"%@",data[@"success"]] isEqualToString:@"1"]){
                             
                             _dataDict = data[@"data"];
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
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"todoMessageListCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"todoMessageListCell"];
    }
    
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"todo_cdh_ico%ld",indexPath.row + 1]];
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"新待办消息";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",_dataDict[@"noFisListCount"]];
            break;
        case 1:
            cell.textLabel.text = @"处理历史";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",_dataDict[@"fisListCount"]];
            break;
        default:
            cell.textLabel.text = @"发送历史";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",_dataDict[@"sendListCount"]];
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - getter

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
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
