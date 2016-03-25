//
//  didEndViewController.m
//  ezhayan
//
//  Created by ChenFengbo on 15/10/30.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import "didEndViewController.h"
#import "toDoHeadView.h"
#import "didEndTableViewCell.h"

@interface didEndViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _currentClickIndex;
    BOOL _isOpenCell;
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation didEndViewController

#pragma mark - life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"已处理待办";
    
    _currentClickIndex = -1;
    _isOpenCell = NO;
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getDidFinishData];
}

#pragma mark - getDidFinishData
- (void)getDidFinishData
{
    [WXDataServer requestURL:@"TodoEvent/getFisTodoData"
                  httpMethod:@"GET"
                      params:[@{@"md5getFisTodoData":[UIUtils encodeToPercentEscapeString:[UIUtils TripleDES:[NSString stringWithFormat:@"%@",[Commtion shareCommtion].user.client_id] encryptOrDecrypt:kCCEncrypt DESKEY:KEY]],
                                @"td_id":self.class_id}mutableCopy]
                        file:nil
                     success:^(id data) {
                         if([[NSString stringWithFormat:@"%@",data[@"success"]] isEqualToString:@"1"]){
                             NSMutableArray *issueArr = [NSMutableArray array];
                             for (NSDictionary *dic in data[@"data"]) {
                                 todoWilldoListModel *model = [[todoWilldoListModel alloc] initWithJSONDic:dic];
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

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == _currentClickIndex) {
        if (_isOpenCell == YES) {
            return 1;
        }
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    didEndTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"didEndCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    todoWilldoListModel *model = _dataSource[indexPath.section];
    cell.model = model;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    toDoHeadView *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headCell"];
    //    cell.backgroundColor = [UIColor whiteColor];
    todoWilldoListModel *model = _dataSource[section];
    cell.model = model;
    cell.didOpen = ^(BOOL open)
    {
        if (section == _currentClickIndex) {
            _isOpenCell = !_isOpenCell;
        }else{
            _isOpenCell = YES;
        }
        _currentClickIndex = section;
        // 创建刷新的组
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:section];
        // NSIndexPath 单元格
        // NSindexSet  组
        
        // 刷新指定组
        [tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
    };
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    if (indexPath.row == _currentClickIndex) {
//        _isOpenCell = !_isOpenCell;
//    }else{
//        _isOpenCell = YES;
//    }
//    
//    _currentClickIndex = indexPath.row;
//    
//    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 73;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == _currentClickIndex) {
        if (_isOpenCell == YES) {
            return UITableViewAutomaticDimension;
        }
        return 0.1;
    }
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

#pragma mark - getter
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        //        _tableView.estimatedRowHeight = 44;
        //        _tableView.rowHeight = UITableViewAutomaticDimension;
        
        [_tableView registerNib:[UINib nibWithNibName:@"didEndTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"didEndCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"toDoHeadView" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"headCell"];
        
        return _tableView;
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
