//
//  settimgViewController.m
//  ezhayan
//
//  Created by ChenFengbo on 16/1/12.
//  Copyright © 2016年 ChenFengbo. All rights reserved.
//

#import "settimgViewController.h"

@interface settimgViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataSource;

@end

@implementation settimgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"设置";
    
    _dataSource = @[@[@"日期显示格式"],@[@"提示音",@"消息推送"],@[@"关于一眨眼",@"帮助与反馈",@"评分"],@[@"清除混存",@"当前版本"]];
    
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settimgCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"settingCell"];
    }
    
    cell.textLabel.text = _dataSource[indexPath.section][indexPath.row];
    
    switch (indexPath.section) {
        case 0:
            cell.detailTextLabel.text = @"10月8日，2015 星期四";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
            case 1:
            if (indexPath.row) {
                UISwitch *sw = [[UISwitch alloc]initWithFrame:CGRectMake(kDeviceWidth - 66, 6, 51, 31)];
                [cell.contentView addSubview:sw];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            else
            {
                
            }
            break;
            
            case 2:
            if (indexPath.row == 0) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            else if (indexPath.row == 1)
            {
                
            }
            else
            {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            break;
        default:
            if (indexPath.row) {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"V%@",[NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;

            }
            else
            {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"0.0M"];
            }
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 16;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 4;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
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
