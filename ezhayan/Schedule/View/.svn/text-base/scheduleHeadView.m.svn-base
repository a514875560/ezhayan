//
//  scheduleHeadView.m
//  ezhayan
//
//  Created by ChenFengbo on 15/11/2.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import "scheduleHeadView.h"

@interface scheduleHeadView ()
{
    BOOL _isOpen;
}

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *content;

@end

@implementation scheduleHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    _bgView.layer.cornerRadius = 5;
    _bgView.layer.masksToBounds = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didBgView:)];
    [_bgView addGestureRecognizer:tap];
}

- (void)setModel:(targetScheduleListModel *)model
{
    _model = model;
    self.content.text = model.content;
    [self setDaysAndTimes];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
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
    self.time.text = [NSString stringWithFormat:@"%@--%@",starTime,endTime];
}

- (void)didBgView:(UITapGestureRecognizer *)sender
{
    if (_isOpen) {
        _isOpen = !_isOpen;
        _didOpen(NO);
    }
    else
    {
        _isOpen = !_isOpen;
        _didOpen(YES);
    }
}

- (IBAction)didOpen:(UIButton *)sender {
    if (sender.selected) {
        sender.selected = NO;
        _didOpen(NO);
    }
    else
    {
        sender.selected = YES;
        _didOpen(YES);
    }
}

@end
