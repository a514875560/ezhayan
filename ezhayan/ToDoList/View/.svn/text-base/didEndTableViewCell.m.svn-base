//
//  didEndTableViewCell.m
//  ezhayan
//
//  Created by ChenFengbo on 15/10/29.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import "didEndTableViewCell.h"

@interface didEndTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end

@implementation didEndTableViewCell

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
//    NSDate *sendTime = [formatter dateFromString:_model.send_time];
    NSDate *handleTime = [formatter dateFromString:_model.handle_time];
    
    [formatter setDateFormat:@"MM-dd HH:mm"];
    _time.text = [formatter stringFromDate:handleTime];
//    _starTime.text = [formatter stringFromDate:handleTime];
}


@end
