//
//  toDoHeadView.m
//  ezhayan
//
//  Created by ChenFengbo on 15/10/29.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import "toDoHeadView.h"

@interface toDoHeadView ()
{
    BOOL _isOpen;
}

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *important;

@end

@implementation toDoHeadView

- (void)awakeFromNib
{
    _isOpen = NO;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didBgView:)];
    [_bgView addGestureRecognizer:tap];
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

- (void)setModel:(todoWilldoListModel *)model
{
    _model = model;
    _time.text = [NSString stringWithFormat:@"来自：%@",model.clientName];
    _nickName.text = model.name;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

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
