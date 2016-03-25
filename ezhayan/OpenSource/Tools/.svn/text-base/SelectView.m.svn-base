//
//  SelectView.m
//  Huake
//
//  Created by bingjun_lt on 15/1/13.
//  Copyright (c) 2015年 BingJun. All rights reserved.
//

#import "SelectView.h"

@interface SelectView ()

@property (nonatomic) NSMutableArray *dataArray;
@property (nonatomic) UIColor *textColor;
@property (nonatomic) UIFont *textFont;
@property (nonatomic) NSArray *imageArray;
@property (nonatomic) UIColor *cellColor;

@end

@implementation SelectView

- (id)initWithFrame:(CGRect)frame withDataArray:(NSArray *)dataArray withTableViewFrame:(CGRect)tableViewFrame withTextColor:(UIColor *)textColor withTextFont:(UIFont *)textFont withImageArray:(NSArray *)imageArray tableColor:(UIColor *)tableColor
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.dataArray = [dataArray copy];//[[NSMutableArray alloc] initWithObjects:@"10",@"20",@"30",@"50",@"100",@"200", nil];
        self.textColor = textColor;
        self.textFont = textFont;
        self.imageArray = imageArray;
        self.cellColor = tableColor;
        
        UIControl *bgView = [[UIControl alloc] initWithFrame:frame];
        bgView.backgroundColor = [UIColor blackColor];
        bgView.alpha = 0.1;
        [bgView addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:bgView];
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:tableViewFrame];//CGRectMake(178, 160, 83, 180)];
        tableView.separatorColor = [UIColor lightGrayColor];
        if ([tableView respondsToSelector:@selector(separatorInset)]) {
            tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
        }
        tableView.backgroundColor = tableColor;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.layer.cornerRadius = 3;
        [self addSubview:tableView];
    }
    
    return self;
}

- (void)touchDown:(id)sender {
    [self removeFromSuperview];
    if (self.block != nil) {
        self.block();
    }
}

#pragma mark - table view

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellHeight != 0) {
        return self.cellHeight;
    }else {
        return 30;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *defaultCellID = @"DefaultCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultCellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:defaultCellID];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        //UIView *bgView = [UIView new];
        //bgView.backgroundColor = [UIColor colorWithRed:66/255.0 green:160/255.0 blue:94/255.0 alpha:1.0];
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"friend01.1_nav_btn_h"]];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[self.dataArray objectAtIndex:indexPath.row]];
    cell.textLabel.textColor = self.textColor;
    cell.textLabel.font = self.textFont;
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", self.imageArray[indexPath.row]]];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    cell.backgroundColor = self.cellColor;
//    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    cell.layer.borderWidth = 1;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_delegate selectOption:[self.dataArray objectAtIndex:indexPath.row] selectView:self];
    
    //[self removeFromSuperview];
}

@end
