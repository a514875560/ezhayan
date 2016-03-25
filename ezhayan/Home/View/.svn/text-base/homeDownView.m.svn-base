//
//  homeDownView.m
//  ezhayan
//
//  Created by ChenFengbo on 15/11/9.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import "homeDownView.h"

@interface homeDownView ()

@property (nonatomic,strong) UITapGestureRecognizer *tap;

@end

@implementation homeDownView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UITapGestureRecognizer *)tap
{
    if (_tap == nil) {
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didBackView:)];
    }
    return _tap;
}

- (void)didBackView:(UITapGestureRecognizer *)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, -216, kDeviceWidth, 216);
        self.superview.alpha = 0;
    } completion:^(BOOL finished) {
        [self.superview removeGestureRecognizer:_tap];
        [self.superview removeFromSuperview];
    }];
}

- (void)layoutSubviews
{
    [self.superview addGestureRecognizer:self.tap];
}

- (IBAction)didTimeLine:(UIButton *)sender {
    _didTimeLine();
}

- (IBAction)didChengJiu:(UIButton *)sender {
    _didMeChengJiu();
}

- (IBAction)didSetting:(UIButton *)sender {
    _didSetting();
}

- (IBAction)didToFriend:(UIButton *)sender {
    _didToFirends();
}

- (IBAction)didCloseView:(UIButton *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, -216, kDeviceWidth, 216);
        self.superview.alpha = 0;
    } completion:^(BOOL finished) {
        [self.superview removeGestureRecognizer:_tap];
        [self.superview removeFromSuperview];
    }];
}

@end
