//
//  scheduleTableView.m
//  ezhayan
//
//  Created by ChenFengbo on 15/11/2.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import "scheduleTableView.h"
#import "scheduleCell.h"
#import "scheduleHeadView.h"
#import "scheduleFootView.h"
#import "targetScheduleListModel.h"

@interface scheduleTableView ()
{
    NSInteger _currentClickIndex;
    BOOL _isOpenCell;
}


@end

@implementation scheduleTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [self reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        _currentClickIndex = -1;
        _isOpenCell = NO;
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerNib:[UINib nibWithNibName:@"scheduleCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"scheduleCell"];
        [self registerNib:[UINib nibWithNibName:@"scheduleHeadView" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"headView"];
        [self registerNib:[UINib nibWithNibName:@"scheduleFootView" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"footView"];
    }
    return self;
}

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
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scheduleCell" forIndexPath:indexPath];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    scheduleHeadView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headView"];
    
    targetScheduleListModel *model = _dataArray[section];
    headView.model = model;
    
    headView.didOpen = ^(BOOL open)
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
    return headView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    scheduleFootView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footView"];
    return footView;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == _currentClickIndex) {
        if (_isOpenCell == YES) {
            //            _currentClickIndex = indexPath.section;
            return UITableViewAutomaticDimension;
        }
        return CGFLOAT_MIN;
    }
    return CGFLOAT_MIN;
}

@end
