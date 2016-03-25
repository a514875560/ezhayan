//
//  scheduleDayView.m
//  ezhayan
//
//  Created by ChenFengbo on 15/11/3.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import "scheduleDayView.h"

@interface scheduleDayView ()

@property (weak, nonatomic) IBOutlet UILabel *dateTime;


@end

@implementation scheduleDayView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    NSDate *senddate = [NSDate date];
    
    NSDateFormatter  *dateformatter = [[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"yyyy年MM月dd日"];
    
    _dateTime.text = [dateformatter stringFromDate:senddate];
}

- (IBAction)didLast:(UIButton *)sender {
}
- (IBAction)didNext:(UIButton *)sender {
}

@end
