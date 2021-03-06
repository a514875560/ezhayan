//
//  myChengJiuViewController.m
//  ezhayan
//
//  Created by ChenFengbo on 15/11/9.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import "myChengJiuViewController.h"
#import "chengJiuTableViewCell.h"

@interface myChengJiuViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *dataSource;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation myChengJiuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return _dataSource.count;
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    chengJiuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chengjiuCell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.img.image = [UIImage imageNamed:@"home4.5_ico1"];
    }
    else
    {
        cell.img.image = [UIImage imageNamed:@"home4.4_ico1"];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 69;
}

#pragma mark - getter

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.allowsSelection = NO;
        [_tableView registerNib:[UINib nibWithNibName:@"chengJiuTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"chengjiuCell"];
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
