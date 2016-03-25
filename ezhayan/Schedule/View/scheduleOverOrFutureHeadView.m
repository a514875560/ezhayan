//
//  scheduleOverOrFutureHeadView.m
//  ezhayan
//
//  Created by ChenFengbo on 16/2/18.
//  Copyright © 2016年 ChenFengbo. All rights reserved.
//

#import "scheduleOverOrFutureHeadView.h"

@interface scheduleOverOrFutureHeadView ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;

@end

@implementation scheduleOverOrFutureHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setModel:(scheduleOverOrFutureModel *)model
{
    _model = model;
    [self setMonthAndDay];
}

- (void)setMonthAndDay
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString:_model.day];
    [formatter setDateFormat:@"MM月"];
    _monthLabel.text = [formatter stringFromDate:date];
    [formatter setDateFormat:@"dd"];
    _dayLabel.text = [formatter stringFromDate:date];
}

@end
