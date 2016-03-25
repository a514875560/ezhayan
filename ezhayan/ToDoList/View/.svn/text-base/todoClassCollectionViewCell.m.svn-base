//
//  todoClassCollectionViewCell.m
//  ezhayan
//
//  Created by ChenFengbo on 16/2/23.
//  Copyright © 2016年 ChenFengbo. All rights reserved.
//

#import "todoClassCollectionViewCell.h"

@interface todoClassCollectionViewCell ()

@property (nonatomic,strong) UIButton *button;

@end

@implementation todoClassCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.button];
    }
    return self;
}

- (UIButton *)button
{
    if (_button == nil) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitleColor:[UIUtils colorWithHexString:@"#41b29c"] forState:UIControlStateNormal];
        _button.titleLabel.font = [UIFont systemFontOfSize:17];
        [_button setBackgroundImage:[UIImage imageNamed:@"flbq_ico"] forState:UIControlStateNormal];
        [_button setBackgroundImage:[UIImage imageNamed:@"classify_ico"] forState:UIControlStateSelected];
        [_button addTarget:self action:@selector(selectBut:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _button;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self.button setTitle:title forState:0];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.button.frame = self.contentView.frame;
}

- (void)selectBut:(UIButton *)sender
{
    sender.selected = !sender.selected;
    _didSelectClass();
}

@end
