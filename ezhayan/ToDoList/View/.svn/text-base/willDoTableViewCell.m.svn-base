//
//  willDoTableViewCell.m
//  ezhayan
//
//  Created by ChenFengbo on 15/10/29.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import "willDoTableViewCell.h"

@interface willDoTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *fromTime;
@property (weak, nonatomic) IBOutlet UILabel *starTime;


@end

@implementation willDoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(todoWilldoListModel *)model
{
    _model = model;
    _content.text = [NSString stringWithFormat:@"内容描述：%@",model.content];
    [self setTimeLabel];
}

- (void)setTimeLabel
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *sendTime = [formatter dateFromString:_model.send_time];
    NSDate *handleTime = [formatter dateFromString:_model.handle_time];
    
    [formatter setDateFormat:@"MM-dd HH:mm"];
    _fromTime.text = [formatter stringFromDate:sendTime];
    _starTime.text = [formatter stringFromDate:handleTime];
}

- (IBAction)doNow:(UIButton *)sender {
    
}

- (IBAction)toTarget:(UIButton *)sender {
    
}

- (IBAction)toSchedule:(UIButton *)sender {
    
}

- (IBAction)deleteBut:(UIButton *)sender {
    
}

@end
