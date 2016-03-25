//
//  scheduleOverOrFutureTableViewCell.m
//  ezhayan
//
//  Created by ChenFengbo on 16/2/18.
//  Copyright © 2016年 ChenFengbo. All rights reserved.
//

#import "scheduleOverOrFutureTableViewCell.h"

@interface scheduleOverOrFutureTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation scheduleOverOrFutureTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(targetScheduleListModel *)model
{
    _model = model;
    _contentLabel.text = model.name;
    [self setDaysAndTimes];
}

- (void)setDaysAndTimes
{
    NSDateFormatter *fromatter = [[NSDateFormatter alloc]init];
    [fromatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *star = [fromatter dateFromString:_model.start_time];
    NSDate *end = [fromatter dateFromString:_model.over_time];
    
    [fromatter setDateFormat:@"HH:mm"];
    NSString *starTime = [fromatter stringFromDate:star];
    NSString *endTime = [fromatter stringFromDate:end];
    self.timeLabel.text = [NSString stringWithFormat:@"%@--%@",starTime,endTime];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
