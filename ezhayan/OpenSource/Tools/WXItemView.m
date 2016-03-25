//
//  WXItemView.m
//  项目1.1
//
//  Created by mac1 on 14-8-19.
//  Copyright (c) 2014年 冷婷. All rights reserved.
//

#import "WXItemView.h"
#import "MainViewController.h"

@implementation WXItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedTab)];
        [self addGestureRecognizer:tap];
        self.userInteractionEnabled = YES;
    }
    return self;
}

#pragma mark - getter Method
- (UIButton *)itemButton
{
    if (_itemButton == nil) {
        _itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //代理设计模式
        [_itemButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
//        _itemButton.showsTouchWhenHighlighted = YES;
        [self addSubview:_itemButton];
    }
    return _itemButton;
}

- (UILabel *)textLable
{
    if (_textLable == nil) {
        _textLable = [[UILabel alloc] initWithFrame:CGRectZero];
        _textLable.font = [UIFont boldSystemFontOfSize:13];
        _textLable.textAlignment = NSTextAlignmentCenter;
        _textLable.textColor = [UIColor whiteColor];
        _textLable.backgroundColor = [UIColor clearColor];
        [self addSubview:_textLable];
    }
    return _textLable;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _itemButton.frame = CGRectMake((self.width-26)/2, 8.5, 26, 26);
    _textLable.frame = CGRectMake(0, _itemButton.bottom+0.5, self.width, 15);
}

- (void)selectedTab
{
    if ([self.delegate respondsToSelector:@selector(didSelectItemViewWithIndex:)]) {
        [self.delegate didSelectItemViewWithIndex:self.itemButton.tag];
    }
}

#pragma mark - Action Method
- (void)click:(UIButton *)item
{
    if ([self.delegate respondsToSelector:@selector(didSelectItemViewWithIndex:)]) {
        [self.delegate didSelectItemViewWithIndex:self.itemButton.tag];
    }
}

@end
