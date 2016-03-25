//
//  targetScheduleTableViewCell.m
//  ezhayan
//
//  Created by ChenFengbo on 16/2/16.
//  Copyright © 2016年 ChenFengbo. All rights reserved.
//

#import "targetScheduleTableViewCell.h"

@interface targetScheduleTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *times;
@property (weak, nonatomic) IBOutlet UILabel *days;
@property (weak, nonatomic) IBOutlet UILabel *content;


@end

@implementation targetScheduleTableViewCell


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void)setModel:(targetScheduleListModel *)model
//{
//    self.model = model;
//    self.content.text = model.content;
//    [self setDaysAndTimes];
//}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.content.text = _model.content;
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
    self.times.text = [NSString stringWithFormat:@"%@--%@",starTime,endTime];
    
    [fromatter setDateFormat:@"MM月dd"];
    NSString *starDay = [fromatter stringFromDate:star];
    NSString *endDay = [fromatter stringFromDate:end];
    self.days.text = [NSString stringWithFormat:@"%@至%@",starDay,endDay];
}

@end
